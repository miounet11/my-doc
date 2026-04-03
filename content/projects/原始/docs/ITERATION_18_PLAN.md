# Iteration 18: Pipeline Boundary Enforcement

## 诊断

### 当前状态
- ✅ 边界已定义：`boundaries.py` 完整定义 5 层边界
- ✅ 实现已存在：所有模块都有具体实现
- ✅ 测试通过：35/35 OK
- ⚠️ **边界未执行**：`SimplePipelineOrchestrator` 调用 legacy 函数，绕过 Builder 契约

### 核心问题

```python
# pipeline.py 当前实现
profile_result = build_profile(...)  # ❌ 直接调用 legacy 函数
retrospective_result = build_retrospective(...)  # ❌ 绕过 Builder 边界
```

**后果**：
- 类型契约未执行
- 无法替换实现
- 测试无法 mock Builder
- OpenClaw 无法学习边界模式

## 解决方案

### 原则
- **最小改动**：只修改 `pipeline.py`，不动其他模块
- **向后兼容**：保留 legacy 函数供外部调用
- **类型安全**：严格遵守 ABC 契约

### 修复点

#### 1. 创建 Builder 实例

```python
# profile.py
class SimpleProfileBuilder(ProfileBuilder):
    def build(self, annotations: list[dict[str, Any]], context: PipelineContext) -> dict[str, Any]:
        # 复用现有逻辑
        ...
```

#### 2. Pipeline 使用 Builder

```python
# pipeline.py
class SimplePipelineOrchestrator(PipelineOrchestrator):
    def __init__(self, project_root: Path) -> None:
        ...
        self.profile_builder = SimpleProfileBuilder()
        self.retrospective_builder = SimpleRetrospectiveBuilder()

    def run(self, context: PipelineContext) -> PipelineResult:
        # Stage 3: Profile
        profile = self.profile_builder.build(annotations, context)
        output_path = self._write_profile(profile)

        # Stage 4: Retrospect
        retrospective = self.retrospective_builder.build(annotations, context)
        output_path = self._write_retrospective(retrospective)
```

#### 3. 分离 I/O

Builder 只负责计算，Orchestrator 负责写文件。

## 不做的事

- ❌ 不修改 Event/Annotation schema
- ❌ 不改变存储格式
- ❌ 不重写业务逻辑
- ❌ 不添加新抽象层

## 验收标准

1. `SimplePipelineOrchestrator` 使用 Builder 实例
2. 所有测试通过
3. `make smoke` 通过
4. Legacy 函数保留但标记 deprecated

## 如何帮助 OpenClaw

### Memory
- 清晰区分「计算」和「I/O」
- Builder 是纯函数，可缓存可重放

### Decomposition
- Builder 只负责转换
- Orchestrator 负责编排和持久化
- 职责边界清晰

### Routing
- `PipelineContext` 是唯一路由依据
- 不再通过函数参数传递配置

### Judgment
- Builder 返回结构化数据
- Orchestrator 判断是否写入

### Self-correction
- Builder 可独立测试
- 可替换实现而不影响 Pipeline
- 支持 A/B 测试不同策略

## 产物

1. `profile.py`: 添加 `SimpleProfileBuilder(ProfileBuilder)`
2. `retrospect.py`: 添加 `SimpleRetrospectiveBuilder(RetrospectiveBuilder)`
3. `pipeline.py`: 重构 `SimplePipelineOrchestrator` 使用 Builder
4. `docs/BOUNDARIES.md`: 更新实现状态
5. 测试验证：35/35 OK
