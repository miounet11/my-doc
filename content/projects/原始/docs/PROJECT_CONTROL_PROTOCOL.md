# Project Control Protocol

## Purpose
Turn `原始` into both a product project and the standard training ground for OpenClaw project control, evidence discipline, and brain-level growth.

## Identity Of The Project
`原始` has three roles at the same time:
1. product project
2. coordination proving ground
3. main-brain training arena

This means every iteration must improve both the project itself and OpenClaw's project-control ability.

## Iteration Contract
Each iteration should define:
- iteration number
- current focus
- why now
- success condition
- failure condition
- required evidence
- next expected review point

## Standard Loop
### 1. Define The Iteration
OpenClaw sets:
- the focus
- the success/failure bar
- the likely execution surface
- which parts are judgment tasks vs implementation tasks

### 2. Choose The Execution Surface
Use the execution-surface protocol:
- `sandbox-restricted` for safe analysis and planning
- `host-direct` for environment-sensitive probes or direct checks
- `worker-claude` for real long-running project work
- other surfaces only when the task truly requires them

### 3. Assign Work
- OpenClaw keeps task definition, routing, evidence interpretation, and final judgment.
- Claude Code gets concrete implementation/test/refactor tasks.
- Codex gets infrastructure/protocol/reliability/system-design tasks.

### 4. Collect Evidence
Evidence may include:
- result json
- status json
- heartbeat jsonl
- tests
- smoke results
- session evidence
- changed files

### 5. Classify Outcomes
Every major outcome should be classified as one of:
- `success`
- `env-failure`
- `tool-failure`
- `task-failure`
- `flaky`
- `unverified`

### 6. Write Retrospective
An iteration is not fully closed until it has a retrospective entry describing:
- what was attempted
- what actually succeeded
- what failed and why
- what remains unresolved
- what the next action should be
- what OpenClaw learned

### 7. Brain Recovery
After the iteration, OpenClaw must update at least one of:
- daily memory
- durable memory
- project protocol
- evidence board

## Completion Rule
A local worker success is not enough to declare full iteration success.

A full iteration success requires:
- execution evidence
- classified outcome
- updated state or retrospective
- OpenClaw review and closure

## Completion Rule
A local worker success is not enough to declare full iteration success.

A full iteration success requires:
- execution evidence
- classified outcome
- updated state or retrospective
- OpenClaw review and closure
- requester-visible completion return when the work was user-facing

## Completion Return Path Rule
Completion-return-path is mandatory.

If a delegated run finishes internally but does not return a completion update to the requester-facing channel or conversation, the iteration must be treated as only partially closed.

For user-facing work, requester-visible closure is part of the acceptance bar, not an optional courtesy.

## Training Metrics
The project should also be used to evaluate:
- loop closure rate
- fake success rate
- failure classification accuracy
- brain recovery rate
- over-outsourcing rate

## Anti-Fake-Success Rule
No iteration may be described as successful solely because a worker ended normally.
Normal worker exit must still be interpreted against the full evidence set.

## Anti-Hollowing Rule
If Codex or Claude Code produce artifacts but OpenClaw does not update priorities, memory, or review conclusions, the project may be active but the brain is not learning.

## Long-Term Goal
`原始` should become the standard battle-tested environment where OpenClaw learns how to run projects, supervise tools, keep evidence clean, and convert execution into durable capability.
