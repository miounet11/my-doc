# Harness Index

Status: active routing doctrine
Date: 2026-04-01

## Purpose
Make the new harness backbone easy to select during live work. This file maps recurring task types to the correct protocol and skill surfaces so completion discipline does not depend on vague recollection.

## Core Backbone
Use these doctrine files as the default harness core for meaningful work:
- `docs/COMPLETION_GATE_PROTOCOL.md`
- `docs/VERIFICATION_CONTRACT.md`
- `docs/REPAIR_LOOP_PROTOCOL.md`

## Workflow Skills
### 1. Heartbeat work
Use:
- `skills/heartbeat-closure/SKILL.md`
Also apply:
- `HEARTBEAT.md`
- core backbone docs above

Trigger examples:
- configured heartbeat prompt
- periodic self-check / maintenance turn

### 2. General task completion / status reporting
Use:
- `skills/task-closure/SKILL.md`
Also apply:
- core backbone docs above

Trigger examples:
- about to say a task is done
- returning implementation or verification status
- finishing a meaningful execution task

### 3. Mydoc publish / document delivery claims
Use:
- `skills/mydoc-publish-verification/SKILL.md`
Also apply:
- `docs/MYDOC_PUBLISH_GUARDRAIL.md`
- core backbone docs above

Trigger examples:
- returning a mydoc URL
- claiming a doc was mirrored or published
- checking local vs remote delivery truthfully

### 4. Earliest context / first task / first requirement reconstruction
Use:
- `skills/context-recovery/SKILL.md`
Also apply:
- `docs/CONTEXT_RECOVERY_PROTOCOL.md`
- `MEMORY.md`
- recent `memory/YYYY-MM-DD.md`

Trigger examples:
- "what was the first task"
- "what was the earliest content"
- "what did I first ask you to do"

### 5. ACP / agent-runtime task closure
Use:
- `skills/acp-task-closure/SKILL.md`
Also apply:
- core backbone docs above

Trigger examples:
- reporting Codex / Claude Code / ACP session results
- deciding whether runtime activity equals verified completion

### 6. GitHub / PR / CI delivery closure
Use:
- `skills/github-delivery-closure/SKILL.md`
Also apply:
- core backbone docs above

Trigger examples:
- branch/PR/CI/merge status reporting
- deciding whether repo activity equals delivery success

### 7. Deploy / readiness closure
Use:
- `skills/deploy-readiness/SKILL.md`
Also apply:
- core backbone docs above

Trigger examples:
- service/app/process launch status
- local readiness vs external availability reporting

### 8. Cron / reminder / scheduled job closure
Use:
- `skills/cron-execution-closure/SKILL.md`
Also apply:
- core backbone docs above

Trigger examples:
- cron status reporting
- reminder execution verification
- scheduled job stale/error/running diagnosis

### 9. Outbound message / public-send closure
Use:
- `skills/outbound-message-closure/SKILL.md`
Also apply:
- core backbone docs above

Trigger examples:
- reply/send status reporting
- public post/notification delivery claims
- distinguishing drafted text from verified outbound delivery

### 10. Gateway / config change closure
Use:
- `skills/gateway-config-change-closure/SKILL.md`
Also apply:
- core backbone docs above

Trigger examples:
- gateway restart/config edit status reporting
- deciding whether file edits/reloads actually fixed runtime behavior

### 11. Node / device action verification
Use:
- `skills/node-device-action-verification/SKILL.md`
Also apply:
- core backbone docs above

Trigger examples:
- paired-node camera/screen/location/notification actions
- distinguishing dispatch from verified device-side effect

### 12. Independent verification / adversarial validation
Use:
- `skills/verification-agent/SKILL.md`
Also apply:
- core backbone docs above

Trigger examples:
- implementation appears complete and needs real verification
- checking code/runtime/UI/API/CLI/output against the original ask
- distinguishing self-check from adversarial task validation

## Default Routing Rule
If a task ends in a completion-style reply and no more specific skill applies:
1. use the completion/verification/repair backbone
2. default to `skills/task-closure/SKILL.md`
3. prefer the lower honest completion level if uncertain

## State Selection Rule
When choosing how strong a claim can be, prefer this order:
- `blocked`
- `degraded`
- `mock`
- `drafted`
- `implemented`
- `self-checked`
- `task-verified`
- `full-chain verified`

Do not skip upward without matching evidence.

## Recovery Rule
If the right skill is unclear:
1. identify the user's real ask
2. identify whether the main risk is completion honesty, publish honesty, or context reconstruction
3. pick the most specific skill matching that risk
4. if none fits, use the core backbone plus the lower honest completion level

## Guardrail
A harness asset that exists but is not routed into live work is only half-installed. Prefer explicit routing over hoping the model remembers doctrine unaided.
