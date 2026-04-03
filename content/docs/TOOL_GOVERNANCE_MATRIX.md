# Tool Governance Matrix

## Purpose
Route work by task type, evidence needs, execution surface, and capability boundary instead of habit.

## Task-Type Routing
### 1. Judgment Tasks
Examples:
- deciding whether success is real
- prioritizing competing defects
- deciding what enters memory
- interpreting partial/conflicting evidence

Owner:
- OpenClaw

Support:
- Codex or Claude Code may provide bounded analysis, but must not make the final call.

### 2. Infrastructure / Protocol Tasks
Examples:
- execution-surface governance
- fallback design
- status artifact schema
- orchestration and reliability hardening

Preferred owner:
- Codex

OpenClaw role:
- define the problem, review evidence, accept or reject global conclusions, update memory/protocol

### 3. Concrete Project Implementation Tasks
Examples:
- feature work
- bug fixes
- refactors
- tests
- worker-based coding iterations

Preferred owner:
- Claude Code

OpenClaw role:
- define task, choose surface, monitor artifacts, interpret completion quality

### 4. Verification Tasks
Examples:
- status checking
- health checking
- evidence collection
- smoke tests

Owner:
- OpenClaw first for interpretation
- execution may be delegated to the appropriate surface/tool

## Execution Surface Matrix
### sandbox-restricted
Use for:
- reading files
- static inspection
- planning
- safe protocol review
- lightweight evidence aggregation

Avoid for:
- network-sensitive validation
- real Claude worker runs
- long-running environment-sensitive execution

### host-direct
Use for:
- direct probes
- environment-sensitive CLI validation
- host-level status checks

### worker-claude
Use for:
- concrete long-running project execution
- implementation/test/refactor loops
- result/status/heartbeat artifact generation

### browser-relay / remote-node
Use for:
- web UI work
- node/device-specific operations

## Probe Rules
Before expensive or environment-sensitive execution, prefer a minimal probe.

Examples:
- command availability probe
- network/DNS probe
- workspace access probe
- minimal model call

If probe fails in sandbox but succeeds on host, classify as `env-failure` candidate.

## Failure Classification Matrix
### env-failure
Examples:
- ENOTFOUND
- DNS/network isolation
- permission denied due to sandbox
- missing external reachability

### tool-failure
Examples:
- malformed CLI invocation
- broken RPC contract
- toolchain crash

### task-failure
Examples:
- code/test failure
- implementation bug
- timeout due to real workload or logic

### flaky
Examples:
- intermittent session closure
- inconsistent behavior across repeated runs without stable diagnosis

## Memory and Learning Rule
Only evidence-backed results with correct failure classification may influence durable learning.

- environment noise should improve routing, not poison capability judgments
- local worker success should improve execution knowledge, but not bypass OpenClaw global review

## Anti-Habit Guardrail
Do not choose Codex, Claude Code, or a surface merely because it worked last time.
Choose based on:
- task type
- evidence required
- environment sensitivity
- risk and expected artifact quality

## Success Condition
Tool use is healthy when:
- the chosen executor matches the task
- the chosen surface matches the environment need
- failure is classified correctly
- OpenClaw retains the final interpretive role
