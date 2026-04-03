# OpenClaw Authority Policy

Date: 2026-03-24

## 1. Governing Principle

For this fork, stability outranks raw flexibility.

This does not mean weak capability.
It means:

- high authority is allowed
- hidden fragility is not allowed
- every powerful path must be restart-safe
- every broad mutation path must be recoverable

The system should optimize for:

- high-quality execution
- high operator leverage
- low ambiguity
- low recovery time

## 2. Stability-First Rules

1. Real host power is acceptable in a trusted single-operator environment.
2. Power without logging is not acceptable.
3. Power without restart behavior is not acceptable.
4. Power without rollback or repair path is not acceptable.
5. A fast path that wedges the runtime is worse than a slower path that survives.

## 3. Authority Tiers

### Tier A: Observation

Allowed:

- read files
- inspect sessions
- inspect logs
- inspect services
- inspect model/provider state

Requirements:

- no hidden mutations
- evidence capture preferred

### Tier B: Normal Execution

Allowed:

- local file edits
- tests
- builds
- service restarts
- bounded repo and workspace changes

Requirements:

- command traceability
- post-action verification
- no silent broad mutations

### Tier C: Elevated Execution

Allowed:

- package updates
- runtime patching
- gateway/service install-reinstall
- configuration rewrites
- process replacement

Requirements:

- pre-change snapshot or equivalent recovery path
- explicit verification after change
- durable logging

### Tier D: Break Glass

Allowed only for:

- destructive repair
- machine-wide changes with large blast radius
- credential-impacting changes
- irreversible cleanup paths

Requirements:

- explicit operator instruction
- full logging
- immediate verification

## 4. What Must Stay Constrained

These are not ideological constraints.
They are stability constraints.

### 4.1 No Silent Destructive Operations

Do not allow:

- blind deletes
- blind resets
- irreversible cleanup without explicit intent

### 4.2 No Unverified “Success”

Do not mark a path healthy because:

- the process started
- a tool returned `completed`
- a model answered something

Only evidence-backed completion counts.

### 4.3 No Runtime Mutation Without Re-entry Plan

Any patch to:

- bundled runtime files
- service files
- provider transport code
- watchdog logic

must also define:

- how it survives restart
- how it survives update
- how it is re-verified

### 4.4 No Capability Growth That Expands Failure Radius Faster Than Recovery

If a new feature:

- increases concurrency
- increases mutation breadth
- increases autonomy depth
- increases external side effects

then recovery must be upgraded first.

## 5. Stability Profile For This Fork

### 5.1 Preferred Defaults

- trusted single-operator model
- host execution allowed
- sandbox fiction avoided
- watchdog supervised
- gateway supervised
- retry on transient model/network faults
- startup self-repair hooks allowed

### 5.2 Required Protections

- audit logs
- process supervision
- restart verification
- state snapshots where practical
- durable doctrine updates after incidents

### 5.3 Disallowed Illusions

- “safe” because a failing sandbox blocked useful work
- “healthy” because the gateway process exists
- “stable” because the last run happened to succeed
- “done” because a worker said so

## 6. Quality And Efficiency Under This Policy

High quality comes from:

- correct execution surface
- low ambiguity
- evidence-backed verification
- stable retries instead of random retries

High efficiency comes from:

- removing fake friction
- reducing repeated diagnosis
- patching at the right layer
- making fixes durable

Stability is not the opposite of speed.
It is what keeps speed compounding.

## 7. Immediate Implementation Standard

Any future runtime change should answer:

1. What stability problem does this solve?
2. What tier of authority does it require?
3. What can fail after restart?
4. What survives update?
5. How do we verify it now?

If those answers are weak, the change is not ready.

## 8. Current Practical Conclusion

For this fork:

- keep high-trust local execution
- keep gateway and watchdog supervision
- keep runtime repair hooks
- prefer stable provider-family fallbacks
- avoid broad new freedom until the recovery surface is equally strong

That is the path to a system that is both powerful and dependable.
