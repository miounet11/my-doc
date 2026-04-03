# OpenClaw Current Architecture And Operating Logic

Date: 2026-03-16

## 1. Executive Summary

OpenClaw is currently running in a stable split-mode architecture:

- Telegram is the intake surface.
- OpenClaw is the control plane and judgment layer.
- Host-side ACPX is the writable execution plane.
- Memory files and the memory plugin are the continuity layer.
- Heartbeat and autonomy loops keep the system active without noisy cron spam.

This is the current best-practice operating model. The system is optimized for a trusted single-operator environment, not for hostile multi-tenant exposure.

## 2. Current Verified Runtime Status

Verified on 2026-03-16:

- `bash scripts/openclaw-readiness.sh` -> `overall=ok`
- `python3 scripts/openclaw-autonomy-guard.sh 5` -> `overall=ok`
- `python3 scripts/openclaw-capability-audit.sh` -> `runtime_health=ok`, `acp_orchestration=ready`, `im_channels=ready`
- `openclaw status --json` shows the restored heartbeat schedule is live

Operational conclusion:

- OpenClaw is healthy enough for continuous development work.
- ACPX is healthy enough for sustained non-interactive write and exec tasks.
- Telegram should be treated as communication only, not as the durable execution surface.

## 3. Simple Architecture

```text
User / Telegram
    ->
OpenClaw Main
    ->
Specialist Agents (architect / coder / tester / reviewer / optimizer / evolution / goal-manager / world-model)
    ->
Host-side ACPX execution (codex / claude-code)
    ->
Repository / files / commands / artifacts
    ->
Verification + memory + return summary
```

Layer meaning:

- Intake layer:
  - Telegram receives user requests and returns progress/results.
- Control layer:
  - `main` decides routing, supervises work, and keeps the final judgment.
  - specialist agents help with decomposition, review, testing, optimization, and reflection.
- Execution layer:
  - `codex` and `claude-code` run as ACPX-backed persistent external coding agents.
- Continuity layer:
  - `MEMORY.md`, `memory/YYYY-MM-DD.md`, and the memory plugin preserve context.
- Supervision layer:
  - readiness probes, autonomy guard, capability audit, heartbeats, and evidence scripts verify the system is actually working.

## 4. Current Configuration

### 4.1 Models

- `main`: `openai/gpt-5.4`
- specialist local agents default: `openai/grok-420-agents`
- memory embeddings: `ollama / nomic-embed-text`
- ACPX execution surfaces:
  - `claude-code` -> ACP agent id `claude`
  - `codex` -> ACP agent id `codex`

Notes:

- OpenClaw directly pins the local control/specialist models above.
- ACPX runtime identity is pinned by agent id. The exact provider-side model for `claude` or `codex` is managed by the ACP backend, not by this workspace document.

### 4.2 ACPX Permissions And Host Execution

Current host-side execution posture:

- `plugins.entries.acpx.config.permissionMode = approve-all`
- `plugins.entries.acpx.config.nonInteractivePermissions = fail`
- `agents.defaults.sandbox.mode = off`
- `tools.exec.host = gateway`
- `tools.exec.security = full`
- `tools.fs.workspaceOnly = false`
- `acp.enabled = true`
- `acp.maxConcurrentSessions = 4`

Meaning:

- ACPX can perform sustained non-interactive write and exec work.
- OpenClaw is intentionally not sandbox-restricted on this host.
- This is efficient for a trusted operator setup, but it is not a hardened shared-user security posture.

### 4.3 Memory And Bootstrap Limits

- `bootstrapMaxChars = 12000`
- `bootstrapTotalMaxChars = 80000`
- memory search provider: `ollama`
- memory search model: `nomic-embed-text`

Meaning:

- bootstrap context is intentionally compact
- long history belongs in daily memory or docs, not in bootstrap files
- memory quality is improved by compaction and curation, not by dumping more text into startup context

### 4.4 Heartbeat Cadence

Default heartbeat policy:

- heartbeat model: `openai/grok-420-agents`
- active hours: `09:00-23:00 Asia/Shanghai`
- default target: `none`

Current per-agent heartbeat:

- `main`: `30m`
- `architect`: `2h`
- `coder`: `2h`
- `tester`: `2h`
- `reviewer`: `2h`
- `optimizer`: `2h`
- `evolution`: `2h`
- `goal-manager`: `2h`
- `world-model`: `2h`
- `mentor`: `6h`
- `goal-manager-auto`: `0m`
- `reviewer-auto`: `0m`
- `evolution-auto`: `0m`
- `claude-code`: disabled
- `codex`: disabled

