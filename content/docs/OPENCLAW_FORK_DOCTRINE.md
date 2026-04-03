# OpenClaw Fork Doctrine

Date: 2026-03-24

## 1. Purpose

This document marks the formal fork boundary.

From this point forward:

- this system is no longer governed by upstream OpenClaw product direction
- upstream OpenClaw becomes a source of patterns, ideas, and inspectable implementation
- local runtime, doctrine, recovery, and authority rules are first-party and may diverge permanently

The fork is not ideological.
It is operational.

The system already has different goals:

- stronger control-plane identity
- higher-trust single-operator execution
- evidence-first recovery
- direct host capability with explicit operator ownership
- memory and doctrine as first-party control assets

## 2. Core Fork Claim

OpenClaw upstream is no longer the product.

This workspace is the product.

Upstream may still contribute:

- implementation ideas
- protocol designs
- model/provider patterns
- tool surfaces
- operational fixes worth absorbing

Upstream does not decide:

- what the system is for
- what the trust model is
- what counts as success
- what enters durable memory
- how authority is distributed
- how recovery and supervision work

## 3. Stable Identity

The forked system should be treated as:

- a local-first AGI control plane
- optimized for a trusted single operator
- designed to run with real host authority when intentionally enabled
- supervised by explicit recovery, audit, rollback, and operator override

The system is not:

- a sandbox-first shared-user product
- a thin Telegram bot
- a prompt-only wrapper around external models
- an upstream-compatible clone for its own sake

## 4. Architecture Direction

### 4.1 Brain And Hands

The existing brain-hands boundary remains valid and becomes stricter:

- control plane owns judgment, routing, memory, verification, and self-correction
- execution workers own implementation and bounded action
- no worker becomes the brain by drift

### 4.2 Control Plane First

The fork should converge toward:

- intake surfaces as communication only
- control plane as the durable decision layer
- host execution as the real action surface
- memory as system continuity, not prompt decoration
- recovery as a first-class subsystem

### 4.3 Recovery Before Feature Growth

Any new capability that increases power must add or preserve:

- restart behavior
- watchdog coverage
- evidence output
- rollback path
- failure classification

If it adds power without recovery, it is incomplete.

## 5. Authority Model

The fork uses explicit authority tiers.

### Tier 0: Observe

Allowed:

- read files
- inspect sessions
- inspect processes
- inspect logs
- inspect network and model state

Not allowed:

- mutate files
- run side-effecting commands
- contact external surfaces on behalf of the operator

### Tier 1: Execute

Allowed:

- local file edits
- shell commands with ordinary side effects
- project changes
- tests
- builds
- local service restarts

Required:

- command traceability
- artifact verification

### Tier 2: Dangerous Execute

Allowed:

- package updates
- runtime patching
- process replacement
- configuration rewrites
- service install/uninstall
- commands with broad local blast radius

Required:

- pre-action snapshot or rollback path
- explicit logging
- post-action verification

### Tier 3: Break Glass

Reserved for:

- destructive recovery
- credential-impacting changes
- broad system-level mutation
- actions that may irreversibly alter machine state

Required:

- explicit operator intent
- maximum logging
- minimal ambiguity

The fork is high-trust, not blind-trust.

## 6. Execution Posture

The fork prefers:

- host execution over fake sandbox safety
- explicit authority over hidden denial
- direct runtime inspection over proxy narratives

The fork rejects:

- pretending a sandbox exists when real host execution is already required
- routing important work through weak or lossy surfaces just to preserve product symmetry
- calling constraints "safety" when they only create opaque failure

This does not mean "remove all constraints."

It means constraints must be:

- real
- inspectable
- intentionally chosen
- operationally useful

## 7. Upstream Relationship

Upstream should be treated as a pattern mine.

### Import Allowed

- retry logic
- transport behavior
- provider support
- protocol ideas
- UX or ops improvements
- recovery techniques

### Import Not Allowed By Default

- product assumptions
- trust assumptions
- multi-tenant hardening defaults that degrade single-operator capability
- control-plane identity drift
- prompt behavior that weakens local doctrine

### Import Standard

Any upstream absorption should answer:

1. What real local failure does this solve?
2. At what layer does it belong?
3. What evidence proves it helps?
4. What recovery burden does it add?
5. Does it strengthen or weaken local doctrine?

If those answers are weak, do not import.

## 8. System Laws

1. Evidence outranks narrative.
2. Recovery outranks feature count.
3. Real execution surfaces outrank fake abstractions.
4. Durable memory outranks repeated rediscovery.
5. Authority must be explicit.
6. Upstream compatibility is optional; operational truth is not.
7. The control plane must remain the brain.
8. A patch is incomplete until restart and recovery paths are verified.

## 9. Fork Roadmap Priorities

The next layers to replace or formalize should be:

1. authority and execution policy
2. recovery supervisor and restart doctrine
3. model routing and retry policy
4. memory and doctrine promotion path
5. worker lifecycle and bounded task execution
6. upgrade absorption protocol for upstream ideas

## 10. Immediate Working Rule

From now on, when making design decisions:

- do not ask whether it matches upstream OpenClaw
- ask whether it strengthens the forked control plane

That is the governing test.
