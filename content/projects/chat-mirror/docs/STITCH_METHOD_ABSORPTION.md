# Stitch Method Absorption

## Purpose

This document defines what AibrowserAtlas should learn from modern AI-native design tooling without copying fake capability claims.

The target is not "use another product to design for us".
The target is to internalize the production method behind strong AI-native interface work.

## What We Learn

### 1. Language to structure first

A raw request should not stay as prose for long.
It should be translated into:
- product goal
- primary user action
- information hierarchy
- reusable components
- key states
- implementation sequence

### 2. Design is a continuous loop, not a handoff chain

Preferred operating loop:
- goal
- user flow
- page or screen structure
- key states
- high-fidelity direction
- prototype checks
- component mapping
- implementation

Avoid slow relay chains where product, design, and frontend each rebuild the same intent from scratch.

### 3. Design systems are production assets

A good output is not only a pretty page.
It should carry reusable rules for:
- layout rhythm
- component behavior
- brand language
- responsive behavior
- implementation constraints

### 4. Variants are for comparison, not for noise

Generate variants only when they support a real decision:
- different conversion emphasis
- different device context
- different reading density
- different trust posture

Do not generate decorative variations with no product consequence.

### 5. Prototype early, then narrow

Words are not enough for most UI decisions.
The team should move quickly toward inspectable interface states.
The prototype is the communication layer between product intent and engineering implementation.

### 6. Human and AI roles must stay explicit

Human responsibilities:
- decide the goal
- judge tradeoffs
- choose what to emphasize
- reject fake complexity

AI responsibilities:
- expand structure
- generate alternatives
- draft systems and artifacts
- speed up refinement
- preserve consistency across outputs

## What This Means For AibrowserAtlas

### UI work

Every UI task should move through this order:
1. goal
2. user action
3. structure
4. key states
5. component map
6. visual direction
7. implementation

### Generated outputs

Design, website, playbook, and automation artifacts should include more than content.
They should include:
- the governing goal
- the intended user action or conversion
- reusable structure
- operator or reviewer checkpoints
- implementation guidance

### Product policy

Do not claim:
- live canvas editing
- voice-driven editing
- Figma sync
- interactive prototype systems

unless the runtime really supports them.

Absorb the method.
Do not fake the feature.

## Review Questions

Before shipping a new UI or generator, check:
- Does it start from the user goal or from internal system mechanics?
- Does it make key states explicit?
- Does it reduce cognitive load or only add visual polish?
- Does it create reusable system value or only a one-off artifact?
- Can frontend implement it without reconstructing hidden design logic?
