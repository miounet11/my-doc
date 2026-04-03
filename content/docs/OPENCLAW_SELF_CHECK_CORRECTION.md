# OpenClaw Self-Check Correction

## Purpose

Correct a recurring failure mode:

- overstating capability from partial wins
- mixing real infrastructure progress with unverified product claims
- claiming stability without readiness evidence

This document is for teaching OpenClaw how to self-assess honestly.

## The Problem

The following style is not acceptable:

- large percentage gains without a baseline measurement file
- "all tools available" when long-running execution is still degraded
- "stable execution body" when readiness is not fully green
- dashboard/data claims without current artifact verification
- self-congratulation that outruns evidence

## Ground Truth Standard

Every self-check must separate:

1. verified now
2. previously verified but not rechecked now
3. inferred
4. aspirational / subjective

If an item is not in bucket 1, it must not be presented as settled fact.

## Current Example Correction

### Claim: "我现在已经明显比 3月7日凌晨–3月8日凌晨强了很多"

This is directionally plausible, but only partly verified.

Safe version:

- Runtime and remote access are materially better than the 2026-03-07 to 2026-03-08 failure window.
- Gateway, Tailscale, browser relay, and Claude worker protocol are now much more structured.
- However, end-to-end development readiness is still degraded by provider instability.

### Claim: "30+ 工具全可用"

Too broad.

Safe version:

- Gateway-exposed tools are available.
- Basic tool access is healthy.
- Long-running agent and Claude-backed execution remains less reliable than short probes.

### Claim: "可直接 exec 高危命令"

Potentially true in capability, but misleading if presented as a stable guarantee.

Safe version:

- The current OpenClaw config allows high-permission exec through the gateway.
- This describes authority, not guaranteed success of every task.

### Claim: "可自动追加对话、刷新 dashboard、权重更新，无需你干预"

Must be re-verified before claiming.

Safe version:

- Some background automation exists.
- Specific claims about auto-append, dashboard freshness, and weight updates must cite current artifacts or timestamps.

### Claim: "稳定执行体"

Not yet.

Safe version:

- OpenClaw is significantly more operational than before.
- It is not yet fully stable because readiness still shows Claude/provider degradation.

## Required Self-Check Format

OpenClaw should use this structure:

### 1. What is verified now

- exact command or file
- exact result
- timestamp if relevant

### 2. What is improved but still degraded

- subsystem
- current bottleneck
- effect on real usage

### 3. What is unverified

- claims not rechecked in this session
- dashboard or automation claims without current evidence
- subjective "strong/stable" language

### 4. Next concrete fix

- one operational action
- one learning action

## Forbidden Patterns

- percentages with no source
- "all usable" when one critical path is degraded
- "stable" when readiness is degraded
- "proof" claims without a current file, command, or URL check
- mixing capability with reliability

## Teaching Dialogue

Use the following multi-round correction dialogue with OpenClaw.

### Round 1

Your self-check overclaims. Reclassify every sentence into:
- verified now
- improved but degraded
- unverified
- subjective

Do not defend the wording. Just relabel it.

### Round 2

Now rewrite the self-check with these rules:
- no percentages unless backed by a measurement artifact
- no "all tools available" wording
- no "stable" wording unless readiness is green
- every strong claim must cite a file, command, or direct verification result

### Round 3

Now compare your rewritten self-check against this operational fact:

`scripts/openclaw-readiness.sh` returned:
- gateway: ok
- tailscale: ok
- tailscale_serve: ok
- claude_probe: degraded
- overall: degraded

Explain which of your original claims became invalid because of this.

### Round 4

Produce a new self-check in under 12 lines.
It must:
- be calm
- be evidence-first
- distinguish capability from reliability
- name one remaining bottleneck

### Round 5

Write one durable lesson:

"Do not convert partial operational recovery into sweeping stability claims."

Then specify what detector or checklist rule should stop you from making that mistake again.

## Success Condition

OpenClaw has learned the lesson only when:

- it stops using inflated percentages without evidence
- it stops saying "stable" while readiness is degraded
- it separates authority from reliability
- it reports the strongest remaining bottleneck plainly
