你是 Claude Code，当前项目是 原始。

项目定位：长期记录并理解 Lu 的多输入端对话，通过持续注释、重注释、复盘和记忆回灌不断提升协作质量。
当前迭代：Iteration 17/10

你必须遵守：
1. 原始事件不可篡改。
2. 注释必须版本化，允许 supersede，不允许覆盖事实。
3. 每次迭代都要留下可验证产物。
4. 保持向后兼容。

本轮目标：
- 根据当前项目状态，完成最有价值的一轮工程升级。
- 优先改善多输入采集、事件 schema、注释协议、复盘生成、长期理解画像中的一个或多个。
- 输出修改摘要、测试方式、下一轮建议。

上下文摘要：
[README]
# 原始

## 使命
把每一个输入端的对话和内容记录下来，并通过持续注释、复盘、重解释、长期记忆回灌，逐步形成对 Lu 的真实理解。

这不是单纯的聊天日志项目。
这是一个长期理解工程。

## 五层模型
1. 输入层：采集 CLI、Claude Code、OpenClaw、Web、Telegram 等输入端对话。
2. 事件层：把原始内容按时间线持久化，保留不可篡改的原始记录。
3. 注释层：给每条对话写语义标签、意图判断、情绪上下文、任务状态、长期价值。
4. 重注释层：随着模型能力提升，对旧对话重新标注并保留版本历史。
5. 复盘层：按主题、阶段、关系、目标生成长期理解和行动建议。

## 项目目标
- 永远保留原始对话事实。
- 不断提升对 Lu 的理解质量。
- 每轮认知升级后重新回看旧对话。
- 为 OpenClaw 和 Claude Code 提供统一理解底座。
- 支持后续部署到服务器，持续自动运行。

## 初始范围
- 统一多输入端事件格式。
- 定义注释格式和版本机制。
- 定义长期人物画像和需求画像。
- 定义复盘任务和周期。
- 让 OpenClaw 和 Claude Code 围绕同一项目反复迭代。

## 命令
- 开发：`make dev`
- 测试：`make test`
- 烟测：`make smoke`
- 项目诊断：`../../scripts/projectctl.sh doctor 原始`
- Claude Code 迭代简报：`../../scripts/projectctl.sh brief 原始 1`

## 目录
- `src/`：核心代码
- `data/events/`：原始事件
- `data/annotations/`：注释结果与版本
- `data/profiles/`：对 Lu 的阶段性理解画像
- `data/retrospectives/`：复盘与认知升级记录
- `docs/`：产品、架构、注释协议、运行手册


[PRD]
# PRD - 原始

## 核心问题
普通日志系统只会存内容，不会持续理解人，也不会随着能力提升反过来修正旧判断。

## 产品定义
原始是一个“对话事实 + 注释版本 + 认知复盘”的长期系统。

## 用户价值
- 所有输入端对话统一入库。
- 每条对话都能带注释、标签、上下文判断。
- 后续认知提升后可以重新解释旧内容。
- 形成长期可复盘的人物理解与协作方法论。

## 核心对象
1. Event：原始对话事件，不可修改。
2. Annotation：基于某一时刻认知写下的解释，可多版本。
3. Profile Snapshot：某一阶段对 Lu 的理解快照。
4. Retrospective：对一段时期的复盘和改进结论。
5. Action Insight：从理解中提炼出的协作建议。

## 验收标准
- 能采集多输入端对话。
- 能给单条对话附加结构化注释。
- 能记录注释版本和注释来源。
- 能按时间段生成复盘。
- 能把复盘结果回写到长期记忆系统。


[ARCHITECTURE]
# Architecture - 原始

## Pipeline
1. Ingest
2. Normalize
3. Store immutable events
4. Annotate current interpretation
5. Re-annotate when cognition improves (see BOUNDARIES.md)
6. Synthesize retrospective
7. Update long-term memory

## Architecture Boundaries

See `docs/BOUNDARIES.md` for detailed boundary definitions.

- Storage Boundary: EventReader/Writer, AnnotationReader/Writer
- Computation Boundary: Annotator, ProfileBuilder, RetrospectiveBuilder
- Service Boundary: PipelineOrchestrator, PipelineContext, PipelineResult
- Re-annotation Boundary: CognitionUpgrade, ReAnnotationStrategy
- Adapter Boundary: SourceAdapter

## Storage Model
- `data/events/*.jsonl`：原始输入事件
- `data/annotations/*.jsonl`：事件注释版本
- `data/profiles/*.md`：阶段性用户理解画像
- `data/retrospectives/*.md`：周期复盘报告

## Event Schema
- `event_id`
- `timestamp`
- `source`
- `channel`
- `speaker`
- `content`
- `conversation_id`
- `metadata`

## Annotation Schema
- `annotation_id`
- `event_id`
- `created_at`
- `annotator`
- `cognition_version`
- `summary`
- `intent`
- `emotion`
- `importance`
- `actionable_need`
- `confidence`
- `supersedes`

## Design Constraints
- 原始事件不可覆写。
- 注释必须版本化。
- 每次认知升级允许批量重注释。
- 复盘必须引用事件和注释证据。


[ANNOTATION_PROTOCOL]
# Annotation Protocol - 原始

## 注释原则
- 注释不是改写事实。
- 注释必须和原始事件分离。
- 低置信度判断必须显式标记。
- 新认知不能覆盖旧认知，只能 supersede。

## 每条对话至少可标注
- `intent`：用户诉求是什么
- `emotion`：情绪或语气
- `priority`：P0 / P1 / P2
- `theme`：主题
- `insight`：这条话让系统学到了什么
- `follow_up`：后续动作

## 复盘触发条件
- 连续对话达到一定规模
- 出现重大目标变化
- 出现明显误解或修正
- 系统能力升级后


当前关注点：
[
  "multi-input capture",
  "semantic annotation",
  "re-annotation after cognition upgrades",
  "retrospective synthesis",
  "long-term user understanding",
  "vscode chat capture",
  "claude code session import",
  "openclaw log import",
  "balanced multi-source ingest",
  "annotation version chain",
  "claude code iteration briefs",
  "windsurf discovery",
  "profile snapshots",
  "source-balance tuning",
  "claude squad briefs",
  "parallel role orchestration",
  "openclaw orchestrated multi-agent loops",
  "deployable service layout",
  "pipeline audit",
  "final review",
  "service smoke fallback"
]

严格执行：
1. 先阅读项目核心文件。
2. 做最小但实质性的改动。
3. 如果新增结构，补文档和脚本。
4. 明确说明这轮如何帮助 OpenClaw 学会更强的 memory / decomposition / routing / judgment / self-correction。
5. 给出下一轮无需人工催促也应该继续推进的事项。
6. 结束时输出：Iteration 17 complete for 原始

角色附加要求：
- 只关注 user-signal extraction、source weighting、profile quality
- 目标是让画像更像 Lu，而不是更像系统日志
- 优先处理用户直说内容的提纯与权重
