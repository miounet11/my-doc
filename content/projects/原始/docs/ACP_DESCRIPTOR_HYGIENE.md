# ACP Descriptor Hygiene

## Rule

- project artifacts may describe ACP work only with a complete descriptor contract
- allowed keys:
  - `task`
  - `runtime`
  - `agentId`
  - `thread`
  - `mode`
  - `cwd`
  - `label`
  - `streamTo`

## Forbidden Narrative Forms

- extra ad-hoc fields outside the descriptor contract
- pseudo-task names that encode transport or persistence fantasies instead of a real task
- incomplete spawn snippets that omit required routing context

## Project Handling

- historical invalid strings stay only in audit artifacts and contamination records
- evidence board, loop closures, supervision prompts, and cleanup plans must reference them as categories, not as reusable templates
- if a future ACP plan cannot be expressed with the allowed keys above, it is not a valid next step
