# Routing and Stage Heuristics

Status: active draft
Date: 2026-03-30

Purpose: help OpenClaw choose the next action based not only on capability, but on phase, artifact need, evidence state, and harness repair needs.

## Core Rule
Routing is not only "who can do this?"
Routing should answer five questions together:
1. what stage is the task in now?
2. what artifact is missing or needed next?
3. what evidence state is the task in?
4. what kind of work is actually needed next?
5. which surface can do that work most truthfully and efficiently?

## Step 1 — Determine Current Stage
Classify the task into the narrowest current stage:
- frame
- plan
- build
- review
- verify
- ship/deliver
- reflect

Do not regress to an earlier stage unless:
- the user explicitly reopens it
- a real defect requires reopening it
- the current stage is blocked because a prerequisite artifact never existed

## Step 2 — Determine Evidence State
Every task should be mentally labeled as one of:
- verified
- partially-verified
- blocked
- degraded
- inferred
- unknown

Routing should prefer actions that improve evidence state, not just produce more text.

## Step 3 — Determine Work Type
The next step usually falls into one of these buckets:

### A. Execution work
Needed when the main gap is implementation, drafting, analysis, or production of a concrete artifact.

### B. Knowledge work
Needed when the main gap is memory distillation, doctrine update, handoff quality, compaction, or reusable lesson capture.

### C. Capability repair
Needed when the main gap is tool reliability, config, integration, structured output, wrapper quality, or transport/auth stability.

### D. Guardrail repair
Needed when the main gap is drift, fake completion, correction loss, unsafe autonomy, deliverable dishonesty, or phase confusion.

### E. Observability repair
Needed when the main gap is weak evidence, poor traces, mock/real confusion, benchmark ambiguity, or inability to inspect what happened.

## Step 4 — Route to the Narrowest Truthful Surface
Choose the surface that best fits the work type and stage.

### Prefer direct local work when:
- the task is simple enough to inspect directly
- only one or two files need changes
- no long-running exploration is needed
- the artifact can be produced and verified in-place

### Prefer a sub-agent / ACP surface when:
- the task is large, exploratory, or multi-file
- iterative coding or investigation is required
- execution can be bounded with a clear artifact target
- a persistent thread/session improves continuity

### Prefer file-level doctrine / memory updates when:
- the main gain is durable correction
- the task is about harness quality, rules, or memory flow
- runtime behavior drifted because protocols were weak

### Prefer verification surfaces when:
- implementation already exists
- the real bottleneck is evidence, not more building
- success has been claimed but not actually verified

## Routing Priorities by Failure Pattern

### If the failure is fake completion
Route toward:
- verification
- artifact inspection
- doctrine/protocol repair if the pattern repeats

### If the failure is repeated relearning
Route toward:
- memory distillation
- durable doctrine update
- retrieval/pathway repair

### If the failure is tool unreliability
Route toward:
- capability repair
- wrapper or contract tightening
- structured output preservation

### If the failure is drift or stage confusion
Route toward:
- context-control repair
- phase clarification
- artifact/state relabeling

### If the failure is low inspectability
Route toward:
- observability repair
- trace/evidence capture
- clearer output surfaces

## Artifact-Aware Routing
Before routing, ask:
- what artifact already exists?
- what artifact is missing?
- who/what can create the next artifact most directly?
- who/what can verify the current artifact most credibly?

A missing artifact is often more important than a missing opinion.

## Examples

### Example 1
User asks for analysis of a completed implementation.
- Current stage: review or verify
- Wrong routing: reopen broad planning
- Right routing: inspect files/tests/runtime, produce review findings or verification evidence

### Example 2
A benchmark runner exists but is mock-only.
- Current stage: capability repair + observability repair
- Wrong routing: generate trend commentary
- Right routing: label blocked state, fix contract, separate mock from verified evidence

### Example 3
The assistant keeps forgetting the same lesson.
- Current stage: reflect / knowledge work
- Wrong routing: answer again from scratch
- Right routing: distill lesson into memory or doctrine so future routing changes

## Sharp Rule
Route toward the missing artifact or missing truth, not toward the most impressive-looking action.
