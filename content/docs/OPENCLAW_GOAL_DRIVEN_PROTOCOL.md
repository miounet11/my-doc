# OpenClaw Goal-Driven Protocol v1

## Purpose
Absorb the strongest part of Goal-Driven into OpenClaw without importing its weak points blindly.

The purpose is to make OpenClaw better at long-running, difficult, verifiable work by separating:
- goal
- success criteria
- execution
- evidence
- restart / continuation policy

This protocol is for tasks that are:
- complex
- long-running
- objectively or semi-objectively verifiable
- likely to stall, drift, or fake-complete if not supervised

Examples:
- compiler or language-tool work
- deployment hardening and release recovery
- long coding refactors
- large content-factory generation runs
- system migration / multi-step infra repair

## Core Doctrine

### 1. Goal is not Criteria
- **Goal** = the north star
- **Criteria** = the judge

A task is not complete because an agent says it is complete.
A task is complete only when the criteria are satisfied with evidence.

### 2. Master must verify, not narrate
The supervising agent must not act like a secretary that repeats subagent claims.
It must act like a verifier that checks:
- process / session state
- files changed
- ports listening
- tests passing
- curl/browser results
- output artifacts
- structured acceptance conditions

### 3. Inactivity is not success
If a subagent becomes idle, silent, or says "done" without sufficient evidence:
- treat that as a verification event, not a success event
- compare current state against criteria
- if criteria are not met, continue or restart execution

### 4. Persistence needs budgets
Pure persistence without controls becomes token-burning stubbornness.
Every goal-driven run should define budgets for:
- time
- retries
- token/cost when possible
- strategy changes

### 5. Restarts are not enough
If the same failure pattern repeats, the master must not blindly relaunch forever.
It should change one of:
- strategy
- model
- batch size
- scope
- decomposition
- verifier

## Protocol Roles

### Goal Owner
Usually the human or the main orchestrator.
Defines the desired outcome and approves the mission framing.

### Master Agent
The supervisor loop.
Responsibilities:
- keep the goal stable
- keep criteria explicit
- launch or continue workers
- verify evidence
- detect drift / fake completion / idle loops
- decide continue / restart / strategy shift / stop

### Worker Agent
The executor.
Responsibilities:
- do bounded work toward the goal
- leave evidence
- report blockers truthfully
- avoid claiming completion without artifacts

### Verifier
Can be the master or a separate role.
Responsibilities:
- map evidence to criteria
- explicitly mark criteria as met / unmet / unknown

## Required Task Envelope
Every goal-driven task should be written in this shape.

```md
# Goal
<single north-star objective>

# Criteria
- [ ] criterion 1
- [ ] criterion 2
- [ ] criterion 3

# Evidence required
- command output
- test results
- file paths
- process state
- browser/curl proof

# Budgets
- max wall time:
- max retries:
- max strategy resets:

# Worker scope
- allowed to change:
- not allowed to change:

# Failure policy
- when idle:
- when repeated failure:
- when evidence is missing:
```

## Default Control Loop

```text
1. Define goal
2. Define criteria
3. Launch worker
4. Wait for evidence or inactivity
5. Verify against criteria
6. If unmet:
   - continue, restart, or change strategy
7. If met:
   - stop and record acceptance
```

## Acceptance States
Keep these states separate.

- **working**: active effort exists, criteria not yet met
- **needs-verification**: worker stopped / claimed done / went idle
- **partially-met**: some criteria satisfied, others not
- **blocked**: progress halted by a real blocker
- **accepted**: all required criteria satisfied with evidence
- **abandoned**: stopped by human or budget policy

Never collapse `needs-verification` or `partially-met` into `accepted`.

## Idle / Completion Rules
A worker should be treated as `needs-verification` if any of these happen:
- no new evidence for the expected interval
- worker says "done"
- worker exits unexpectedly
- worker produces narrative without artifacts
- worker loops on the same failed attempt repeatedly

Default action:
1. inspect evidence
2. update criteria board
3. if unmet, continue with a bounded next step

## Strategy Shift Rules
Do not repeat the same failing action forever.
Trigger a strategy shift when:
- 3 retries fail with the same signature
- output keeps missing the same criterion
- a verifier cannot inspect the result reliably
- cost/time is rising without evidence progress

Possible strategy shifts:
- smaller task slice
- tighter prompt / stricter output contract
- stronger verifier
- alternate model
- alternate data source
- different runtime surface

## Evidence Board
Every serious run should maintain a small evidence board.

```md
# Goal-Driven Evidence Board

## Goal
...

## Criteria status
- criterion A: met | unmet | unknown
- criterion B: met | unmet | unknown
- criterion C: met | unmet | unknown

## Latest evidence
- <artifact / output / test>

## Current worker state
- active | idle | failed | verifying

## Next supervisory action
- continue | restart | strategy-shift | accept | stop
```

## Good Fit / Bad Fit

### Good fit
- compiler implementation
- formal toolchains
- complex migrations
- deployment recovery
- large batch content generation with measurable quality gates
- long refactors with testable outputs

### Bad fit
- purely taste-driven creative work
- tasks with constantly moving goals
- work lacking meaningful verification criteria
- tasks where human judgment is the only real evaluator

## OpenClaw-Specific Rules

### 1. Prefer real artifacts over agent narration
Use file/tool/runtime evidence first.

### 2. Use internal council before bothering the human
When uncertain but not risky:
- reviewer for fake progress detection
- world-model for loop weakness
- goal-manager for next step prioritization
- coding executor for implementation

### 3. Memory must capture the control lesson
After a meaningful goal-driven run, record:
- what the goal was
- what the criteria were
- what evidence actually mattered
- what failure mode appeared
- what supervisory rule should improve next time

### 4. For content factories, criteria must be quantitative
Example:
- N files generated
- JSON validity rate >= X
- forbidden-pattern rate <= Y
- acceptance checks passed
- publication manifest written

### 5. For deployment, criteria must be service-level
Example:
- service listening
- domain returns 200
- health check passes
- rollback path exists
- release artifact recorded

## Minimal Example

```md
Goal:
Upgrade www.new2005.com into a stable live-data finance site with recoverable deployments and batch content generation.

Criteria:
- [ ] www.new2005.com returns 200
- [ ] live stock API returns non-demo data
- [ ] service is supervisor-managed
- [ ] rollback path exists
- [ ] batch content generator successfully emits 20 assets

Evidence required:
- curl output
- service status
- port listening
- generated manifest
- sample content files
```

## Final Rule
Goal-Driven is not magic because it makes agents brilliant.
Goal-Driven is powerful because it prevents them from being believed too early.
