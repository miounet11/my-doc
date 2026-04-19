# Context Recovery Protocol

Status: active doctrine
Date: 2026-03-30

## Problem
OpenClaw can lose the true start of a conversation when runtime transcript access is truncated, sandboxed, or split across storage surfaces. This causes false confidence about "first task", "first requirement", or the original phase of work.

## Rule
When asked about earliest context, first task, first user requirement, or conversation origin:
1. classify current evidence as `verified-now`, `historical-evidence`, `truncated`, `blocked`, or `unknown`
2. do not answer from the earliest visible snippet if transcript history is truncated unless that limitation is made explicit
3. prefer durable workspace records before conversational guessing: `MEMORY.md`, `memory/YYYY-MM-DD.md`, `refs/`, doctrine files
4. if transcript history is incomplete, say so plainly and separate:
   - earliest visible content
   - earliest verified durable memory
   - unknown / blocked earlier context

## Recovery Order
1. workspace bootstrap files: `SOUL.md`, `USER.md`, `MEMORY.md`, recent `memory/YYYY-MM-DD.md`
   - If a relevant recent daily memory file is missing, create or require an absent-source placeholder before treating the gap as evidence. The placeholder must preserve the exact missing path/error, label the missing chronology as `blocked`, and state that the file is non-evidence rather than reconstructed history.
2. external memory under `~/.openclaw/memory/` when it contains older or agent-level evidence not mirrored into workspace memory
3. ready handoff artifacts under `workspace/handoffs/`; incomplete or TODO-only handoffs must not outrank durable memory
4. relevant `refs/` documents that preserve older operating history
5. session history / transcript surfaces when available, with the Gateway/session store treated as authoritative for current live session identity
6. only then summarize earliest known context

## Recovery Audit
Use `scripts/openclaw-context-recovery-audit.sh` to inspect which recovery surfaces actually exist now.
Use `scripts/openclaw-recovery-preview.sh` to get the preferred next-session recovery order with the current ready handoff, recent memory files, and live session authority path.

The audit output should be treated as stronger evidence than conversational claims about what is or is not accessible.

## Repair Requirement
If repeated confusion appears around lost openings, promote the correction into doctrine or bootstrap files instead of relying on chat memory.

## Honest Output Shape
When earliest context is uncertain, answer in this form:
- earliest visible content:
- earliest durable evidence:
- blocked / missing history:
- confidence:

## Guardrail
Do not collapse `earliest visible` into `true first`.
Transcript truncation is a degraded state, not proof that earlier context did not exist.
