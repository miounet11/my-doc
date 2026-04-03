# projectctl Harness Notes

Status: active draft
Date: 2026-03-30

Purpose: connect the harness doctrine to the main project control surface without pretending the shell script is already fully harness-aware.

## What `scripts/projectctl.sh` Already Provides
`projectctl.sh` is already a central execution surface for project work. It exposes command families around:
- project state and metadata (`status`, `set-status`, `doctor`)
- briefs and Claude/Codex execution (`brief`, `squad-brief`, `run-claude`, `complex-cycle`, `supervise-codex`)
- session and autonomy evidence (`session-evidence`, `autonomy-evidence`, `autonomy-guard`)
- ACP dispatch and audits
- deployment, browser, memory-bank, and operational helpers

That makes it a real harness surface, not just a helper script.

## Current Gap
The script exposes many useful actions, but it does not yet make the harness model explicit.
In particular, it does not consistently require callers to think in terms of:
- current stage
- missing artifact
- evidence state
- work type (execution / knowledge / capability repair / guardrail repair / observability repair)
- expected verification output

So the doctrine now exists, but enforcement is still partly social/documentary.

## Immediate Use Rule
Until deeper script changes happen, any use of `projectctl.sh` for meaningful work should be judged with these extra questions:
1. What stage is this command serving?
2. What artifact should exist after it runs?
3. What evidence surface should verify the result?
4. If the command fails or degrades, how will that be labeled?
5. Does this call strengthen execution, knowledge, capability, guardrail, or observability quality?

## Command Family Mapping

### `status`, `doctor`
Primary harness role:
- execution state inspection
- capability inspection
- scaffold health

Expected artifact/evidence:
- structured project state
- explicit missing requirements
- inspectable command output

### `brief`, `squad-brief`
Primary harness role:
- frame / plan stage support
- artifact handoff into downstream execution

Expected artifact/evidence:
- brief doc or output directory
- explicit next-stage target

### `run-claude`, `complex-cycle`, `cycle`
Primary harness role:
- build / review / verify execution

Expected artifact/evidence:
- changed files
- run output
- iteration evidence
- follow-up verification surface

### `session-evidence`, `autonomy-evidence`, `autonomy-guard`
Primary harness role:
- observability plane
- guardrail plane

Expected artifact/evidence:
- inspectable session or autonomy evidence
- explicit degraded labeling if evidence is incomplete

### `supervise-codex`, `internal-council`
Primary harness role:
- knowledge harness
- guardrail repair
- routing / judgment reclamation

Expected artifact/evidence:
- explicit findings
- reclaim plan
- named brain/harness function to improve next

### ACP / session audits
Primary harness role:
- capability harness
- observability plane

Expected artifact/evidence:
- valid ACP descriptor
- audit result
- explicit failure classification when dispatch is invalid or degraded

## Near-Term Improvement Targets
The next real upgrades to `projectctl.sh` should probably be:

1. **Stage-aware wrappers**
   Add helper flows or notes that explicitly tag commands by stage.

2. **Artifact hints**
   For major commands, print the expected artifact or verification surface after execution.

3. **Evidence-state output**
   Encourage commands to label results as verified / blocked / degraded / partial instead of generic success/failure only.

4. **Review-friendly summaries**
   Make major command outputs easier to use in heartbeat, postmortem, and supervision loops.

## Sharp Rule
A powerful control script is only a mature harness surface when it helps the operator preserve stage clarity, artifact discipline, and evidence honesty — not just when it can launch many actions.
