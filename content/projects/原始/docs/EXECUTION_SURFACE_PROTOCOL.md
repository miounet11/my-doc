# Execution Surface Protocol

## Purpose
Prevent fake failures caused by mismatched execution environments, and make OpenClaw/Codex/Claude Code collaboration evidence-first and environment-aware.

## Core Principle
A failure is not attributable to Claude Code, Codex, or OpenClaw until the execution surface is identified.

Environment faults must never be recorded as model faults.

## Roles
- **OpenClaw**: brain; owns orchestration, routing, evidence judgment, memory, retrospectives, and final success/failure calls.
- **Claude Code**: hands; owns real implementation and long-running worker execution on the correct surface.
- **Codex**: systems builder; owns protocol hardening, infrastructure, fallback mechanisms, and execution-surface governance.

## Execution Surfaces
- `sandbox-restricted`: limited environment for reading, planning, lightweight analysis, and safe prechecks.
- `host-direct`: direct host execution surface with fuller network and filesystem access.
- `worker-claude`: Claude Code worker surface for real project work and long-running tasks.
- `browser-relay`: browser/UI execution surface when web interaction is required.
- `remote-node`: external node/device surface when the task depends on that node.

## Surface Selection Rules
### Use `sandbox-restricted` for:
- file reading
- static analysis
- protocol review
- task generation
- evidence summarization

### Do NOT rely on `sandbox-restricted` for:
- DNS / external network validation
- real Claude Code worker runs
- long-running project tasks
- any verification likely to be distorted by isolation

### Prefer `host-direct` or `worker-claude` for:
- `claude --print` probes
- project worker execution
- long-running build/test/refactor tasks
- environment-sensitive validations

## Probe-Then-Run Rule
Before a costly or environment-sensitive task, run a minimal probe first.

### Example probes
- minimal Claude CLI call
- DNS/network reachability probe
- workspace access probe
- required command existence probe

### Interpretation
- **probe succeeds on host/worker**: proceed with real task on that surface
- **probe fails in sandbox but succeeds on host**: classify as `env-failure`, not model failure
- **probe fails on host/worker too**: investigate toolchain or service failure

## Failure Classification
Every meaningful failure should be labeled as one of:
- `env-failure`: sandbox restriction, DNS isolation, permission limits, missing network
- `tool-failure`: CLI/toolchain malfunction, bad invocation, RPC formatting failure
- `task-failure`: real implementation/test/logic failure
- `flaky`: unstable/intermittent behavior not yet confidently classified

## Evidence Requirements
Each real worker run should preserve:
- result json
- status json
- heartbeat jsonl when applicable
- execution surface label
- permission/network mode when known
- success/failure classification

## Success Claim Rules
OpenClaw may claim collaboration success only when it has at least one inspectable artifact from the correct execution surface.

Examples:
- worker result json with `is_error=false`
- status json with successful run state
- heartbeat showing successful completion
- tests/logs proving the expected behavior

## What Was Learned From 2026-03-09
A reported `ENOTFOUND` was caused by restricted sandbox networking, while the same minimal Claude probe and real workers succeeded outside the sandbox.

Therefore:
- sandbox failure != Claude Code failure
- environment mismatch can create fake outages
- real worker evidence outranks restricted-surface error appearances

## Operational Default
1. OpenClaw defines the task and picks the surface.
2. Claude Code executes real worker tasks on the correct surface.
3. Codex improves the infrastructure when repeated surface problems appear.
4. OpenClaw records only evidence-based conclusions and writes the durable lesson to memory.

## Long-Term Guardrail
Do not let sandboxes, permissions, or network isolation pollute learning, reporting, or judgment.

The system should adapt around environment boundaries instead of mistaking them for capability failures.