Meaning:

- the main and specialist agents stay warm
- the auto agents are driven by the autonomy loop, not by periodic heartbeat spam
- ACPX execution agents are invoked deliberately, not heartbeat-polled
- the historical `loop-progress-feedback` cron remains disabled on purpose

## 5. Operating Logic

### 5.1 Default Routing Rule

Use this routing by default:

1. User sends requirement through Telegram.
2. OpenClaw main interprets the request and records context.
3. If the task is real coding work, dispatch it to host-side ACPX.
4. Use specialist agents for architecture, review, testing, decomposition, or diagnosis.
5. Verify with artifacts, readiness checks, or session evidence.
6. Write durable lessons into memory if the result should survive restart.
7. Return a concise summary back to the communication surface.

### 5.2 When To Use ACPX

Use ACPX when:

- the task writes files
- the task runs shell commands
- the task needs persistent multi-step coding sessions
- the task benefits from structured session status and auditability

Do not hardcode repo-local ACPX paths such as:

- `./extensions/acpx/node_modules/.bin/acpx`

Use the resolver/wrapper instead:

- `scripts/openclaw-acpx-path.sh`
- `scripts/openclaw-acpx.sh`
- `scripts/projectctl.sh acpx-*`

### 5.3 Bounded Task vs Persistent Session

Use a bounded run when:

- the task is short
- you want isolated execution
- you do not need follow-up continuity inside the same coding session

Use a persistent session when:

- the task spans multiple edits or reviews
- you want a durable coding thread
- you expect several follow-up prompts in the same repo context

## 6. Recommended Command Surface

### 6.1 Resolve ACPX

```bash
bash scripts/projectctl.sh acpx-path
```

### 6.2 One-Shot ACPX Execution

```bash
bash scripts/projectctl.sh acpx-exec codex /abs/project/path "Implement X with tests"
```

### 6.3 Persistent ACPX Session

```bash
bash scripts/projectctl.sh acpx-session codex my-session /abs/project/path "Continue implementing X"
```

### 6.4 Check ACPX Session Status

```bash
bash scripts/projectctl.sh acpx-status codex my-session
```

### 6.5 Run A Heavier Orchestration Cycle

```bash
bash scripts/projectctl.sh complex-cycle <project> <iteration> [focus]
```

### 6.6 Health Verification

```bash
bash scripts/openclaw-readiness.sh
python3 scripts/openclaw-autonomy-guard.sh 5
python3 scripts/openclaw-capability-audit.sh
```

## 7. Communication vs Execution Rule

This is the most important operating rule:

- Telegram is for demand intake, clarification, and result return.
- Host-side ACPX is for real engineering execution.

Why:

- the current live Telegram surface is a plain group, not a durable ACP thread-binding surface
- plain Telegram groups should not be the place where persistent coding continuity is expected
- ACPX on the host is already healthy and writable, so execution should stay there

## 8. Known Constraints And Honest Caveats

### 8.1 Telegram Constraint

- Telegram is enabled and useful as the intake channel.
- Persistent ACP continuity should not depend on a plain Telegram group.
- If a project truly needs IM-surface continuity, use a host-side ACPX session or move to a bindable IM surface.

### 8.2 Security Posture

Current posture is intentionally permissive:

- sandbox off
- full exec security
- filesystem not limited to workspace-only
- ACPX approve-all
- Telegram group access posture is still permissive and should be treated as trusted-operator only

This is fast and effective for a trusted operator workflow.
It should not be copied blindly into an untrusted or shared-user environment.

### 8.3 Status Command Caveat

`openclaw status --json` can report gateway inspection issues such as:

- `missing scope: operator.read`

That should be interpreted as an inspection/auth-scope limitation, not automatically as runtime failure.
Use the readiness and capability scripts as the real health source of truth.

## 9. Recommended Reuse Pattern For Another Project

If another project wants the same model, copy the following rules:

- keep communication and execution separated
- keep Telegram or chat tools as intake, not as the primary coding runtime
- use host-side ACPX wrappers instead of raw binary paths
- keep heartbeat moderate, not noisy
- keep auto agents autonomy-driven, not heartbeat-driven
- keep memory bootstrap compact
- verify completion with artifacts, not with narrative

## 10. Bottom Line

Current best practice is:

- chat surface for communication
- OpenClaw for control and judgment
- host-side ACPX for real coding execution
- evidence scripts for validation
- compact memory for continuity

That is the current stable and efficient OpenClaw operating shape.
