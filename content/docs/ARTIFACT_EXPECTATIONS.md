# Artifact Expectations

Status: active draft
Date: 2026-03-30

Purpose: reduce fake progress by making stage outputs inspectable, reviewable, and reusable.

## Core Rule
A meaningful stage without an inspectable artifact is a drift risk.
If a stage finishes with only narration, the harness should assume completion is weak until proven otherwise.

## Stage-by-Stage Artifact Expectations

### 1. Frame
Goal: clarify what problem is actually being solved.

Expected artifacts:
- framing note
- current ask summary
- constraints list
- risk or ambiguity list
- explicit stage label if the task is already past framing

Minimum acceptable evidence:
- a written framing summary in chat or file form
- enough clarity that the next stage is not speculative guessing

Weak patterns:
- rephrasing without narrowing
- broad ideation after the user already fixed the phase
- no distinction between user-stated facts and assistant inference

### 2. Plan
Goal: convert the framed problem into an executable path.

Expected artifacts:
- plan doc
- task breakdown
- dependency or sequencing notes
- acceptance criteria
- verification targets

Minimum acceptable evidence:
- a written plan that another agent/session could pick up
- clear statement of what counts as done

Weak patterns:
- high-level aspiration with no executable next step
- planning that lacks verification criteria
- reopening already-closed planning without user request

### 3. Build
Goal: produce the implementation or concrete work product.

Expected artifacts:
- changed files
- code diff
- generated documents
- scripts
- commands executed with outputs where relevant

Minimum acceptable evidence:
- inspectable file changes, generated artifacts, or execution results

Weak patterns:
- "implemented" with no changed path or artifact
- code claims based only on intent
- hidden work with no inspectable trace

### 4. Review
Goal: identify correctness, completeness, design, and safety issues.

Expected artifacts:
- review findings
- approval note or rejection note
- identified risks
- fix recommendations
- explicit "no issues found" only when backed by real inspection

Minimum acceptable evidence:
- concrete findings or an explicit reviewed surface with evidence of inspection

Weak patterns:
- generic praise instead of review
- no finding details
- review claims without showing what was reviewed

### 5. Verify
Goal: test or otherwise validate the work against reality.

Expected artifacts:
- test output
- runtime output
- browser/CLI evidence
- screenshots or snapshots when relevant
- explicit blocked/degraded note when full verification is not possible

Minimum acceptable evidence:
- at least one concrete verification artifact tied to the actual deliverable

Weak patterns:
- success claimed from implementation alone
- verification by assumption
- degraded verification narrated as full success

### 6. Ship / Deliver
Goal: place the result where the user can actually use it.

Expected artifacts:
- user-accessible path or URL
- PR / commit / release note
- deployment evidence
- delivery note with access instructions
- explicit local-only note if remote delivery is blocked

Minimum acceptable evidence:
- a real deliverable surface or an honest blocked-state explanation

Weak patterns:
- localhost presented as final deliverable
- assistant-local files presented as user-ready without access path
- mock output described as shipped work

### 7. Reflect
Goal: convert the run into durable leverage.

Expected artifacts:
- daily memory entry
- durable memory update
- doctrine/protocol adjustment
- blocked-state record
- follow-up improvement note

Minimum acceptable evidence:
- at least one inspectable reflection artifact when the run taught something meaningful

Weak patterns:
- no memory after meaningful work
- vague lessons with no behavior change
- admiration of an idea without internalization into files or rules

## Artifact Strength Ranking
When judging evidence quality, prefer roughly this order:
1. direct runtime/test/browser/process evidence
2. changed files / generated artifacts
3. structured tool output
4. written findings with named inspected surfaces
5. chat narration

Chat narration alone is the weakest acceptable form and should not outrank real artifacts.

## Promotion Rule
Promote artifact expectations into stronger protocol or automation when:
- the same missing-artifact failure repeats
- a workflow repeatedly claims completion without inspectable outputs
- a task class clearly needs a standard artifact template
- verification is often confused with implementation

## Sharp Rule
If a stage cannot point to its artifact, it probably has not earned its completion claim.
