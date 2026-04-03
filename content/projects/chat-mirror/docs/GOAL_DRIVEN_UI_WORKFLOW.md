# Goal-Driven UI Workflow

## Standard Delivery Flow

Use this flow for product UI and for generated design or website outputs.

1. Define the goal
   - What outcome should the user reach?
   - What business or operator value does this screen create?

2. Define the primary user action
   - What is the one action this surface should make easiest?
   - What actions should stay secondary or contextual?

3. Build the information structure
   - What belongs in the primary lane?
   - What belongs behind a drawer, hover state, or later screen?
   - What should never compete with the main action?

4. Define key states
   - empty
   - active
   - loading
   - success
   - failure
   - mobile-compressed
   - returning-user or recovery state when relevant

5. Define reusable components
   - name
   - purpose
   - surfaces where it appears
   - behavior rules
   - implementation hint

6. Define visual direction
   - typography
   - spacing rhythm
   - contrast strategy
   - accent usage
   - motion rules

7. Define implementation order
   - build the conversion path first
   - build reusable primitives second
   - polish variants last

## Required Deliverables

### For design outputs
- creative brief
- visual system
- screen flows
- key states
- component map
- prototype plan
- implementation notes

### For website outputs
- information architecture
- page map
- user flows
- component guide
- implementation plan
- deploy guide

### For playbook outputs
- workflow
- decision checkpoints
- required artifacts
- operating rules
- failure modes
- success metrics

### For automation outputs
- job register
- delivery routes
- monitoring checks
- recovery runbook
- operator checkpoints

## Constraints

Always optimize for:
- lower cognitive load
- stronger hierarchy
- system reuse
- responsive clarity
- implementation realism
- maintainability

Do not optimize for:
- decorative complexity
- duplicate explanation blocks
- dashboard noise without action value
- fake feature signaling

## Frontend Review Gate

A UI change is not ready when:
- the user still needs explanation to understand the main path
- the primary action competes with too many secondary controls
- mobile compression destroys reading or composition quality
- the component logic is not reusable
- the design cannot be described as a stable system
