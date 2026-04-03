# Skill Assetization Trigger Rule

Status: active doctrine
Date: 2026-03-30

## Purpose
Prevent repeated workflow corrections from staying trapped in chat history or daily memory. When a correction recurs or clearly defines a reusable workflow, promote it into a skill, protocol, checklist, or other executable doctrine.

## Trigger
Promote a lesson beyond daily memory when any of the following is true:
1. the same correction or failure mode appears 2+ times
2. the workflow is high-frequency or high-risk
3. the workflow needs explicit entry conditions, steps, validation, and blocked/degraded handling
4. relying on chat continuity would likely cause regression after restart or compaction

## Preferred Promotion Order
1. checklist or guardrail update for narrow execution honesty fixes
2. protocol/doctrine update for cross-cutting operating rules
3. `SKILL.md` when the workflow is reusable, bounded, tool-aware, and benefits from explicit trigger conditions

## Minimum Skill Shape
A promoted skill should define:
- when to use it
- when not to use it
- required inputs / preflight
- ordered execution steps
- evidence / success criteria
- blocked / degraded labeling rules
- output artifact path or deliverable surface

## Non-Goal
Do not create `SKILL.md` files for one-off trivia or vague inspiration. A skill is justified only when it reduces drift, repeated explanation, or false-success risk.

## Examples
- heartbeat execution with blocked benchmark verification handling
- mydoc sync/publish verification before returning a public URL
- ACP routing with strict schema discipline
- GitHub issue -> fix -> verification -> PR flow

## Guardrail
A recurring correction that still matters after restart should not live only in chronology. If it changes execution behavior, promote it into reusable doctrine or a skill surface.
