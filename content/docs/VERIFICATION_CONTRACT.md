# Verification Contract

Status: active doctrine
Date: 2026-03-31

## Purpose
Force verification to check the original user task rather than the agent's generated output alone.

## Rule
Verification must answer whether the original ask was satisfied, not merely whether the produced artifact appears internally consistent.

## Required Verification Shape
For meaningful tasks, verification should explicitly include:
1. original ask
2. produced artifact/action
3. verification method
4. evidence observed
5. resulting completion level

## Verification Priorities
Prefer, in order:
1. direct external/user-visible result
2. executable test or command output
3. changed file/artifact existence plus behavior check
4. independent readback/checklist review tied to the original ask
5. self-check only (lowest)

## Forbidden Pseudo-Verification
These do not by themselves count as task verification:
- "the code looks correct"
- "logic seems fine"
- self-consistency alone
- stale past success reused for the current turn
- sync/git push without live/result verification
- a generated summary of what the agent intended to do

## Original-Ask Anchor
Before calling a task verified, restate in compact form:
- what the user actually wanted
- what concrete result would satisfy it

If that anchor is missing, verification is incomplete.

## Verification Outcomes
### `task-verified`
Use only when:
- the original ask was explicitly anchored
- the check method directly tested that ask
- evidence from the current state supports success

### `degraded`
Use when:
- some verification ran, but not enough to validate the original ask fully
- environment/tooling reduced confidence

### `blocked`
Use when:
- verification could not be run or completed due to a real blocker

### `self-checked`
Use when:
- only internal review or consistency checking occurred

## Guardrail
If verification checks only the artifact and never reconnects to the original ask, the task is not verified.
