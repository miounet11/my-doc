# Retired / Merge Candidates for Harness Era

Status: review note
Date: 2026-03-31

## Purpose
Record which harness support assets are not standalone workflow skills and should not be treated as first-class skills.

## Keep As Support Assets, Not Skills
These are useful, but should remain doctrine/checklist/template/reference rather than promoted as separate active skills:
- `docs/HARNESS_QUICKSTART.md`
- `docs/HARNESS_CHECKLIST.md`
- `docs/HARNESS_STATE_MAP.md`
- `docs/HARNESS_ANTI_PATTERNS.md`
- `docs/HARNESS_UPGRADE_LADDER.md`
- `docs/HARNESS_REVIEW_LOOP.md`
- `docs/RUNTIME_PROFILES.md`
- `docs/TASK_TEMPLATE_VERIFIED_DELIVERY.md`
- `docs/TASK_TEMPLATE_CONTEXT_RECOVERY.md`
- `docs/TASK_TEMPLATE_MYDOC_PUBLISH_CHECK.md`

## Why
They do not define distinct end-to-end workflows with their own trigger + verification surface. Their value is as support material for routing, review, and execution quality.

## Active Harness Skill Set
The current first-class harness skills should be:
- `skills/heartbeat-closure/SKILL.md`
- `skills/task-closure/SKILL.md`
- `skills/mydoc-publish-verification/SKILL.md`
- `skills/context-recovery/SKILL.md`
- `skills/harness-review/SKILL.md`
- `skills/memory-promotion/SKILL.md`
- `skills/acp-task-closure/SKILL.md`
- `skills/github-delivery-closure/SKILL.md`
- `skills/deploy-readiness/SKILL.md`
- `skills/cron-execution-closure/SKILL.md`
- `skills/outbound-message-closure/SKILL.md`
- `skills/gateway-config-change-closure/SKILL.md`
- `skills/harness-gardening/SKILL.md`
- `skills/node-device-action-verification/SKILL.md`
- `skills/verification-agent/SKILL.md`

## Planned Next First-Class Skills
- none right now; add new first-class skills only when a recurring workflow lacks a distinct end-to-end trigger + verification surface

## Guardrail
Do not inflate the skill layer with support documents. Skills 2.0 means sharper workflow assets, not more labels.
