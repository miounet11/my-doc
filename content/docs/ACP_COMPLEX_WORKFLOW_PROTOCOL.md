# ACP Complex Workflow Protocol

## Purpose

Make OpenClaw capable of heavier project work by giving it a stable control pattern for:

- ACP session dispatch
- Claude Code implementation
- Codex supervision
- evidence capture
- readiness and recovery checks

## Role Split

- OpenClaw main: routing, priority, evidence, recovery
- ACP sessions: long-lived execution surfaces for agent threads when direct turn-by-turn chat is too thin
- Claude Code: bounded implementation worker
- Codex: audit, protocol repair, supervision pressure

## Default Complex Cycle

1. refresh project briefs
2. run verification gates
3. capture readiness + autonomy evidence
4. execute `architect`
5. execute `coder`
6. run Codex supervision
7. persist a cycle summary

Command:

- `scripts/projectctl.sh complex-cycle <project> <iteration> [focus]`

## ACP Defaults

ACP should be enabled for heavier work, but constrained:

- dispatch enabled
- allowed agents explicitly listed
- concurrency bounded
- delivery set to `final_only` to reduce noisy streamed chatter during coding work
- repeated session-update projections suppressed

## Canonical ACP Spawn Contract

For OpenClaw-internal ACP dispatch, treat `sessions_spawn` as a strict schema, not a free-form idea surface.

Allowed ACP fields:

- `task` (required)
- `runtime` = `"acp"` (required for ACP)
- `agentId` (recommended; required in our workflow for Claude Code / Codex targets)
- `thread` (`true|false`)
- `mode` (`run|session`)
- `cwd` (optional)
- `label` (optional)
- `streamTo` (optional; currently only use `"parent"` when explicit progress relay is needed)

Canonical rules:

- If `runtime` is omitted, the tool defaults to sub-agent runtime. ACP dispatch must therefore set `runtime: "acp"` explicitly.
- If `mode: "session"` is used, `thread` must be `true`.
- If the task is for Claude Code or Codex, the target must be a configured ACP agent id, not a prose-only harness name.
- Prefer explicit `agentId`, `mode`, and `cwd` over relying on hidden defaults.

Canonical examples:

One-shot Claude Code run:

```json
{
  "task": "Open the repo and summarize failing tests",
  "runtime": "acp",
  "agentId": "claude-code",
  "thread": false,
  "mode": "run",
  "cwd": "/Users/lu/.openclaw/workspace/projects/原始"
}
```

Persistent Codex thread:

```json
{
  "task": "Take over implementation in this repo and keep follow-up turns in the same bound session",
  "runtime": "acp",
  "agentId": "codex",
  "thread": true,
  "mode": "session",
  "cwd": "/Users/lu/.openclaw/workspace/projects/原始",
  "label": "codex-原始"
}
```

## Forbidden Patterns

These are not part of the ACP spawn contract and must be treated as invalid:

- `payload=...`
- pseudo-actions such as `task="native_host_persist"`
- partial snippets like `sessions_spawn(runtime="acp", thread=true)` without a real task surface
- channel-delivery params on `sessions_spawn` such as `target`, `channel`, `to`, `threadId`, `replyTo`, `transport`
- invented harness ids that are not configured in the live ACP allowlist

If one of these appears in a reflection, supervision note, or world-model output, treat it as doctrine drift, not as a runnable plan.

## First-Party Guardrail

Do not hand-write raw ACP spawn snippets in free prose when a validated descriptor can be emitted instead.

Preferred workflow:

1. build a descriptor with `scripts/openclaw-acp-dispatch.sh`
2. validate it
3. only then turn it into an actual `sessions_spawn` call

This prevents OpenClaw from inventing fields that the runtime does not accept.

## Evidence Rule

A complex cycle is valid only if it leaves:

- readiness output
- autonomy evidence
- autonomy guard output
- Claude worker status artifacts
- Codex supervision artifact
- orchestration summary

## Failure Rule

If readiness or autonomy guard is degraded, that is not a reason to hide the cycle.
It must still be persisted as evidence and fed into the next repair step.
