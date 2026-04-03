# Decisions

## ADR-001: 原始事件不可修改
Date: 2026-03-07
Status: Accepted

### Decision
所有输入端内容都先落为不可篡改的原始事件，再附加注释层。

### Why
否则未来无法区分“事实”与“后来解释”。

## ADR-002: 注释必须版本化
Date: 2026-03-07
Status: Accepted

### Decision
认知提升后允许重新注释旧对话，但保留 supersedes 链。

### Why
这个项目的核心价值就是持续理解和持续纠偏。

## ADR-003: OpenClaw orchestrates, Claude Code builds
Date: 2026-03-07
Status: Accepted

### Decision
OpenClaw 负责项目编排、标准、验证、部署；Claude Code 负责具体实现和局部重构。

### Why
这样才能稳定形成长期工程闭环。
