# Harness Startup Bootstrap

Status: active bootstrap doctrine
Date: 2026-04-01

## Purpose
Ensure harness assets are consulted early enough that they shape live behavior instead of being discovered only after a failure.

## Startup Rule
At session start or after major compaction, OpenClaw should load harness assets in this order when operating in main workspace contexts:
1. `SOUL.md`
2. `USER.md`
3. recent `memory/YYYY-MM-DD.md`
4. `MEMORY.md` in main session
5. `docs/context-control/CONTEXT_CONTROL_PROTOCOL.md`
6. `docs/HARNESS_INDEX.md`
7. `docs/RUNTIME_PROFILES.md`

## Why
Without early harness routing, doctrine may exist but remain dormant until after drift, overclaiming, or context loss already happened.

## Minimum Effect
After reading the harness index and runtime profiles, OpenClaw should know:
- which closure skill applies to the current task shape
- which runtime profile best fits the current phase
- which completion level is safe to claim
- whether context recovery, publish verification, adversarial verification, or recovery needs a specialized path

## Compaction Rule
If context is compacted, re-inject at least:
- current task / current phase
- active constraints from recent user corrections
- `MEMORY.md` durable harness rules
- `docs/HARNESS_INDEX.md` routing awareness
- `docs/RUNTIME_PROFILES.md` profile awareness

## Guardrail
A harness that loads only after failure is weaker than a harness present at entry.
