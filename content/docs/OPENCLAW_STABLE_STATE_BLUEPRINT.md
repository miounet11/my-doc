# OpenClaw Stable State Blueprint

## Status

This file remains the detailed target-state reference for runtime maturity and supervision shape.

Current baseline doctrine now lives in:

- `docs/OPENCLAW_BEST_PRACTICES.md`
- `docs/OPENCLAW_OPERATING_CHECKLIST.md`

Use this file for:

- stable-state architecture
- runtime target properties
- supervision and recovery direction
- maturity-path planning

If this file conflicts with newer doctrine, the newer doctrine wins.

## Non-Negotiable Constraint

- The primary model stays exactly as configured today.
- Do not redesign the system around replacing the main model.
- All upgrades must improve reliability, supervision, recovery, training, and execution discipline around the existing main model.

## Objective

Build OpenClaw into a stable operating system for long-term project development:

- stable enough to run daily
- strong enough to supervise real implementation
- observable enough to debug quickly
- disciplined enough to learn from failures
- recoverable enough to survive provider instability

## Target State

### 1. Runtime Layer

- Gateway stays on `loopback`
- Remote access uses `tailscale serve`
- Auth stays enabled (`token`, with Tailscale identity allowed)
- Local CLI usability must never be sacrificed for remote access

### 2. Execution Layer

- Every project task runs through a state machine
- Every worker has:
  - a brief
  - a live status file
  - a heartbeat stream
  - an attempts log
  - a reflection artifact
- No "generated brief = work happened" ambiguity is allowed
- Compaction is treated as part of execution reliability, not a background detail:
  - preserve a small window of recent turns
  - re-inject the critical AGENTS sections after compaction
  - keep the active context engine explicit instead of relying on silent defaults

### 3. Supervision Layer

- OpenClaw owns:
  - routing
  - judgment
  - memory
  - self-correction
- Claude Code stays a worker
- Codex stays a systems teacher, auditor, and repair tool

### 4. Learning Layer

- Every meaningful failure must create one of:
  - a detection rule
  - a retry policy
  - a protocol update
  - a memory entry
  - a script improvement
- Docs without enforcement do not count as learning
- Session introspection must improve:
  - use structured session inspection instead of guessing from partial logs
  - prefer runtime evidence over narrative summaries

### 5. Availability Layer

- Provider instability is assumed normal
- Timeouts are retried automatically
- Failures are classified, not hand-waved
- The system should degrade gracefully:
  - probe works even if long worker fails
  - local gateway works even if remote access has issues
  - project cycle writes partial evidence before failing

## Stable Defaults

### Network

- `gateway.bind = loopback`
- `gateway.tailscale.mode = serve`
- `gateway.auth.mode = token`
- `gateway.auth.allowTailscale = true`

### Execution

- Project work always uses:
  - `scripts/projectctl.sh run-claude`
  - `scripts/projectctl.sh cycle`
  - `scripts/projectctl.sh complex-cycle`
- Direct long-running Claude invocations are discouraged unless wrapped by policy
- Default compaction stance:
  - `agents.defaults.compaction.mode = safeguard`
  - `agents.defaults.compaction.recentTurnsPreserve` should stay explicitly configured
  - `agents.defaults.compaction.postCompactionSections` should explicitly preserve the AGENTS sections that define startup and safety behavior

### Monitoring

- Run `scripts/openclaw-readiness.sh` before major project sessions
- Treat failed readiness as an operational issue, not a model issue
- Use session-level evidence when diagnosing drift:
  - gateway status
  - worker status/heartbeat/attempts
  - session inspection when available
- Readiness must include behavior quality, not just process liveness:
  - add an autonomy guard that detects repeated prompts, empty session surfaces, and degraded session evidence

### ACP

- ACP should be enabled only with bounded agent allowlists and bounded concurrency.
- ACP is for durable complex work surfaces, not for replacing OpenClaw judgment.
- Prefer `final_only` streamed delivery when the task is implementation-heavy and high-chatter output would hurt focus.

### Heartbeats

- Main heartbeat protects runtime health and learning continuity
- Role heartbeats protect local quality in their domain
- A heartbeat must do one concrete thing, not just report calmness

## Upgrade Priorities

### Priority 1: Reliability

- preserve local gateway health
- preserve Tailscale remote access
- preserve deterministic worker execution
- preserve evidence even on failure

### Priority 2: Recovery

- add better auto-retry
- add worker resumption where possible
- add failure summaries that point to next action
- reduce compaction-induced drift by preserving a bounded recent-turn window

### Priority 3: Training

- turn project execution into OpenClaw learning artifacts
- reduce dependence on Codex for routine diagnosis
- force OpenClaw to reclaim routing and judgment
- move stable static guidance into system-context space when plugin support is used
- keep prompt injection disabled by default unless a plugin is explicitly audited

### Priority 4: Scale

- support multiple projects without losing state clarity
- keep project loops isolated but reviewable
- make readiness and health checks fast

## Anti-Patterns

- changing the main model to mask systems problems
- treating docs as progress without protocol enforcement
- sacrificing local usability for remote convenience
- claiming "success" from a generated plan without execution artifacts
- letting Codex carry OpenClaw's brain functions for too long
- enabling prompt-mutating plugin hooks by default without a specific audit trail
- switching away from the legacy context engine before the current evidence board and supervision loop are stable

## Maturity Path

### Phase 1: Stable

- gateway healthy
- tailscale healthy
- worker protocol enforced
- readiness check green

### Phase 2: Self-Supervising

- OpenClaw notices failed workers on its own
- OpenClaw restarts or reroutes without waiting
- supervision artifacts accumulate automatically

### Phase 3: Self-Improving

- repeated failures become scripts, checks, or policy changes
- OpenClaw updates prompts and loops based on evidence
- Codex is needed less often for runtime repair

## Acceptance Criteria

The system can be called stable and strong when:

- local gateway is healthy every day
- Tailscale remote access works without breaking local CLI
- Claude workers leave structured artifacts on both success and failure
- project cycles can continue through transient provider instability
- OpenClaw improves its own process instead of only producing output
- compaction does not silently erase startup/safety discipline
- plugin/system-context features are used deliberately, not as uncontrolled prompt noise
