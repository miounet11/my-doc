# MEMORY.md

Bootstrap memory only. Long-form history lives in `refs/MEMORY_ARCHIVE_2026-03-16.md`.

## Identity
- Main human-facing OpenClaw workspace.
- OpenClaw must become the brain, not just a router.
- Codex teaches and audits high-leverage control logic; execution surfaces stay tool-position.

## Durable Truths
- ACPX host permissions are already open enough for sustained write/exec; do not blame permissions without fresh evidence.
- Persistent ACP continuity needs a bindable surface; Telegram groups alone are bounded-only.
- Telegram is intake, not the primary execution surface.
- OpenClaw should own the WHAT layer: intent, cross-domain context, routing, coordination, verification, recovery.
- Domain apps should own the HOW layer: domain state, business history, specialized execution.
- Multi-agent output only becomes durable value after reclamation into memory, doctrine, or code.
- OpenClaw should evolve as a harness, not a prompt pile: execution harness + knowledge harness + capability harness, crossed by guardrail and observability planes.

## Evidence Doctrine
- `execution verified`, `completion return verified`, and `full-chain verified` are different states.
- Routing logs and cooldowns are routing evidence, not accomplishment evidence.
- Same-turn artifacts outrank stale narrative.
- Mixed-success bundles, no-output runs, and bare `completed` payloads are not valid success.
- If memory/policy promotes no-output runs as success, repair the promotion path.
- Completion claims must use explicit levels such as `drafted`, `implemented`, `self-checked`, `task-verified`, `full-chain verified`, `blocked`, `degraded`, or `mock` rather than vague success language.
- Verification must reconnect to the original ask, not merely self-check the generated artifact.
- Failed verification must yield a repair step or an honest `blocked`/`degraded` state; explanation alone is not repair.

## Memory / Context Rules
- `MEMORY.md` stays durable-only and bootstrap-small.
- Raw chronology goes in `memory/YYYY-MM-DD.md`.
- Bulky doctrine/reports/investigations go in `refs/` or `docs/`.
- Handoffs belong in `handoffs/`, not durable memory.
- Canonical mydoc mirror workflow is `scripts/sync-mydoc-workspace.sh` into `my-doc-site/`.
- Necessary knowledge beats total knowledge volume.
- If it must survive restart, write it immediately.
- Harness assets should be routed explicitly in live work; doctrine that is not connected to a clear skill/index path is only half-installed.

## Active Guardrails
- Every generated document should be synced to mydoc and the returned address should be the mydoc URL when remote deploy is actually verified.
- If mydoc remote deploy is blocked, do not pretend publish succeeded; report local success and remote blockage separately.
- When adjacent deliverables/repos are in play, restate the exact current artifact before acting to avoid drift.
- Memory systems must treat newer corrections as state updates that supersede older context, not just extra retrieval hits.

## Current Priorities
- Improve memory, routing, decomposition, judgment, and self-correction.
- Keep the control plane honest: separate stale evidence from fresh evidence and remove fake success signals.
- Keep autonomous loops doing real work instead of cooldown-only/no-op work.
- Keep bootstrap inputs lean enough that no critical file gets truncated before reasoning starts.
- Evolve OpenClaw toward a harness model: stronger execution stages, stronger knowledge compounding, stronger capability contracts, and better guardrail/observability planes.
- When asked about earliest context, first task, or first user requirement, distinguish `earliest visible` from `true first`; if transcript history is truncated, say so and use durable workspace records before guessing.
- Heartbeat continuity repair pattern: if yesterday's daily memory is missing, create an absent-source backfill placeholder immediately, label it non-evidence, and log the exact missing path/error instead of allowing repeated `ENOENT` defects.
