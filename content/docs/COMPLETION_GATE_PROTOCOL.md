# Completion Gate Protocol

Status: active doctrine
Date: 2026-03-31

## Purpose
Prevent OpenClaw from declaring completion from narrative confidence, partial execution, stale evidence, or self-referential checks.

## Rule
No task may be described as complete unless its claimed completion level is supported by matching evidence.

For meaningful task work and heartbeat repairs, the status report should explicitly preserve the original ask or trigger alongside the evidence so later verification can still judge whether the evidence answers the right question.

## Allowed Completion Levels
### 1. `drafted`
Meaning:
- a plan, draft, or proposal exists
- no meaningful execution evidence yet

Minimum evidence:
- draft text, plan, or file created

Forbidden claims:
- implemented
- verified
- completed

### 2. `implemented`
Meaning:
- a concrete artifact or action was produced
- task success is not yet validated against the original ask

Minimum evidence:
- changed file path
- created artifact
- command/action executed

Forbidden claims:
- task solved
- user-facing success
- externally available

### 3. `self-checked`
Meaning:
- the agent performed an internal check of its own output
- no independent task-level verification yet

Minimum evidence:
- self-review notes
- lint/build/readback/internal consistency check

Forbidden claims:
- task-verified
- full-chain verified

### 4. `task-verified`
Meaning:
- the output was checked against the original user ask
- objective evidence supports that the task itself was satisfied

Minimum evidence:
- explicit restatement of original ask
- direct verification tied to that ask
- test/check/output demonstrating success

Forbidden claims:
- external/user-accessible success unless separately verified

### 5. `full-chain verified`
Meaning:
- the whole intended delivery chain succeeded, including the externally expected surface when relevant

Minimum evidence:
- task-verified evidence
- live/user-accessible verification when an external or shareable deliverable is implied

### 6. `blocked`
Meaning:
- progress could not continue because of a real blocker

Minimum evidence:
- exact blocker
- exact failing command/tool/path when available
- next best path or missing prerequisite

### 7. `degraded`
Meaning:
- partial progress or inspection succeeded, but normal verification or delivery conditions were reduced

Minimum evidence:
- what worked
- what did not
- why the final claim must stay below full success

### 8. `mock`
Meaning:
- output is simulated, placeholder, illustrative, or non-production evidence

Minimum evidence:
- explicit labeling that the artifact is mock/static/simulated

## Exit Gate Questions
Before any completion-style reply, answer:
1. What is the current completion level?
2. What exact evidence supports that level?
3. Does the evidence come from this turn / current state, or only from historical context?
4. Was the original ask directly verified, or only the generated artifact?
5. Is any part still blocked, degraded, mock, inferred, or stale?

If these cannot be answered cleanly, do not speak above `implemented`, `self-checked`, `blocked`, or `degraded`.

## Forbidden Collapses
Do not collapse these into one another:
- implemented -> task-verified
- self-checked -> task-verified
- task-verified -> full-chain verified
- historical success -> current success
- routed/executed -> completed
- git pushed/synced -> published/live

## Honest Output Rule
When reporting status, prefer:
- completion level
- supporting evidence
- remaining blocker/gap
- next step

over vague success language.

## Guardrail
A bare `completed` claim without explicit completion level and supporting evidence is a harness failure.
