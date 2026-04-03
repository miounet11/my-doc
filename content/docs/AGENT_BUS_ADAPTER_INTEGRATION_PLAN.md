# Adapter Integration Plan

## Goal
Move from contract-only design to real runtime-backed collaboration while preserving evidence honesty.

## Sequence
1. implement ACP adapter first as primary structured runtime
2. add trace-writer helper so every ACP run leaves a task directory
3. add smux adapter next for shared-terminal collaboration experiments
4. add ACPX adapter once ACP path is stable enough to compare semantics

## Success Criteria
- a real run can create `00-task.yaml` and at least one downstream stage artifact
- adapter failures are labeled blocked/degraded instead of swallowed
- builder/reviewer/verifier separation remains visible in trace files
- transport-specific output never becomes the only proof of completion
