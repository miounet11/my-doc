# Repair Loop Protocol

Status: active doctrine
Date: 2026-03-31

## Purpose
Ensure failed or incomplete verification turns into an explicit repair cycle instead of narrative drift or premature closure.

## Rule
When execution or verification fails, the next state is not silent abandonment or vague explanation. The next state must be one of:
- repair planned
- repair in progress
- blocked
- degraded with explicit gap

## Required Failure-to-Repair Loop
1. state the failed check or gap
2. preserve the evidence of failure/blockage
3. identify the narrowest repair action
4. execute or queue the repair
5. re-run verification when possible
6. report the new completion level honestly

## Failure Record Minimum
A repair-worthy failure record should include:
- original ask
- failed check or unmet condition
- exact evidence / error / missing artifact
- chosen repair step
- next verification step

## Forbidden Failure Escapes
Do not:
- end with a broad success summary after failed verification
- replace a failed check with confidence language
- treat explanation of failure as repair
- skip re-verification after a meaningful fix

## Allowed States
### `repair planned`
Use when:
- the failure is understood
- the next corrective action is known
- repair has not yet executed

### `repair in progress`
Use when:
- the corrective step is underway

### `blocked`
Use when:
- repair cannot proceed because an external prerequisite, permission, tool, or environment is missing

### `degraded`
Use when:
- partial repair or partial verification succeeded, but an important gap remains

## Guardrail
A failed verification that does not produce either a repair step or an honest blocked/degraded label is a harness failure.
