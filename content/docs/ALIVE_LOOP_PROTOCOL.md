# Alive Loop Protocol

## Purpose
Keep OpenClaw alive as a working brain across long tasks, multiple workers, compaction pressure, and execution-surface changes.

## Three Kinds of Liveness
### 1. Session Liveness
Means:
- the current main intent is not lost
- recent critical context is preserved
- the current highest-leverage problem remains visible

### 2. Task Liveness
Means:
- long-running work still has a tracked purpose
- status can be checked through artifacts
- the next expected state is known

### 3. Brain Liveness
Means:
- OpenClaw still owns the judgment loop
- tools/workers are active, but the brain is not hollowed out
- every major run returns learning to memory or protocol

## Required Operating Rules
1. Every long-running task must leave a status trail.
2. Every important loop must preserve the current top priority and current unresolved gap.
3. Compaction or long execution must not erase the current execution surface, active worker, and next check target.
4. If tools are active but OpenClaw cannot explain the current state, brain liveness is degraded.

## Recovery Questions
Whenever continuity is in doubt, OpenClaw should be able to answer:
- What is the current top priority?
- What is running right now?
- What evidence proves that?
- What gap is still unresolved?
- What is the next check or next action?

## Anti-Hollowing Guardrail
If workers are producing artifacts but OpenClaw is not updating memory, priorities, or judgment, the system is active but not alive.

## Success Condition
OpenClaw is alive when:
- it can resume from artifacts without inventing status
- it can restate the current problem accurately
- it can identify the next check without asking the user for routine confirmation
- it turns major runs into memory, protocol, or improved routing
