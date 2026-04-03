# OpenClaw Capability Matrix

## Categories

- Search
- Browser automation
- Memory
- IM channels
- Exec and debug
- ACP orchestration
- Proactive tasking
- Form automation
- GitHub deploy planning
- Email outbox
- Knowledge sync

## Current judgment

### Search: ready

- Built-in `web_search` exists and is visible in the tool surface.
- This is enough for real-time search in principle.
- Current shortfall:
  - no dedicated Tavily / Serper / Exa federation layer
  - quality depends on gateway-native search only

### Browser automation: partial

- OpenClaw has managed browser + browser relay capability.
- This is already materially stronger than a terminal-only agent.
- Current shortfall:
  - browser smoke is now part of readiness, but current runtime still degrades on gateway `1006` / open-snapshot failure
  - complex-cycle inherits readiness, but still lacks a project-specific browser scenario smoke

### Memory: ready

- `memory-core` is enabled.
- Evidence board, autonomy evidence, and supervision memory are now structured.
- First-party `memory-bank` indexing and search now exist.
- Current shortfall:
  - coverage is broad but still file-centric, not semantic/embedding-rich
  - session evidence still becomes flaky under some gateway `1006` conditions

### IM channels: partial

- Telegram is live.
- Tailscale remote access is live.
- Current shortfall:
  - only one real IM adapter is active
  - multi-channel async operations are not yet mature

### Exec and debug: ready

- High-permission exec exists.
- Claude Code worker protocol exists.
- Codex supervision exists.
- Current shortfall:
  - project-scale Claude workers still face provider latency / timeout risk

### ACP orchestration: partial

- ACP is configured and enabled.
- Complex-cycle orchestration exists.
- Current shortfall:
- ACP is configured more strongly than it is currently exercised
- autonomy readiness is still degraded, so ACP cannot yet be called fully stable

### Proactive tasking: ready

- First-party local queue now exists.
- It can enqueue recovery, stability, and follow-up work without user interruption.
- Current shortfall:
  - queue prioritization is still simple
  - no automatic SLA/escalation tiers yet

### Form automation: ready

- First-party form specs and execution plans now exist.
- This gives browser work a durable recipe layer instead of ad hoc clicks.
- Current shortfall:
  - selector capture is still manual after first live inspection
  - not yet auto-generated from page snapshots

### GitHub deploy planning: ready

- First-party deploy plan and release bundle tooling now exists.
- This is enough to create a repeatable deploy artifact without external deploy platforms.
- Current shortfall:
  - no remote publish step by default
  - release approval and rollback are still operator-driven

### Email outbox: ready

- First-party local outbox now exists.
- Drafts can be produced, reviewed, and rendered without sending anything off-machine.
- Current shortfall:
  - no default send adapter
  - no inbox sync

### Knowledge sync: partial

- First-party Obsidian Markdown export now exists.
- This is the right first step because it stays local and avoids SaaS coupling.
- Current shortfall:
  - no Notion or Google Workspace adapters
  - sync is one-way export, not full bidirectional merge

## Core takeaway

OpenClaw already has the major capability classes you listed.

What is still missing is not the existence of those classes, but:

- stronger runtime stability
- stronger long-term memory retrieval
- multi-channel IM breadth
- browser and ACP deeper integration into the default project workflow
- deeper prioritization and review logic on top of the new proactive queue
