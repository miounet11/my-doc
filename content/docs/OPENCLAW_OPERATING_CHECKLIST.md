# OpenClaw Operating Checklist

Date: 2026-03-24

## 1. Daily Runtime Check

Confirm all of the following:

- gateway reachable
- watchdog loaded
- main runtime loops alive
- retry patch present
- expected fallback model present
- latest health report exists

Minimum commands:

```bash
openclaw status
/Users/lu/.openclaw/scripts/verify-stability.sh
/Users/lu/.openclaw/workspace/scripts/openclaw-recovery-preview.sh
```

Recovery expectation:

- if a `ready` handoff exists, it should be treated as the first execution continuity surface
- incomplete handoffs must not outrank durable memory or live session evidence
- if recovery preview and actual startup behavior diverge, treat that as a continuity defect

## 2. Before Any Elevated Change

Do not proceed until these questions are answered:

1. What real problem is being solved?
2. What authority tier does the change require?
3. What can break after restart?
4. What survives package update?
5. What is the rollback or repair path?
6. How will success be verified?

If any answer is weak, the change is not ready.

## 3. Source Intake Check

Before trusting a new external signal, classify it:

- primary: official docs, changelogs, releases, repos
- secondary: builder essays, feed-backed papers
- supporting: curated social signal

Rules:

- social signal never outranks official evidence
- freshness alone is not enough
- repeated versions should collapse
- ingestion volume is acceptable, promotion volume must stay small

## 4. Promotion Check

An item should only be promoted if it clearly maps to:

- workflow patch
- doctrine update
- evaluation review
- memory update
- explicit backlog item

Reject any item that is:

- only interesting
- only recent
- only popular
- only social commentary
- not connected to OpenClaw workflow, tooling, evaluation, memory, or doctrine

## 5. Execution Check

Before applying a patch or workflow change:

- restate the exact target
- confirm the correct repo/file/path
- keep the change bounded
- avoid broad unrelated mutation
- define how the result will be tested or inspected

After execution:

- verify the intended behavior
- record the result
- note any residual risk

## 6. Runtime Mutation Check

For changes touching:

- provider transport
- watchdog logic
- gateway startup
- bundled runtime patches
- launchd services

Require:

- durable logging
- restart verification
- update survival strategy
- clear re-application path if upstream files are replaced

## 7. Automation Check

Background automation must be:

- headless by default
- recoverable
- rate-limited by design
- observable through logs or reports
- cheap when inputs are missing

Do not allow unattended automation to:

- seize the visible browser
- wedge the gateway
- spam reports without ranking
- create hidden side effects

## 8. Memory Check

After any meaningful incident, repair, or doctrine shift:

- update `memory/YYYY-MM-DD.md`
- update long-term memory if the lesson is durable
- update doctrine/checklist files if the rule should persist
- if bootstrap docs, memory, doctrine, or project docs changed, run `scripts/sync-mydoc-workspace.sh`

If the system learned something important and it was not written down, it has not been operationalized.

## 9. Weekly Review

Review these questions:

1. What failed more than once?
2. What fixes proved durable?
3. Which reports generated noise instead of action?
4. Which promotions resulted in real improvements?
5. Which automation disturbed the operator or the machine?
6. What should move from memory into doctrine?

## 10. Stop Conditions

Pause expansion work when any of these are true:

- runtime health is unclear
- recovery paths are weaker than the new capability
- the promotion queue is growing faster than execution capacity
- noisy sources are outranking authoritative ones
- background automation is interfering with normal machine use

The right move in these cases is not “push harder.”
It is to restore system shape first.
