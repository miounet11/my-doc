# WORKFLOW_SUPERPOWERS_ABSORPTION

## Source pattern

This note absorbs the useful architectural ideas seen in plugin/workflow stacks such as `FradSer/dotclaude` (`superpowers`, agent-team review/execution, loop-oriented workflow packaging).

The value is not mystical prompting.
The value is **workflow compression**:
- named workflow bundles
- role separation
- explicit iteration loops
- built-in review/QA/release gates
- less orchestration burden on the human

## Why users perceive it as strong

Systems like this feel strong because they reduce the distance between:
- idea
- decomposition
- execution
- review
- QA
- shipping

Instead of a freeform assistant requiring human orchestration at every step, the workflow shell already knows what phase comes next.

## What to absorb

### 1. Named workflow bundles
Examples:
- brainstorm
- plan
- execute
- review
- QA
- ship
- retro

These should be treated as reusable operational surfaces, not ad-hoc prompting styles.

### 2. Role separation
Separate useful roles where they create real leverage:
- architect
- implementer
- reviewer
- verifier
- QA
- supervisor

Do not force one freeform agent to implicitly hold every role if a structured split is clearer.

### 3. Loop pressure
A strong workflow system keeps asking:
- is this actually done?
- what remains blocked?
- what evidence exists?
- what review is still missing?
- what should be retried or escalated?

This is one of the real reasons loop-based stacks feel more capable.

### 4. Exit criteria
Every phase should define:
- done
- partial
- blocked
- evidence required

Without exit criteria, the system drifts toward fake completion.

### 5. Packaged behavior over raw intelligence
Operational structure often beats a smarter but looser assistant.
The main lesson is to package repeatable behavior into skills, scripts, and protocols.

## OpenClaw implications

OpenClaw should keep moving toward:
- stronger skill-backed workflow surfaces
- better handoff/continuity between phases
- explicit review and verification lanes
- supervisor loops for long-running execution
- lower dependence on verbose human orchestration

## Guardrail

Do not copy branding or prompt style blindly.
Absorb the execution architecture:
- workflow packaging
- role clarity
- loop discipline
- verification gates

That is the durable value.
