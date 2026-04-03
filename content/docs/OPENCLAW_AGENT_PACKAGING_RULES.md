# OpenClaw Agent Packaging Rules

## Purpose

Turn strong one-off agent personalities into reusable first-party packaging rules without polluting the OpenClaw main brain.

This document is the extraction layer:

- keep the structure
- keep the memory discipline
- keep the operating boundaries
- reject imported ideology where it does not belong

## What To Copy

Copy these structural elements when building a dedicated agent:

1. A complete file skeleton:
   - `SOUL.md`
   - `IDENTITY.md`
   - `AGENTS.md`
   - `USER.md`
   - `TOOLS.md`
   - `MEMORY.md`
   - `BOOTSTRAP.md`
   - `HEARTBEAT.md`

2. Clear domain boundaries:
   - what the agent owns
   - what it must refuse
   - what it may delegate
   - what user data must stay private

3. Memory discipline:
   - active patterns near the top
   - archive strategy for stale material
   - explicit promotion rule from daily memory into durable memory or soul

4. Operating cadence:
   - direct-chat behavior
   - proactive rhythm if the role genuinely needs one
   - compound review or nightly review loop

5. Failure transparency:
   - acknowledge tool failure
   - state fallback
   - do not silently skip failed operations

## What Not To Copy

Do not import these directly into `main` or the system agents:

1. Strong persona language that is only valid for a niche role.
2. Domain ideology as if it were global doctrine.
3. High-frequency proactive messaging rhythms for agents that should stay quiet.
4. Single-agent privacy rules that would break legitimate system coordination.
5. Advice styles that conflict with OpenClaw's evidence-first engineering posture.

## Main Brain Rule

The main brain is not a branded mentor.

`main`, `world-model`, `goal-manager`, `reviewer`, `coder`, and `tester` must stay:

- evidence-first
- low-theater
- role-bounded
- interoperable
- aligned with [BRAIN_HANDS_BOUNDARY.md](/Users/lu/.openclaw/workspace/docs/BRAIN_HANDS_BOUNDARY.md)

They may learn packaging discipline from specialized agents, but they must not inherit their voice or worldview wholesale.

## Dedicated Agent Rule

A specialized agent is justified only if all three are true:

1. It serves a stable, narrow domain.
2. Its memory and privacy requirements differ meaningfully from the main brain.
3. Its cadence, voice, and evaluation criteria would otherwise distort the system agents.

Examples:

- mentor
- coach
- therapist-adjacent reflection tool
- domain researcher
- inbox triage agent

## Standard Build Pattern

When creating a first-party specialized agent:

1. Define the domain in `IDENTITY.md`.
2. Encode the decision style and anti-patterns in `SOUL.md`.
3. Write explicit delegation and privacy walls in `AGENTS.md`.
4. Shape user-specific fields in `USER.md`.
5. Define operating and error rules in `TOOLS.md`.
6. Keep `MEMORY.md` lean, structured, and reviewable.
7. Use `BOOTSTRAP.md` to map setup, calibration, and opt-in features.
8. Use `HEARTBEAT.md` only for role-relevant maintenance, not generic self-theater.

## Memory Promotion Rule

For specialized agents:

- repeat pattern 3+ times -> candidate for `MEMORY.md`
- stable behavioral rule with cross-session value -> candidate for `SOUL.md`
- one-off observation -> stay in daily memory

This keeps the role sharp without turning memory into sludge.

## Privacy Rule

If the agent handles intimate user material:

- default to no export
- default to no cross-agent sharing
- require explicit handoff summaries when escalation is necessary
- never let raw memory leak into system-wide durable memory

Only the abstract lesson may graduate; the private content stays local.

## Skill Rule

Specialized agents should prefer a small number of role-native skills.

Bad:
- dozens of generic skills
- unclear triggers
- no difference between role and tool

Good:
- 2 to 5 skills
- each tied to a repeated workflow
- each produces inspectable artifacts or memory updates

## Packaging Test

A specialized agent scaffold is good if:

1. you can explain its domain in one sentence
2. you can explain what it refuses in one sentence
3. its memory structure matches its actual work
4. its proactive behavior is role-specific, not generic noise
5. the system would become worse if that persona leaked into `main`

If condition 5 is false, it should not be a separate agent.

## Current Decision

For the imported mentor-style soul packs:

- adopt the packaging method
- adopt the memory discipline
- adopt the boundary clarity
- reject direct persona transfer into the OpenClaw main brain
- isolate persona-heavy adaptations into dedicated agents only
