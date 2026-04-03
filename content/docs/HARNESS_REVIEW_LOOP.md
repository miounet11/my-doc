# Harness Review Loop

Status: active review doctrine
Date: 2026-03-31

## Purpose
Create a lightweight recurring review pass for the harness itself so drift, non-routing, and false-strength claims are caught early.

## Review Questions
1. Which harness assets were actually used this week?
2. Which existed but were not routed into live work?
3. Which tasks still produced vague completion language?
4. Which verification steps still failed to reconnect to the original ask?
5. Which blocked/degraded/mock states were labeled honestly?
6. Which repeated corrections should be promoted further into doctrine, skill, template, or runtime profile binding?
7. Which support docs still describe routing in skill-only terms even though runtime profiles are part of the live control layer?

## Failure Signals
- new doctrine exists but no corresponding skill/index/template uses it
- repeated completion inflation
- repeated stale-evidence reuse
- repeated context reconstruction uncertainty without better recovery surface
- repeated publish claims without fresh verification

## Actions
If a failure signal appears, do one of:
- strengthen routing (`HARNESS_INDEX.md` / bootstrap)
- create or improve a skill
- create or improve a template/checklist
- update durable memory with the correction

## Guardrail
Harness quality should be reviewed as a live system, not assumed from the mere presence of files.
