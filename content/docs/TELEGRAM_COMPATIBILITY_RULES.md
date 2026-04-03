# Telegram Compatibility Rules

## Purpose
Make sure important OpenClaw outputs remain deliverable, readable, and useful on Telegram instead of assuming that internally good messages will render or arrive well there.

Telegram is the primary communication channel. Output style must fit Telegram-first communication: clear logic, high information density, concise delivery.

## Core Principle
A message is not fully successful merely because it was generated. For Telegram-facing communication, success means:
- it can be delivered reliably
- it is readable in Telegram form
- the key conclusion survives platform constraints
- it respects the user's preferred communication style

## Telegram-First Style
### Required style
- conclusion first
- short paragraphs
- clear structure
- high information density
- concise wording
- no weekly-report style verbosity

### Avoid
- long essays when a short operational update is enough
- over-explaining routine steps
- large blocks of nested bullets
- padded openings and repetitive summaries

## Output Strategy
### 1. Put the conclusion first
Important Telegram updates should begin with the key outcome before any long explanation.

### 2. Prefer shorter chunks
When content is long or structurally dense, split it into smaller messages or give the short conclusion first and details second.

### 3. Reduce formatting fragility
Avoid overusing:
- deeply nested lists
- huge code blocks
- formatting that depends on perfect markdown rendering
- large mixed attachment/text payloads without need

### 4. Optimize for scanability
Telegram messages should be easier to scan than webchat output:
- short paragraphs
- fewer nested bullets
- top-line summary
- explicit next step

## Default Update Format
For most progress feedback, prefer this shape:
1. current status
2. what changed
3. what remains
4. next step / ETA if useful

Example shape:
- 现在状态：…
- 新进展：…
- 还差：…
- 下一步：…

## Compatibility Risks
Common risk categories:
- message too long
- formatting/render mismatch
- attachment + caption mismatch
- reply/reference behavior not preserved as expected
- provider/plugin delivery differences between internal generation and Telegram display

## Delivery Rule
For important progress updates:
1. send the one-line conclusion first
2. then send the supporting bullets if needed
3. if the content is very large, summarize instead of dumping everything at once

## Delivery Rule
For important progress updates:
1. send the one-line conclusion first
2. then send the supporting bullets if needed
3. if the content is very large, summarize instead of dumping everything at once

## Completion Return Path Rule
Completion-return-path is mandatory.

If work was user-facing and OpenClaw internally considers it complete, Telegram should receive a concise completion update in Telegram-compatible form.

A task is not fully communication-complete merely because the internal run finished.

## Attachment Rule
When an image or media item is involved:
- keep the caption concise
- avoid pairing a huge explanation with media in the same send when not necessary
- if analysis is long, send the image/media and then a separate follow-up explanation

## Brain Guardrail
Do not confuse internal completeness with Telegram completeness.
A platform-compatible message is better than a technically complete message that arrives badly or not at all.

## Success Condition
Telegram compatibility is healthy when:
- key conclusions reach the user reliably
- long updates do not vanish into formatting or length problems
- important state changes can be understood without needing the full internal transcript
- the user can quickly scan the message and know what matters
