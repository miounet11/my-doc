# OpenClaw Doctrine Map

Date: 2026-03-24

## Purpose

This file tells the fork which doctrine files are baseline, which are specialized, and which should be read as supporting detail rather than primary truth.

## Primary Baseline

Read these first when asking, "what is current best practice?"

1. `docs/OPENCLAW_BEST_PRACTICES.md`
2. `docs/OPENCLAW_OPERATING_CHECKLIST.md`
3. `docs/OPENCLAW_AUTHORITY_POLICY.md`
4. `docs/OPENCLAW_FORK_DOCTRINE.md`

These four documents define:

- operating standard
- daily/elevated-change discipline
- authority boundaries
- fork identity

## Secondary Core References

Read these when the question is about system shape or runtime maturity.

- `docs/OPENCLAW_STABLE_STATE_BLUEPRINT.md`
- `docs/BRAIN_HANDS_BOUNDARY.md`
- `docs/OPENCLAW_FIRST_PARTY_STACK.md`
- `docs/OPENCLAW_CAPABILITY_MATRIX.md`

These documents refine:

- architecture shape
- control-plane versus worker boundaries
- product-surface boundaries
- capability scope

## Operational Field Manuals

Read these when actively diagnosing, repairing, or executing.

- `docs/OPERATIONAL_DOCTRINE.md`
- `docs/MYDOC_SYNC_RUNBOOK.md`
- `docs/OPENCLAW_RUNTIME_RECOVERY_2026-03-11.md`
- `docs/OPENCLAW_RUNTIME_REPAIR_2026-03-07.md`
- `docs/CODEX_SUPERVISION_LOOP.md`
- `docs/claude-execution-protocol.md`

These documents are practical and useful, but they are not the highest-level baseline.

## Intel And Learning References

Read these when evolving workflow from external signal.

- `docs/WORKFLOW_SUPERPOWERS_ABSORPTION.md`
- `docs/intel/`
- `docs/OPENCLAW_SYSTEM_OBJECTIVE_EVALUATION_V1.md`

These documents guide:

- builder-method absorption
- frontier-learning review
- evaluation changes

## Conflict Rule

If two doctrine files disagree, prefer them in this order:

1. `OPENCLAW_BEST_PRACTICES.md`
2. `OPENCLAW_OPERATING_CHECKLIST.md`
3. `OPENCLAW_AUTHORITY_POLICY.md`
4. `OPENCLAW_FORK_DOCTRINE.md`
5. specialized supporting documents

## Maintenance Rule

When a durable new lesson appears:

- update the baseline docs if it changes the operating standard
- update specialized docs if it only changes one subsystem
- avoid copying the same rule into many files without need

The doctrine set should become clearer over time, not larger by default.
