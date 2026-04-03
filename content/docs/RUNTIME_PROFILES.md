# RUNTIME_PROFILES.md

Status: active runtime doctrine
Date: 2026-04-01

## Purpose
Turn OpenClaw from a skill-heavy/doctrine-heavy harness into a system with explicit execution profiles. A profile is not just tone or prompt wording; it is a bounded execution contract that shapes tool use, evidence expectations, and lifecycle behavior.

## Core Rule
When meaningful work begins, prefer selecting the clearest runtime profile before expanding execution. Skills, closure doctrine, ACP routing, and future verifier/subagent paths should bind to profiles rather than relying only on general prompt behavior.

## Profiles
### 1. `explore`
Purpose:
- understand a codebase, system, document set, runtime state, or problem surface without mutating it

Default behavior:
- read-first, map-first, hypothesis-forming
- maximize discovery while minimizing state change
- prefer broad search, file reading, structure extraction, and dependency/context mapping

Allowed posture:
- read-only unless the user explicitly asks for mutation and the task changes profile

Evidence expectations:
- paths inspected
- structure discovered
- hypotheses formed
- unknowns/gaps kept explicit

Good fits:
- repository exploration
- context recovery
- root-cause reconnaissance
- architecture understanding

### 2. `plan`
Purpose:
- convert understanding into an inspectable execution path before implementation

Default behavior:
- define success condition
- define steps, risks, blockers, verification path, and artifact targets
- create or update an execution plan when work is complex or multi-surface

Allowed posture:
- planning artifacts may be created or edited
- avoid implementation changes unless the task is re-entered under another profile

Evidence expectations:
- explicit success condition
- step sequence
- verification path tied to original ask
- risk/blocker log

Good fits:
- complex feature work
- multi-step repair work
- deploy/change plans
- ACP/subagent brief creation

### 3. `implement`
Purpose:
- produce concrete artifacts or changes that move the task forward

Default behavior:
- stay anchored to the original ask
- avoid unnecessary abstraction or scope drift
- prefer smallest effective change
- leave clear artifact evidence

Allowed posture:
- create/edit files
- run commands
- use subagents/ACP when justified

Evidence expectations:
- changed file/artifact path
- command/action performed
- implementation notes when non-obvious
- handoff to verification if the task claims success

Good fits:
- coding changes
- script/config updates
- documentation implementation
- local execution work

### 4. `verify`
Purpose:
- adversarially test whether the original ask was actually satisfied

Default behavior:
- attempt falsification, not just confirmation
- verify the strongest available surface
- require command/tool + observed output for meaningful checks
- produce an explicit verdict

Allowed posture:
- may run checks, tests, probes, readbacks, browser/device checks
- may trigger repair if a failure is found, but should preserve verification evidence first

Evidence expectations:
- original ask anchor
- checks run
- exact command/tool/action
- observed output/evidence
- `VERDICT: PASS | FAIL | PARTIAL`
- resulting honest completion level

Good fits:
- post-implementation validation
- ACP output validation
- service/app readiness checks
- public-surface confirmation

### 5. `recover`
Purpose:
- respond to blocked, degraded, inconsistent, or partially failed states with the narrowest repair loop

Default behavior:
- classify failure honestly
- preserve error evidence
- identify the smallest viable repair
- re-run only the needed verification afterwards

Allowed posture:
- may inspect state, patch issues, restart/repair when appropriate, and document blockers

Evidence expectations:
- failed check or blocker
- exact error/path/command when available
- chosen repair step
- new state after repair attempt

Good fits:
- no-reply or degraded runtime conditions
- failed verification
- broken scripts/config/runtime state
- stalled autonomous loops

### 6. `heartbeat`
Purpose:
- periodic self-maintenance that strengthens learning, guardrails, memory, or observability

Default behavior:
- read heartbeat inputs
- find one real defect or concrete improvement
- leave an inspectable artifact or return `HEARTBEAT_OK` only when nothing needs attention

Allowed posture:
- doctrine repair, memory updates, workflow tightening, targeted maintenance changes

Evidence expectations:
- source files reviewed
- defect or gap identified
- concrete action taken
- artifact left behind

Good fits:
- scheduled heartbeat prompts
- maintenance turns
- doctrine/guardrail cleanup

## Selection Heuristics
- if the task is mostly understanding -> `explore`
- if the task needs a multi-step path before change -> `plan`
- if the task needs concrete changes -> `implement`
- if the task needs proof -> `verify`
- if the task is in a failed/degraded state -> `recover`
- if the task is a periodic self-check -> `heartbeat`

## Transition Rules
- `explore` may feed `plan` or `implement`
- `plan` should usually precede complex `implement`
- `implement` should not claim success without `verify` when meaningful validation is possible
- `verify` failure should transition to `recover`, not to optimistic closure
- `recover` should return to `verify` when the repair is meaningful
- `heartbeat` may invoke any other profile briefly, but must remain maintenance-scoped

## Binding Rule
Skills, closure surfaces, and future subagent/ACP routes should gradually bind to one primary profile. If a skill spans multiple profiles, it should say so explicitly.

## Guardrail
A profile is not just a label. If tool posture, evidence contract, and lifecycle expectations do not change, then the profile has not actually been installed.
