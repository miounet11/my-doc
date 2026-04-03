# HARNESS_ENGINEERING_UPGRADE_PLAN.md

Status: active upgrade plan
Date: 2026-03-31
Source inspiration: OpenAI harness engineering article (external reference, read 2026-03-31)

## Purpose
Upgrade OpenClaw from a harness doctrine set into a more enforced agent-first engineering environment. The key shift is from "having rules" to "embedding constraints, maps, feedback loops, and maintenance tasks directly into the workspace so agents can operate reliably at scale."

## Core Lessons Adapted
### 1. Map, not encyclopedia
AGENTS/bootstrap docs should stay short and routing-oriented.
Large guidance should live in structured docs, skills, templates, and references.

### 2. Constraints beat taste-only prompting
Important invariants should be encoded into docs, checklists, skills, scripts, templates, and where possible runtime checks.

### 3. Plans are first-class artifacts
Complex work should produce versioned execution plans and decision logs rather than living only in chat.

### 4. Agent-readable environment matters
If knowledge, constraints, or evaluation surfaces are not available inside the workspace/runtime, the agent effectively cannot use them.

### 5. Continuous garbage collection matters
Drift, stale docs, weak routing, and low-value support assets should be reviewed and cleaned continuously instead of waiting for major breakdowns.

## Upgrade Tracks
### Track A: Knowledge Map Discipline
Goal:
- keep startup docs compact
- keep deeper doctrine in indexed docs
- reduce prompt bloat while increasing navigability

Actions:
1. keep `AGENTS.md` as a map, not a giant manual
2. treat `docs/HARNESS_INDEX.md` as the routing table
3. keep support assets in docs, not as fake standalone skills
4. maintain `docs/HARNESS_ASSET_REGISTRY.md` as the inventory of live harness assets

### Track B: First-Class Execution Plans
Goal:
- make complex work inspectable beyond chat

Actions:
1. add an execution-plan template for complex work
2. require plan files for multi-step or multi-surface tasks
3. record decisions, blockers, and verification path in the plan

Current state:
- `docs/TASK_TEMPLATE_EXECUTION_PLAN.md` now exists
- next leverage is enforcing actual use of plan files during complex work, not merely keeping the template available

### Track C: Verification Surface Expansion
Goal:
- ensure high-risk task categories have dedicated closure skills and honest verification paths

Current completed surfaces:
- heartbeat closure
- general task closure
- mydoc publish verification
- context recovery
- ACP task closure
- GitHub delivery closure
- deploy readiness
- outbound message/public send closure
- node/device action verification
- cron/reminder execution closure
- gateway/config change closure

Next candidate surfaces:
- none in this category right now; keep this list evidence-based and only add surfaces not yet installed

### Track D: Harness Garbage Collection
Goal:
- continuously clean drift and low-value sprawl

Actions:
1. periodically review `HARNESS_ANTI_PATTERNS.md`
2. use `HARNESS_REVIEW_LOOP.md` plus `skills/harness-review/SKILL.md`
3. keep support assets from inflating into fake skills
4. review low-value or duplicate assets and merge/archive them

Current state:
- `skills/harness-gardening/SKILL.md` already exists
- next leverage is running/embedding the ritual consistently and reconciling plan docs when installs land

### Track E: Agent-Readable Feedback Loops
Goal:
- make the system easier for agents to inspect directly

Actions:
1. keep readiness/audit docs compact and machine-readable in structure
2. preserve evidence-rich daily memory entries
3. make blockers, degraded states, and completion levels explicit in artifacts
4. prefer local files and inspectable state over hidden conversational memory

## Immediate Concrete Upgrades
### 1. Enforce actual use of the complex-work execution-plan template
Reason:
- the template exists, but leverage comes only when complex tasks produce inspectable plan artifacts

### 2. Reframe completed closure-surface creation from build work into maintenance work
Reason:
- these closure skills now exist; the next job is routing discipline, drift detection, and evidence-based updates rather than re-creating them

### 3. Operationalize the harness gardening ritual
Reason:
- the ritual skill exists, but it must be used to keep routing, inventories, and upgrade plans aligned over time

## Guardrail
Do not mistake more documents for more leverage. The real standard is:
- smaller startup map
- clearer routing
- stronger verification
- more inspectable plans
- recurring cleanup of drift
