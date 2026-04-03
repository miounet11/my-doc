# SKILLS_2_0_HARNESS_PRACTICE.md

Status: active design doctrine
Date: 2026-03-31

## Purpose
Define the target operating model for OpenClaw after introducing harness logic and Skills 2.0 principles. The goal is not just to have more skills, but to make memory, capability, verification, routing, and recovery work as one system.

## Core Principle
OpenClaw should behave as a harnessed brain:
- memory should preserve durable truth without bloat
- capabilities should be routed through reusable workflows
- completion should be evidence-gated
- verification should anchor to the original ask
- failures should enter repair loops
- skills should be small, specific, triggerable, and composable

## Skills 2.0 Model
### Layer 1: Metadata
Each skill should clearly state:
- when to use it
- when not to use it
- required inputs
- risk/verification surface

### Layer 2: Short Routing Summary
Each skill should be discoverable with minimal context cost.
A routing layer should know:
- which task shape maps to which skill
- what protocol backstops it
- what completion level is likely relevant

### Layer 3: Full Operating Procedure
Each skill should encode:
- ordered execution steps
- verification method
- blocked/degraded handling
- output shape
- artifact expectations

## Harness Planes
### 1. Execution Harness
Controls:
- task stages
- completion levels
- repair loops

### 2. Knowledge Harness
Controls:
- memory promotion
- doctrine creation
- skill/checklist/template creation
- anti-drift learning reuse

### 3. Capability Harness
Controls:
- which execution surface is appropriate
- how publish/delivery claims are verified
- how environment/tool limits are labeled honestly

### Cross-Cutting Planes
#### Guardrail Plane
Prevents:
- completion inflation
- stale evidence reuse
- artifact self-worship
- context hallucination
- mock leakage

#### Observability Plane
Requires:
- inspectable artifacts
- evidence-based memory entries
- visible blocked/degraded labels
- reviewable routing and state decisions

## Perfect-Practice Target
The target is not "many skills" but this loop:
1. user ask recognized
2. correct skill routed early
3. completion/verification/repair backbone applied
4. work executed with honest state labels
5. durable lesson promoted when needed
6. review loop checks whether the asset was actually used

## Skill Taxonomy
### A. Closure Skills
- heartbeat-closure
- task-closure
- acp-task-closure (planned)
- github-delivery-closure (planned)
- deploy-readiness (planned)

### B. Recovery / Truthfulness Skills
- context-recovery
- mydoc-publish-verification

### C. Learning / Governance Skills
- memory-promotion
- harness-review

## Retirement Rule for Old / Low-Value Skills
A skill is a retirement candidate if most of the following are true:
1. it duplicates another stronger skill without adding a distinct workflow
2. it describes vague behavior rather than an executable process
3. it lacks verification and blocked/degraded handling
4. it is not routed from any real task shape
5. its value is better absorbed into doctrine/checklist/template than kept as a standalone skill

Retire by:
- archiving it under `refs/` or a dedicated retired-skill note if historical value exists
- removing it from active routing/index docs
- preserving only the parts that remain genuinely useful

## New Skill Creation Rule
Create a new skill only if it has:
- a stable trigger shape
- a bounded workflow
- a distinct verification surface
- repeat value across turns
- lower drift than relying on free-form reasoning

If the pattern is too small, use a checklist/template instead.
If the pattern is too broad, break it into smaller skills.

## Memory Perfection Standard
### Daily Memory
Should capture:
- what was reviewed
- what defect or gap was found
- what changed
- what evidence exists now
- what still remains open

### Durable Memory
Should preserve only:
- enduring truths
- active guardrails
- routing-critical lessons
- evidence doctrine
- recurring correction rules

### Promotion Rule
A correction that matters after restart should not stay only in chronology.
A correction that changes workflow should usually become doctrine, skill, checklist, template, or routing.

## Capability Perfection Standard
OpenClaw should know not only what tools exist, but:
- which tool surface is appropriate
- what counts as real evidence on that surface
- when execution is sandbox-limited, degraded, or blocked
- when external delivery is actually verified versus merely prepared

## Recommended Next Reorganization
### Keep as active harness skills
- heartbeat-closure
- task-closure
- mydoc-publish-verification
- context-recovery
- harness-review
- memory-promotion

### Create next
- acp-task-closure
- github-delivery-closure
- deploy-readiness

### Convert into support assets rather than broad skills
- quickstarts
- templates
- anti-pattern docs
- state map docs
- upgrade ladder docs

These should support routing and execution, not compete with skills.

## Final Doctrine
Skills 2.0 does not mean "more skill files". It means:
- fewer, sharper skills
- stronger routing
- stronger verification
- stronger memory promotion
- stronger repair honesty
- less dependence on hidden prompt memory
