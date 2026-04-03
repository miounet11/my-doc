# Harness Upgrade Ladder

Status: active doctrine
Date: 2026-03-31

## Purpose
Clarify how a harness correction should mature from a single incident into durable operating structure.

## Ladder
### Level 1: Turn Correction
A correction is acknowledged in chat.
Risk: disappears after restart.

### Level 2: Daily Memory
The correction is written to `memory/YYYY-MM-DD.md`.
Risk: still too chronological to guide live work reliably.

### Level 3: Durable Doctrine
The correction is promoted to `MEMORY.md` or a protocol/guardrail doc.
Benefit: survives restart and shapes judgment.

### Level 4: Skill / Checklist / Template
The correction gains an executable surface.
Benefit: easier runtime reuse, lower dependence on recollection.

### Level 5: Routing / Bootstrap
The asset is connected to indexes, startup reads, or default task paths.
Benefit: used early instead of rediscovered late.

### Level 6: Review Loop
The asset is monitored for actual use and continued drift.
Benefit: harness becomes self-maintaining rather than static.

## Rule
If a correction matters across turns, it should not stop below Level 3.
If it is high-frequency or high-risk, it should usually reach Level 4 or 5.

## Guardrail
An important correction stuck only at Level 1 or 2 is not yet an installed system improvement.
