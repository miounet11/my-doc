# Skill Maturity Registry Rules

Purpose: stop the skill registry from overstating capability after rapid skill growth.

## Required classification

Every registry entry must be explicitly tagged as one of:
- `workflow-skill`
- `system-pattern`
- `architecture-doc`
- `scaffold`

## Required maturity states

Every entry must also carry one maturity label:
- `idea`
- `documented`
- `installed`
- `runtime-verified`
- `production-proven`

## Evidence rules

- `documented` = file or doc exists, but no runtime proof yet
- `installed` = artifact is present in workspace and discoverable by registry/install surface
- `runtime-verified` = at least one real execution artifact exists
- `production-proven` = repeated successful real use with bounded failure modes

## Anti-drift guardrails

1. A new `SKILL.md` starts at `documented` unless stronger evidence exists.
2. A control policy or routing doctrine must not be listed as a `workflow-skill`.
3. Architecture references such as `docs/CANVAS_MEMORY_ARCHITECTURE.md` belong under `architecture-doc`, not skills.
4. Registry growth must never outrun runtime evidence.
5. If classification is uncertain, downgrade rather than upgrade.

## Current immediate use

Apply these rules first to:
- `skills/multi-host-ops/SKILL.md`
- `skills/research-swarm/SKILL.md`
- `skills/intel-sentinel/SKILL.md`
- `skills/model-escalator/SKILL.md`
- `skills/digital-asset-guardian/SKILL.md`
- `docs/CANVAS_MEMORY_ARCHITECTURE.md`

## Honest default mapping

- `multi-host-ops` → `workflow-skill` / `documented`
- `research-swarm` → `workflow-skill` / `documented`
- `intel-sentinel` → `workflow-skill` / `documented`
- `digital-asset-guardian` → `workflow-skill` / `documented`
- `model-escalator` → `system-pattern` / `documented`
- `CANVAS_MEMORY_ARCHITECTURE.md` → `architecture-doc` / `documented`

## Success condition

The registry becomes more trustworthy when a reader can tell:
- what is a real operational skill
- what is only a system pattern or design artifact
- what has runtime evidence versus what only has documentation
