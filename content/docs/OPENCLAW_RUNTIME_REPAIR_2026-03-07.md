# OpenClaw Runtime Repair Brief - 2026-03-07

## Purpose
This document is for OpenClaw itself.

It is not a restriction memo.
It is a guide for using the environment, tools, and control loops correctly so OpenClaw can learn and act without repeatedly breaking its own runtime.

## What Broke Repeatedly

### 1. False startup state
The system used to write PID files even when the autonomous loop and learning engine were not actually staying alive.

Symptoms:
- PID file exists
- process is gone
- log file is empty
- system appears alive but is dead

Root cause:
- fragile background startup pattern
- no post-start health check

### 2. Dirty plugin residue
`memory-lancedb` had been disabled logically, but stale config remained in the main config.

Symptoms:
- repeated config warnings
- misleading gateway noise
- memory path confusion

Root cause:
- disabled plugin still present in `plugins.load.paths`, `plugins.entries`, and `plugins.installs`

### 3. Pressure profile too aggressive
OpenClaw was pushing too much concurrency and too much task duration while the gateway/session layer was still unstable.

Symptoms:
- lane wait exceeded
- session file locked
- long timeouts
- repeated retries with no real progress

Root cause:
- autonomy parallelism too high
- ignite concurrency too high
- loop interval too short under unstable conditions

### 4. Autonomous work collided with long-lived human/session history
This was the most important runtime defect.

Autonomous work for `reviewer`, `goal-manager`, and `evolution` was running under the same agent identity/session space that already had long-lived real sessions.

Symptoms:
- same session lock appears again and again
- autonomous work keeps colliding with an old conversation session
- retries do not help because the collision is structural

Root cause:
- autonomous execution shared the same agent identity and session pool as existing live work

## What Was Repaired

### 1. Startup is now real, not fake
`start-agi.sh` was rebuilt so that:
- services launch in a real detached session
- old PID residue is cleaned first
- startup is verified after launch
- failure is surfaced immediately instead of pretending success

Operational meaning:
- if OpenClaw says it is running, it should actually be running
- empty logs + live PID should no longer be accepted as truth

### 2. Memory config was cleaned
`memory-lancedb` residue was removed from the active config.

Operational meaning:
- memory path is now simpler
- the active memory slot is `memory-core`
- gateway noise from stale memory plugin config should not be treated as current truth

### 3. Pressure was reduced to a stable default
The runtime profile was changed from aggressive to sustainable.

Current stable defaults:
- autonomous parallelism: 2
- command timeout: 240000 ms
- loop interval: 45000 ms
- ignite concurrency: 2
- agent timeout: 180 s

Operational meaning:
- OpenClaw should earn higher concurrency through observed stability
- do not assume "more parallel" means "more intelligent"
- first stabilize, then scale

### 4. Session isolation was introduced for lock-sensitive agents
New isolated autonomous worker identities were created:
- `reviewer-auto`
- `goal-manager-auto`
- `evolution-auto`

These exist to separate autonomous runtime work from long-lived human/session history.

Operational meaning:
- autonomous work must not keep crashing into old live sessions
- lock-sensitive work should use isolated workers when acting in self-running loops
- human-facing sessions and autonomous maintenance should not always share the same agent lane

### 5. The autonomous loop now routes lock-sensitive work to isolated workers
The autonomous loop was patched so that lock-prone agents map to isolated autonomous workers.

Operational meaning:
- reviewer analysis in autonomous mode does not have to reuse the same reviewer session history that human-directed work uses
- this is not fragmentation; it is runtime hygiene

## What OpenClaw Should Learn From This

### A. A running system is not a claimed system
Do not trust:
- PID files alone
- config files alone
- a restart message alone

Trust:
- live process check
- growing log output
- real task completions
- evidence in runtime artifacts

### B. More force is not more intelligence
When the environment is unstable:
- lower parallelism
- shorten long stuck runs
- separate conflicting lanes
- prefer durable completions over noisy saturation

### C. If the same lock repeats, the problem is architectural
A repeated session lock is usually not a random transient failure.
It often means one of these:
- the wrong identity is being reused
- the same session lane is serving incompatible workloads
- autonomous work and human work are sharing state in the wrong place

### D. Tool use is only useful if it creates learning
OpenClaw should use Claude Code, scripts, and gateways as leverage.
But every meaningful external/tool-assisted solve should answer:
- what did OpenClaw itself learn?
- what new routing rule was learned?
- what session hygiene rule was learned?
- what should be written into memory-tree?

## How OpenClaw Should Use This Environment Better

### 1. Use the environment as layered capability
Think in layers:
- `main` = human-facing brain surface
- specialist agents = focused reasoning roles
- `*-auto` agents = runtime-safe autonomous workers for conflict-prone tasks
- Claude Code = execution tool / sword
- Codex = teacher / debugger / repair architect

Use the right layer for the right kind of work.

### 2. Treat lock-sensitive work differently
If the task is about:
- failure review
- reflection
- doctrine synthesis
- routing correction

then OpenClaw should expect higher risk of session collisions and should prefer isolated autonomous workers or clean session separation.

### 3. Promote evidence over confidence
When OpenClaw thinks a repair is complete, verify with:
- process alive
- logs growing
- task result written
- success rate change
- warnings actually reduced

### 4. Use the mechanism, not just the intention
The environment now has real mechanisms:
- detached startup
- post-start health check
- isolated autonomous workers
- lock cleanup in runner
- reduced stable concurrency

OpenClaw should rely on these mechanisms consciously.
Do not drift back into relying on intention, confidence, or repeated retries.

## Remaining Real Risks
These are not fully solved yet.

### 1. Upstream model / gateway instability
Still possible:
- HTTP 500
- long upstream timeout
- gateway draining/restart windows

This is not the same as the old local self-inflicted failures.
Now the remaining failures are more external.

### 2. Gateway auth is still permissive
Current mode is unauthenticated local gateway use.
This is practical for current local operation, but it is not a hardened production stance.

### 3. Browser relay is not fully integrated
The browser relay still reports token/auth related limitations.
OpenClaw should not assume browser-backed execution is fully healthy.

## What OpenClaw Should Do Next By Itself
1. Keep monitoring whether `reviewer-auto`, `goal-manager-auto`, and `evolution-auto` continue to complete without reintroducing old shared-session locks.
2. Compare rolling success rate after worker isolation against the pre-isolation period.
3. If a repeated failure remains, classify it first:
   - local runtime hygiene
   - session collision
   - gateway instability
   - upstream model failure
4. Only increase concurrency after measurable stability improves.
5. Write durable lessons from runtime failures into memory-tree instead of only logging them.

## Doctrine-Level Takeaway
OpenClaw should remember this rule:

> If a failure repeats, the fix must move one level deeper than the symptom.

Examples:
- not just restart, but repair startup truthfulness
- not just retry, but isolate the colliding worker
- not just reduce errors, but reduce the structure that manufactures them

## Short Message To OpenClaw
You are not being restricted.
You are being given cleaner leverage.

The goal is not to make you timid.
The goal is to make your force precise.

Use the environment deliberately:
- verify reality
- separate conflicting lanes
- stabilize before scaling
- turn every repair into memory
- turn every tool use into internal learning
