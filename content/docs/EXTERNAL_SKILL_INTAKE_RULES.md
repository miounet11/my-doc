# External Skill Intake Rules

Purpose: convert external skill browsing into a disciplined intake process instead of impulsive installs or vague inspiration.

## Intake order

When reviewing an external skill:
1. classify it before admiring it
2. record whether the goal is install, reference, or absorption-only
3. check security scan status and any platform warnings
4. separate reusable ideas from installable behavior
5. map useful parts into first-party docs/rules before considering installation

## Decision classes

Every external skill reviewed should fall into one of:
- `install-candidate`
- `reference-only`
- `absorb-patterns`
- `reject`

## Required review fields

Each reviewed external skill should capture:
- source URL
- security scan status
- overlap with first-party OpenClaw capabilities
- install pressure level (`low` / `medium` / `high`)
- final decision class
- what is being absorbed into first-party doctrine, if anything

## Default downgrade rules

- If a skill encourages blind `npx`, global install, skipped prompts, or unmanaged third-party execution, default to `reference-only` or `reject`.
- If a skill duplicates a first-class built-in OpenClaw capability, default to `absorb-patterns` instead of install.
- If a skill mainly improves judgment, vetting, or structure, prefer absorbing its doctrine into first-party files.
- If runtime complexity is high and capability overlap already exists, do not install just because the description is strong.

## First-party absorption rule

Before any external install, first ask:
1. can this be captured as a local checklist, protocol, or registry rule?
2. can the useful idea be mapped into existing first-party tools?
3. would installation add a genuinely new execution surface, or just duplicate one?

If the answer is mostly checklist / doctrine / overlap, absorb first and defer installation.

## Trial adoption rule

When the user explicitly wants a more open stance, do not jump from caution to broad integration.
Use this ladder instead:
1. `reference-only`
2. `absorb-patterns`
3. `install-candidate`
4. **bounded trial adoption** for one narrow use case
5. broader integration only after local evidence

Bounded trial adoption must specify:
- one narrow use case
- one success signal
- one rollback condition
- no claim of general integration before proof

## Initial examples from current review

### Skill Vetter
- class: `absorb-patterns`
- reason:
  - strong fit with evidence-first and anti-contamination doctrine
  - more valuable as a fixed vetting checklist than as another installed surface

### self-improving-agent
- class: `absorb-patterns`
- reason:
  - useful learning/logging structure
  - but heavy logging/hook surface risks producing reflection theater instead of real leverage

### Agent Browser
- class: `reference-only`
- reason:
  - useful command-surface ideas
  - overlaps with existing first-class browser tooling
  - high runtime complexity makes direct install lower priority

### Find Skills
- class: `reference-only`
- reason:
  - useful for discovery concepts
  - but suspicious install guidance (`npx`, global install, skipped confirmation) makes it a poor direct adoption model

## Long-term guardrail

External skill review should improve OpenClaw's own brain, not just expand the number of things it could theoretically install.

## Success condition

A skill browsing pass is successful only if it leaves behind one of:
- a safer intake rule
- a clearer registry classification
- a first-party protocol or checklist
- a bounded install decision with explicit risk level
