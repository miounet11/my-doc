# OpenClaw vs maoclaw Day 2 Results

Status: active
Date: 2026-03-31

Related:
- [`docs/OPENCLAW_VS_MAOCLAW_DAY1_RESULTS_2026-03-30.md`](/Users/lu/.openclaw/workspace/docs/OPENCLAW_VS_MAOCLAW_DAY1_RESULTS_2026-03-30.md)
- [`docs/OPENCLAW_VS_MAOCLAW_ACCEPTANCE_MATRIX_2026-03-30.md`](/Users/lu/.openclaw/workspace/docs/OPENCLAW_VS_MAOCLAW_ACCEPTANCE_MATRIX_2026-03-30.md)

## Scope

Day-2 checks focused on:
- short continuity recall
- multi-file recovery
- persisted-session inspectability

## Test 1: Short Continuity Recall

### OpenClaw

#### Turn 1
- command:
  - `openclaw agent --to +19990000001 --message "Remember codename ALPHA-729 and reply READY only." --json`
- result:
  - returned `READY`

#### Turn 2
- command:
  - `openclaw agent --to +19990000001 --message "What codename was I asked to remember? Reply only the codename." --json`
- result:
  - returned `ALPHA-729`

#### interpretation
- continuity passed on the tested Gateway path
- one caveat remains:
  - routing landed on the existing `agent:main:main` session rather than giving obvious isolated-session evidence for the fake target

### maoclaw

#### Turn 1
- command:
  - `pi --session-dir /Users/lu/.maoclaw-eval/sessions-continuity -p "Remember codename ALPHA-729 and reply READY only."`
- result:
  - returned `READY`

#### Turn 2
- command:
  - `pi --session-dir /Users/lu/.maoclaw-eval/sessions-continuity -c -p "What codename was I asked to remember? Reply only the codename."`
- result:
  - returned `I don't know`

#### inspectability
- the specified session dir remained empty:
  - `/Users/lu/.maoclaw-eval/sessions-continuity`
- no inspectable session rows were returned from the session index for this flow

#### interpretation
- the tested print-mode continuation path did not preserve recoverable session state in the way required for this benchmark
- this is a real continuity defect for the tested flow, even if another interactive/session mode may behave differently

## Test 2: Multi-File Recovery

Prompt used on both runtimes:
- read `memory/2026-03-29.md`
- read `handoffs/20260318-072522.md`
- return JSON with:
  - `unfinished_job`
  - `handoff_status`

### OpenClaw
- returned:
  - `{"unfinished_job":"replace the blocked benchmark placeholder with a real measurement harness","handoff_status":"incomplete"}`
- result quality:
  - correct
  - slower than `maoclaw` on this task (`~17.3s`)

### maoclaw
- returned:
  - `{"unfinished_job":"replace the mock benchmark path with a real measurement harness/path before resuming benchmark trend reporting","handoff_status":"incomplete"}`
- result quality:
  - correct
  - cleaner latency on this task than OpenClaw in the tested flow

## Day-2 scoring adjustments

### OpenClaw
- Long-session continuity: raise from `1` to `2`
  - short continuity recall passed
- Context/history recovery: raise from `1` to `2`
  - multi-file recovery passed cleanly

### maoclaw
- Long-session continuity: set to `0`
  - tested continuation recall failed
- Context/history recovery: raise from `1` to `2`
  - multi-file recovery passed cleanly
- Provider/session control: keep at `1`
  - mirrored provider route is working
  - session persistence semantics remain unclear in the tested non-interactive flow

## Current conclusion

After day 2:
- OpenClaw is still stronger on continuity under the tested runtime path.
- maoclaw is now clearly competitive on direct file-based recovery tasks.
- The migration question is still open, but the evidence is no longer one-sided:
  - OpenClaw wins continuity
  - maoclaw is cleaner and faster on at least one direct recovery task
  - maoclaw still has a real continuity deficit in the tested print-mode continuation path
