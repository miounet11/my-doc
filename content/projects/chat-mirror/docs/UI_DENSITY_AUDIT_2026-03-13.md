# UI Density Audit - 2026-03-13

## Current baseline

- Desktop viewport measured on live site: `1440px` wide
- Previous shell split: left `320px`, chat `688px`, right `360px`
- Result: the chat work area was not the dominant surface, and the side rails collectively consumed nearly half of the viewport.

## Main problems found

1. The left rail filter looked like a full-width primary control instead of a compact utility.
2. The right rail stacked too many heavyweight cards, so context management visually competed with chat.
3. Typography and spacing were not oversized individually, but the combination of `320px + 360px` rails and repeated card padding created a crowded feeling.
4. The product looked more like three parallel dashboards than one chat-centered workspace.

## Reference principles used

### OpenAI

- OpenAI Academy notes that project-only memory is useful when you want a dedicated context environment and for context to stay anchored to a project’s goals and history.
- ChatGPT Study Mode guidance emphasizes attaching context in the prompt flow and selecting tools in the composer, which supports a chat-first surface with progressive disclosure for advanced controls.

Sources:
- https://academy.openai.com/en/public/clubs/work-users-ynjqu/resources/projects
- https://help.openai.com/en/articles/11780217

### Manus

- Manus Collab describes `one workspace, one version, zero confusion` and a single source of truth.
- Manus Cloud Browser positions action capabilities as something the assistant can use behind the scenes, while the user remains in one task workspace.

Sources:
- https://manus.im/docs/features/collab
- https://manus.im/docs/features/cloud-browser

### xAI / Grok

- xAI’s enterprise positioning emphasizes a unified platform, centralized access, and real-time usage visibility rather than multiple disconnected admin surfaces.

Source:
- https://x.ai/news/grok-business

## Design decisions for chat-mirror

1. Make chat the dominant surface again.
2. Compress left rail controls into a single compact row.
3. Merge right-rail search + current context into one overview card.
4. Merge import queue + quick note into one operational card.
5. Reduce desktop rail widths so the chat column regains working width.
6. Lower heading and utility font sizes slightly while preserving message readability.

## UI system decision

- The current frontend was not using a real UI framework; it was `React + Vite + hand-written CSS`.
- The next-stage upgrade path is `Tailwind CSS v4 + Radix UI primitives + shadcn-style local components`.
- Reason:
  - Radix gives reliable accessibility and interaction primitives for tabs, scroll areas, dialogs, tooltips, and composable triggers.
  - Tailwind gives a tokenized layout and density system that is much easier to evolve than the previous monolithic stylesheet.
  - The shadcn pattern keeps component source code inside the project, which is a better fit for a branded AI product surface than adopting a heavyweight pre-opinionated enterprise kit.

## Target desktop posture

- Left rail: narrow and utilitarian
- Center: dominant conversation workspace
- Right rail: contextual drawer, not parallel dashboard

## Implemented changes

1. Left-rail filter is now on-demand instead of permanently occupying a second wide control slot.
2. The right rail was restructured into `概览 / 搜索 / 资料` views so only one primary context task is foregrounded at a time.
3. Advanced Agent / Skill editing was pushed behind `展开高级编排`, keeping the default surface chat-first.
4. Desktop shell widths were reduced again to push more width into the conversation column.

## Post-change measurements

- Desktop viewport measured on live site: `1440px`
- Updated shell split: left `264px`, chat `844px`, right `284px`
- Left rail utility row height: `41px`
- Right rail tab row height: `35px`

Result:

- The chat column regained `156px` of working width compared to the earlier `688px` baseline.
- The left rail no longer presents filtering as a dominant primary action.
- The right rail now behaves more like a contextual workspace switcher than a second dashboard.

## Follow-up

1. Add collapsible subsections in the right rail for even denser expert workflows.
2. Introduce a compact mode for the left rail when the user is actively chatting.
3. Continue tuning vertical rhythm around the composer and message action rows.
