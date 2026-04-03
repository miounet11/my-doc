# OpenClaw Best Practices

Date: 2026-03-24

## 1. Purpose

This document defines the current best-practice standard for the local fork.

It exists to prevent drift toward:

- feature accumulation without runtime maturity
- noisy learning without promotion discipline
- high authority without recovery
- autonomy theater without evidence

The target state is a system that is:

- powerful
- stable
- operator-first
- evidence-backed
- able to improve across sessions

## 2. Core Operating Model

The system should be run as four permanent loops:

1. runtime loop
2. learning loop
3. execution loop
4. doctrine loop

If one loop is weak, the whole system becomes weak.

### 2.1 Runtime Loop

The runtime loop keeps the system alive, restartable, and observable.

Required properties:

- watchdog supervision
- gateway supervision
- transient retry logic
- health verification
- restart-safe repair
- low ambiguity during failure

### 2.2 Learning Loop

The learning loop ingests high-signal external change and compresses it into action candidates.

Preferred source order:

1. official docs and changelogs
2. product releases and SDK releases
3. technical blogs and builder essays
4. frontier paper feeds
5. curated social signals

### 2.3 Execution Loop

The execution loop turns selected ideas into bounded changes.

Allowed outputs:

- workflow patch
- doctrine update
- evaluation review
- memory note
- deferred backlog item

If a promoted item maps to none of these, it should not have been promoted.

### 2.4 Doctrine Loop

The doctrine loop turns repeated lessons into stable system behavior.

Doctrine should capture:

- what the system is
- what authority means
- what counts as success
- what repeatedly fails
- what must not drift

## 3. Primary Principles

### 3.1 Recovery Before Capability

A capability is not mature if it adds power faster than it adds restart safety, logging, and repair.

### 3.2 Evidence Before Belief

Logs, probes, reports, state files, and artifacts outrank narrative claims.

### 3.3 Sparse Promotion Before Broad Ingestion

The system may ingest broadly.
It should promote narrowly.

### 3.4 Doctrine Before Drift

If a pattern works repeatedly, write it down.
Otherwise the system will relearn the same lesson through failure.

### 3.5 Headless By Default

Background automation must not interfere with the operator’s desktop.

### 3.6 High Authority With Explicit Boundaries

The fork may use strong host authority.
It must do so intentionally, visibly, and recoverably.

## 4. Architecture Best Practice

### 4.1 Brain And Hands Must Stay Separate

The control plane owns:

- judgment
- routing
- memory
- verification
- correction
- doctrine

Workers own:

- bounded implementation
- bounded execution
- local verification

Workers must not become the decision center by drift.

### 4.2 Centralized Judgment Is A Feature

Judgment should not be fragmented across many semi-autonomous actors.
A single durable control layer keeps the system coherent.

### 4.3 Bounded Execution Beats Vague Autonomy

An execution path is better when:

- its inputs are clear
- its authority is known
- its output is verifiable
- its failure mode is recoverable

## 5. Source Hierarchy Best Practice

Not all information should be trusted equally.

### 5.1 Primary Truth Surfaces

- official product docs
- official changelogs
- official API docs
- official release feeds
- direct project repositories

### 5.2 Strong Secondary Sources

- technical builder blogs
- project release commentary by maintainers
- feed-backed frontier papers

### 5.3 Supporting Sources Only

- X posts
- reposts
- social commentary
- personal speculation without artifact backing

Supporting sources may influence review priority.
They should not outrank primary sources.

## 6. Promotion Best Practice

Promotion is where most systems become noisy.

The correct standard is:

- only promote items that can plausibly change workflow, tooling, evaluation, memory, or doctrine
- collapse repeated versions into one current representative
- keep the queue small
- prefer `P0 now` and `P1 review`
- suppress anything that reads like feed mirroring

Desired behavior:

- many things ingested
- few things promoted
- almost everything justified

## 7. Runtime Best Practice

The runtime should prefer:

- supervised services
- explicit startup paths
- persistent repair hooks
- retries for transient model/network faults
- daily health verification
- durable logs

The runtime should reject:

- silent wedging
- fake “healthy” signals
- unrecoverable patches
- background tasks that hijack the machine

## 8. Operator Ergonomics Best Practice

The operator should always be able to answer:

- is the system healthy
- what changed today
- what is promoted now
- what is blocked
- what failed recently

Automation that disrupts normal machine use is badly shaped automation.

## 9. Memory Best Practice

Memory should be layered:

- daily notes for raw continuity
- long-term memory for durable context
- doctrine files for system rules
- archive mirrors for restart-safe readable backup surfaces

No important lesson should exist only in chat history.
If a continuity-critical mirror exists, it must be refreshed by a canonical workflow instead of ad hoc copying.

## 10. Current Practical Standard

For this fork, best practice currently means:

- stability outranks raw flexibility
- high authority is acceptable only with explicit recovery
- the runtime is supervised and verified
- learning is feed-first and social-second
- promotions stay sparse
- execution remains bounded
- doctrine is updated after important incidents and repairs
- unattended automation is headless-by-default

## 11. Compact Rule

The shortest correct summary is:

Build a high-authority local system that learns from authoritative sources, promotes very little, executes in bounded steps, and treats recovery as a first-class feature.
