# Architecture Convergence - Iteration 17

## 问题诊断

### 当前状态
- ✅ 边界已定义：`boundaries.py` 完整定义了 5 层边界的 Protocol 和 ABC
- ✅ 实现已存在：所有核心模块都有具体实现类
- ✅ 重注释机制已实现：`reannotate.py` + `SimpleReAnnotationStrategy`
- ⚠️ **边界未完全执行**：legacy 函数绕过了边界契约

### 核心问题

#### 1. 返回值类型不一致

```python
# boundaries.py 定义
class ProfileBuilder(ABC):
    def build(self, annotations: list[dict[str, Any]], context: PipelineContext) -> dict[str, Any]: ...

# profile.py 实现
def build_profile(...) -> dict[str, object]:  # ❌ object vs Any
    ...
    return profile  # ❌ 返回裸 dict，无结构化元数据
```

#### 2. Legacy 函数绕过边界

```python
# pipeline.py
profile_result = build_profile(...)  # ❌ 调用 legacy 函数
# 应该：
builder = SimpleProfileBuilder()
profile = builder.build(annotations, context)  # ✅ 使用边界契约
```

#### 3. 返回值缺少可观察性

Legacy 函数返回业务数据，但缺少：
- 执行时长
- 成功/失败状态
- 错误信息
- 版本信息

## 解决方案

### 原则
- **最小改动**：不重写实现，只收敛边界
- **向后兼容**：保留 legacy 函数，但标记为 deprecated
- **类型安全**：统一返回值类型标注

### 具体修复

#### 1. 统一返回值类型

```python
# profile.py
def build_profile(...) -> dict[str, Any]:  # ✅ 统一为 Any
    ...
    return {
        'profile_written': True,
        'output_path': str(out),
        'profile': profile,  # 业务数据
    }
```

#### 2. Pipeline 直接使用 Builder

```python
# pipeline.py
builder = SimpleProfileBuilder()
profile = builder.build(annotations, context)
output_path = self._write_profile(profile)  # 分离 I/O
stage_trace.append(StageResult(
    stage_name='profile',
    success=True,
    output={'path': str(output_path)},
))
```

#### 3. 添加结构化返回值

```python
@dataclass(frozen=True)
class BuildResult:
    """Structured result for builder operations."""
    success: bool
    output: dict[str, Any]
    error: str | None = None
```

## 不做的事

- ❌ 不重写 `SimpleProfileBuilder` 的业务逻辑
- ❌ 不修改 Event/Annotation schema
- ❌ 不改变存储格式
- ❌ 不添加新的抽象层

## 验收标准

1. 所有 legacy 函数返回值类型统一为 `dict[str, Any]`
2. `SimplePipelineOrchestrator` 直接调用 Builder 而非 legacy 函数
3. `PipelineResult` 包含完整的 stage trace
4. 所有测试通过
5. `make smoke` 通过

## 如何帮助 OpenClaw

### Memory
- 清晰区分「业务数据」和「执行元数据」
- `PipelineResult` 是可审计的执行记录

### Decomposition
- Builder 只负责转换逻辑
- I/O 由 Orchestrator 负责
- 职责边界清晰

### Routing
- `PipelineContext` 是唯一的路由依据
- 不再通过函数参数传递配置

### Judgment
- `StageResult.success` 显式标记成功/失败
- 不再依赖异常或隐式状态

### Self-correction
- `PipelineHistoryStore` 记录每次执行
- 可对比不同 cognition_version 的结果
- 支持回溯和重放

## 下一步

1. 修复 `profile.py` 返回值类型
2. 修复 `retrospect.py` 返回值类型
3. 重构 `SimplePipelineOrchestrator` 使用 Builder
4. 添加 `BuildResult` dataclass（可选）
5. 更新 RUNBOOK.md
6. 运行 `make smoke` 验证
