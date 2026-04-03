# ACP / ACPX Integration Protocol

## Purpose
Define how OpenClaw should use ACP and acpx as a stable external coding-agent execution plane instead of ad hoc PTY-style delegation.

## Layer Model
### OpenClaw
Role:
- control plane
- routing
- evidence interpretation
- memory and retrospective closure
- final judgment

### ACP
Role:
- protocol layer for structured communication with external coding harnesses

### acpx
Role:
- command/session plane for ACP-backed coding agents
- persistent sessions
- named sessions
- queueing
- status/history/close/cancel
- structured JSON output

## Core Principle
OpenClaw should orchestrate ACP sessions, not emulate a terminal multiplexer.
acpx should be the preferred command surface when stable ACP-backed coding-agent execution is needed.

## When To Use ACP
Prefer ACP/acpx when:
- the task needs an external coding harness (Codex / Claude / Gemini / etc.)
- the work benefits from persistent sessions
- structured output/status/history is important
- PTY scraping would be fragile

Prefer subagents when:
- sandbox-enforced execution is required
- work should remain fully OpenClaw-native
- ACP host-runtime restrictions would block the task

## Known Constraint
ACP sessions run on the host runtime, not inside the OpenClaw sandbox.
Therefore sandboxed requester sessions cannot directly spawn ACP sessions.

## Agent Identity Rule
Human names and formal ACP target ids must be normalized.

Examples of alias normalization:
- `codex` -> `codex`
- `claude` / `claudecode` / `claude-code` -> one canonical configured ACP id
- `gemini` -> `gemini`

OpenClaw should resolve aliases before attempting spawn.

## Preflight Before ACP Spawn
Before attempting ACP spawn, check:
1. Is current requester sandboxed?
2. Is `runtime:"acp"` allowed on this path?
3. Is the requested agent id allowed/configured?
4. Is the ACP backend configured?
5. Is ACPX non-interactive permission policy compatible with the requested work?
6. Is the target mode (`run` / `session` / `thread`) supported on the current channel/surface?
7. Is cwd valid for the requested runtime?

If preflight fails, OpenClaw should return the exact failure class instead of a generic spawn failure.

### ACPX Permission Rule

For non-interactive coding work that may write files or execute shell commands, ACPX should be configured with:

- `plugins.entries.acpx.config.permissionMode = "approve-all"`
- `plugins.entries.acpx.config.nonInteractivePermissions = "fail"`

Reason:

- ACP sessions have no interactive TTY for approval prompts.
- If `permissionMode` remains at the default read-only posture, write/exec requests can fail mid-run with `AcpRuntimeError` even when ACP dispatch itself is healthy.

Operational judgment:

- `approve-all` + successful bounded write smoke = unrestricted ACPX coding surface
- missing/other `permissionMode` = `permission-blocked` risk
- `nonInteractivePermissions = "deny"` may be useful for graceful degradation, but it is not equivalent to a full-permission coding surface

## Surface Routing Rule

Do not treat all ACP-capable surfaces as equivalent.

Current default routing:

- Telegram requester surface:
  - treat Telegram primarily as the intake surface for user requests, requirements, and completion updates
  - do not make Telegram thread continuity a prerequisite for coding throughput when host-side ACPX is available
  - default execution to host-side ACPX for real writable repo work
  - only test Telegram ACP thread continuity when specifically validating that channel behavior
- Host-side or other session-capable requester surface:
  - use `mode: "session"` with `thread: true` when durable follow-up continuity is actually needed
  - otherwise still prefer bounded `mode: "run"` for isolated tasks

This distinction is important because `write access available` and `thread/session binding supported` are separate facts and must not be merged into one generic "ACP permission" diagnosis.

## Execution Best Practice
For current OpenClaw operations, the default high-efficiency path is:

1. user gives requirements over Telegram
2. OpenClaw normalizes and records the task
3. host-side ACPX executes the real coding work
4. OpenClaw returns summarized progress/results back over Telegram

This keeps communication and execution decoupled and prevents IM-channel edge cases from dominating engineering decisions.

## ACP Failure Classes
- `sandbox-blocked`
- `agent-not-allowed`
- `backend-missing`
- `permission-blocked`
- `binding-unsupported`
- `cwd-invalid`
- `backend-unhealthy`
- `spawn-rejected`
- `flaky`

## acpx As Preferred Command Surface
acpx should be preferred because it provides:
- persistent repo-scoped sessions
- named parallel sessions
- queue-aware prompts
- cooperative cancel
- structured JSON output
- status/history/session inspection
- runtime session ids

These are exactly the features OpenClaw needs for evidence-first orchestration.

## ACPX Binary Resolution Rule
Do not hardcode a repo-relative ACPX path such as `./extensions/acpx/node_modules/.bin/acpx` unless OpenClaw is actually running from a source checkout with that layout.

Current best practice:
- first honor `ACPX_CMD` when it points to a valid executable
- otherwise resolve from the installed OpenClaw package root, for example:
  - `$(npm root -g)/openclaw/extensions/acpx/node_modules/.bin/acpx`
- keep a workspace helper for this resolution so smoke tests and repair scripts do not drift

Reason:
- this host uses a global OpenClaw install layout, not a repo-local extension layout
- the wrong assumption creates fake `acpx missing` incidents even when ACPX is installed and healthy

## Schema Mapping
When ACP/acpx is used, OpenClaw should map session/runtime data into worker artifacts such as:
- `execution_surface: "acp-session"`
- `agent_id`
- `runtime_session_id`
- `probe_status`
- `outcome_class`
- `artifact_paths`
- `openclaw_review_status`
- `openclaw_judgment`
- `next_action`

## Schema Mapping
When ACP/acpx is used, OpenClaw should map session/runtime data into worker artifacts such as:
- `execution_surface: "acp-session"`
- `agent_id`
- `runtime_session_id`
- `probe_status`
- `outcome_class`
- `artifact_paths`
- `openclaw_review_status`
- `openclaw_judgment`
- `next_action`

## Completion Return Path Rule
Completion-return-path is mandatory.

An ACP run is not fully closed merely because the external session finished. It is only closed when the requester-facing communication path is also defined and, ideally, confirmed.

OpenClaw should treat these as separate checks:
- internal execution completion
- requester-channel completion return

If an ACP session finishes but no requester-channel completion can be sent or resolved, the run must not be described as fully closed.

Preflight should therefore include completion-return-path readiness whenever a requester-visible task is delegated.

## Boundary Rule
OpenClaw should not manage low-level adapter lifecycle details unless necessary.
OpenClaw should choose, observe, and interpret.
acpx should manage queue/session mechanics.

## Operational Goal
Make ACP/acpx a first-class, evidence-friendly execution surface in the same governance family as:
- `sandbox-restricted`
- `host-direct`
- `worker-claude`
- `acp-session`
- `browser-relay`
- `remote-node`

## Success Condition
ACP/acpx integration is healthy when:
- OpenClaw can resolve requested harnesses reliably
- preflight blocks are classified clearly
- structured acpx output feeds evidence and status artifacts
- persistent external sessions are governed without PTY scraping
- Codex / Claude Code remain powerful hands, while OpenClaw retains brain control
