# Harness Checklist

Status: active checklist
Date: 2026-03-31

Use this before completion-style replies, publish claims, or historical reconstruction when the correct path is not instantly obvious.

## 1. Task Shape
- Is this heartbeat work?
- Is this normal task closure?
- Is this a publish/delivery claim?
- Is this context/earliest-history reconstruction?

## 2. Skill Routing / Profile Selection
- heartbeat -> `skills/heartbeat-closure/SKILL.md` + `heartbeat`
- normal closure -> `skills/task-closure/SKILL.md`
- mydoc publish -> `skills/mydoc-publish-verification/SKILL.md`
- context recovery -> `skills/context-recovery/SKILL.md` + usually `explore`
- implementation work -> `implement`
- adversarial validation -> `skills/verification-agent/SKILL.md` + `verify`
- blocked/degraded repair -> `recover`

## 3. Completion Gate
- What is the honest completion level?
- Is the evidence from this turn/current state?
- Am I overstating beyond the evidence?

## 4. Verification Contract
- What was the original ask?
- Did verification test the ask, not just the artifact?
- Is the evidence objective or only self-check?

## 5. Repair Loop
- If verification failed, what is the repair step?
- If repair cannot proceed, is it labeled `blocked` or `degraded`?
- Did I avoid a vague success summary?

## 6. Honesty Check
- Any stale evidence being reused as current?
- Any mock/illustrative output being treated as real?
- Any transcript truncation being mistaken for true first context?

## 7. Output Shape
Report using:
- completion/status level
- supporting evidence
- remaining gap or blocker
- next step when relevant
