# Architecture Boundaries - 原始

## 问题

Iteration 1-15 已经实现了完整的五层模型，但模块间依赖隐式，数据流边界模糊，重注释机制未实现。

## 解决方案

定义清晰的架构边界，通过 Protocol 和 ABC 显式声明接口契约。

## 五层边界

### 1. Storage Boundary（存储边界）

**职责**：不可变事件持久化和读取

**接口**：
- `EventReader`: 只读事件访问
- `EventWriter`: 只写事件持久化
- `AnnotationReader`: 只读注释访问（含版本链查询）
- `AnnotationWriter`: 只写注释持久化

**实现**：
- `JsonlEventStore`
- `JsonlAnnotationStore`

**约束**：
- Event 一旦写入不可修改
- Annotation 通过 supersedes 链维护版本
- 存储层不包含业务逻辑

### 2. Computation Boundary（计算边界）

**职责**：事件 → 注释 → 画像 → 复盘的转换逻辑

**接口**：
- `Annotator`: 注释生成策略（抽象基类）
- `ProfileBuilder`: 画像合成策略（抽象基类）
- `RetrospectiveBuilder`: 复盘合成策略（抽象基类）

**当前实现**：
- `annotate.py`: 基于关键词的简单注释器（`SimpleAnnotator(Annotator)`）
- `profile.py`: 基于加权统计的画像生成器（`SimpleProfileBuilder(ProfileBuilder)`）
- `retrospect.py`: 基于 Counter 的复盘生成器（`SimpleRetrospectiveBuilder(RetrospectiveBuilder)`）

**Pipeline 集成状态**：
- ✅ `SimplePipelineOrchestrator` 通过注入的 `SimpleAnnotator` 调用注释
- ✅ `SimplePipelineOrchestrator` 通过注入的 `SimpleProfileBuilder` 调用画像
- ✅ `SimplePipelineOrchestrator` 通过注入的 `SimpleRetrospectiveBuilder` 调用复盘
- ✅ 渲染逻辑由各模块单一定义，Pipeline 不重复实现

**扩展点**：
- 未来可替换为 LLM-based annotator
- 未来可替换为 embedding-based profiler
- 未来可替换为 graph-based retrospective

### 3. Service Boundary（服务边界）

**职责**：编排完整 pipeline，对外提供 API

**接口**：
- `PipelineOrchestrator`: 编排策略（抽象基类）
- `PipelineContext`: 不可变执行上下文
- `PipelineResult`: 不可变执行结果

**当前实现**：
- `pipeline.py`: 简单顺序编排，支持 DI 和 stage gating
- `service.py`: HTTP API 封装

**DI 支持**（Iteration 19）：
- `SimplePipelineOrchestrator` 接受可选的 `Annotator`, `ProfileBuilder`, `RetrospectiveBuilder`
- 默认使用 Simple* 实现，向后兼容
- 通过 `PipelineContext.skip_stages` 控制阶段执行

**扩展点**：
- 未来可支持并行编排
- 未来可支持增量更新
- 未来可支持流式处理

### 4. Re-annotation Boundary（重注释边界）

**职责**：认知升级后的批量重注释

**接口**：
- `CognitionUpgrade`: 认知升级事件
- `ReAnnotationStrategy`: 重注释策略（抽象基类）

**当前状态**：
- ✅ Schema 已定义（Annotation.supersedes）
- ✅ `SimpleReAnnotationStrategy` 已实现
- ✅ `reannotate.py` 模块已实现
- ✅ `make reannotate` 命令可用

### 5. Adapter Boundary（适配器边界）

**职责**：多输入端格式统一

**接口**：
- `SourceAdapter`: 适配器基类

**当前实现**：
- `ClaudeCodeAdapter`
- `CodexHistoryAdapter`
- `VSCodeChatAdapter`
- `OpenClawCronAdapter`
- `OpenClawTextLogAdapter`
- `ConversationLoggerAdapter`

**约束**：
- 所有适配器输出统一 Event schema
- 适配器不包含注释逻辑

## 数据流

```
Input Sources
    ↓ (adapters)
Event (immutable)
    ↓ (annotator)
Annotation v1
    ↓ (cognition upgrade)
Annotation v2 (supersedes v1)
    ↓ (profile builder)
Profile Snapshot
    ↓ (retrospective builder)
Retrospective Report
    ↓ (memory integration)
Long-term Memory
```

## 依赖方向

```
Service Layer (pipeline, service)
    ↓
Computation Layer (annotate, profile, retrospect)
    ↓
Storage Layer (storage)
    ↓
Schema Layer (schemas, boundaries)
```

## 为什么这样设计

### 1. 显式接口契约

通过 Protocol 和 ABC 显式声明接口，让模块间依赖可见、可测试、可替换。

### 2. 不可变上下文

`PipelineContext` 和 `PipelineResult` 都是 frozen dataclass，避免隐式状态修改。

### 3. 策略模式

`Annotator`、`ProfileBuilder`、`RetrospectiveBuilder` 都是抽象基类，支持未来替换实现。

### 4. 单向依赖

上层依赖下层，下层不依赖上层，避免循环依赖。

### 5. 重注释作为一等公民

`ReAnnotationStrategy` 和 `CognitionUpgrade` 显式建模认知升级过程，这是原始项目的核心价值。

## 如何帮助 OpenClaw

### Memory

清晰的边界让 OpenClaw 理解：
- 哪些是事实（Event）
- 哪些是解释（Annotation）
- 哪些是合成（Profile/Retrospective）

### Decomposition

抽象基类让 OpenClaw 学会：
- 如何拆解复杂任务为策略接口
- 如何定义最小可替换单元

### Routing

`PipelineContext` 让 OpenClaw 学会：
- 如何传递执行上下文
- 如何根据 context 路由到不同策略

### Judgment

`should_reannotate` 和 `should_trigger` 让 OpenClaw 学会：
- 如何判断是否需要重新处理
- 如何避免无效计算

### Self-correction

`CognitionUpgrade` 和 `ReAnnotationStrategy` 让 OpenClaw 学会：
- 如何显式建模自我提升
- 如何批量修正旧判断

## 下一步

1. ~~实现 `reannotate.py` 模块~~ ✅
2. ~~重构 `pipeline.py` 使用 `PipelineContext`~~ ✅
3. ~~重构 `annotate.py` 继承 `Annotator`~~ ✅
4. ~~Pipeline 使用 Builder 实例而非 legacy 函数~~ ✅
5. ~~添加 `Annotator` 可替换性测试（mock annotator 注入 pipeline）~~ ✅ Iteration 19
6. 引入 `BuildResult` 结构化返回值（可选）
7. ~~支持 pipeline 阶段跳过（context-driven stage gating）~~ ✅ Iteration 19
8. 添加 LLM-based Annotator 实现（利用 DI 热替换）
