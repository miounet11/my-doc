# AibrowserAtlas Real Environment Roadmap

Principle:
- An environment is only allowed onto the product surface when the backend can emit a real artifact and acceptance can download it end-to-end.
- Planning copy alone is not a shippable environment.

## Live now

- `Slides` -> real `.pptx`
- `Docs` -> real `.docx`
- `Website` -> real multi-file `.zip`
- `Story Kit` -> real narrative `.zip`
- `Spreadsheet Kit` -> real `.xlsx`
- `Contract Review Kit` -> real review `.zip`
- `Research Kit` -> real research `.zip`
- `Playbook Kit` -> real operating `.zip`
- `Design Kit` -> real design `.zip`
- `Scheduled Task Kit` -> real automation `.zip`
- `Visualization Kit` -> real dashboard `.zip`

### Playbook Kit
- live now as an operating ZIP package
- current output includes:
  - overview
  - workflow
  - templates
  - operating rules
  - success metrics
- why it matters:
  - turns repeated chat guidance into a reusable system
  - gives teams a portable SOP instead of relying on conversation history

### Design Kit
- live now as a design ZIP package
- current output includes:
  - creative brief
  - visual system
  - screen flows
  - content guide
  - implementation notes
- why it matters:
  - turns abstract design discussion into a portable implementation brief
  - gives product, design, and frontend the same source package instead of fragmented chat decisions

### Scheduled Task Kit
- live now as an automation ZIP package
- current output includes:
  - automation brief
  - automation manifest
  - task schedules JSON
  - runbook
  - delivery rules
  - structured schedule JSON
- why it matters:
  - turns recurring chat instructions into a portable automation package
  - gives operators and engineers one shared plan for triggers, cadence, outputs, and recovery

### Visualization Kit
- live now as a dashboard ZIP package
- current output includes:
  - overview
  - metrics CSV
  - chart specs JSON
  - browser-ready dashboard HTML
  - structured visualization JSON
- why it matters:
  - turns chat context into a portable decision dashboard instead of leaving analysis trapped in prose
  - gives operators a lightweight artifact they can open, share, and extend without rebuilding charts by hand

## Spreadsheet Kit coverage now

`Spreadsheet Kit` is the current home for several high-frequency operator workflows:
- Excel-style intake and response forms
- Ticketing and event operations
- Accounting, expense, and income tracking
- Budget and operating tables
- General project trackers and milestone sheets

These are intentionally bundled under one workbook capability because they share the same real artifact format and keep implementation cost low while producing direct user value.

## Next likely real environment

### Audio Kit
- not live yet
- shipping bar:
  - real script + shot/audio plan bundle
  - downloadable production assets instead of creative advice only
  - acceptance must verify a valid artifact archive end to end
- why it matters:
  - complements slides, docs, design, and visualization with a real media-delivery path

## Later environment candidates

### Contract Review Kit
- live now as a review ZIP package
- current output includes:
  - review summary memo
  - clause table CSV
  - redlines memo
  - negotiation checklist
  - open questions list
- current guardrail:
  - it is a structured commercial review assistant, not a substitute for licensed legal counsel

### Legal / Agreement File Review
- should evolve from the same underlying pipeline as `Contract Review Kit`
- next bar is deeper document parsing and issue extraction, not a new empty mode label

## Product guardrail

Do not split one artifact class into many separate UI modes unless the backend behavior and user outcome are meaningfully different.
