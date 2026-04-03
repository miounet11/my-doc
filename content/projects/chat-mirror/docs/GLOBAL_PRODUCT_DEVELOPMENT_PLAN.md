# AibrowserAtlas Global Product Development Plan

Last updated: `2026-03-14`
Scope owner: `AibrowserAtlas / iAtlas`
Current baseline: `v1.0.0 stable`

## Purpose

This document defines what AibrowserAtlas should build next, in what order, and what should stay out of scope.

The goal is not feature breadth.

The goal is:

- a smaller set of globally understandable, high-value capabilities
- real artifact output instead of prompt theater
- strong reuse of the current architecture
- fast product compounding without a runaway engineering burden

## Current Product Truth

`AibrowserAtlas v1` already has a real foundation:

- chat-first workspace
- session memory and archive
- file and folder knowledge import
- real exportable artifacts for:
  - `PPTX`
  - `DOCX`
  - `Website ZIP`
  - `Story Kit`
  - `Spreadsheet Kit`
  - `Contract Review Kit`
  - `Research Kit`
  - `Playbook Kit`
  - `Design Kit`
  - `Scheduled Task Kit`
  - `Visualization Kit`
- public download center
- desktop and Android test packages
- iOS and Harmony project-source bundles

This means the product is no longer at the "can chat" stage.
It is now at the "which few capabilities deserve to become the product core" stage.

## External Market Signals

Recent public signals point in one clear direction:

- users want AI to complete work, not just answer questions
- users value artifact output more than chat verbosity
- organizations are increasingly comfortable with AI for research, drafting, data analysis, and process support
- trust, provenance, and output verification matter more as the task gets higher-stakes

Relevant references:

- OpenAI, "Introducing deep research":
  - https://openai.com/index/introducing-deep-research/
- Anthropic, "Artifacts are now generally available":
  - https://www.anthropic.com/news/artifacts
- Microsoft Work Trend Index 2025:
  - https://www.microsoft.com/en-us/worklab/work-trend-index/2025-the-year-the-frontier-firm-is-born
- Thomson Reuters, 2025 Generative AI in Professional Services:
  - https://www.thomsonreuters.com/en/reports/2025-generative-ai-in-professional-services-report
- CFA Institute, AI in Asset Management:
  - https://www.cfainstitute.org/about/press-room/2025/ai-in-asset-management-report-2025

## Product Principles

### 1. Every visible capability must produce a real deliverable

If a mode cannot emit a durable artifact, it should not be presented as a first-class capability.

Allowed examples:

- `DOCX`
- `PPTX`
- `XLSX`
- multi-file `ZIP`
- dashboard bundle
- review bundle

Not allowed:

- prompt starters presented as product capabilities
- "software mode" without a real code/package output path
- "video mode" or "audio mode" without a real bundle and export chain

### 2. High-frequency work beats flashy demos

The product should prioritize workflows that users repeat every week:

- drafting
- research
- data analysis
- reporting
- planning
- review
- recurring operational output

### 3. Reuse the current stack before adding new subsystems

The current platform already supports:

- session context
- uploaded knowledge
- exportable artifacts
- spreadsheet output
- visualization output
- schedule output

The next product layers should be built by combining these primitives, not by inventing new architecture too early.

### 4. Trust increases with evidence, not with bigger claims

For high-stakes domains such as finance, contract review, and decision support:

- show source boundaries
- timestamp the analysis
- preserve assumptions
- clearly separate analysis from regulated advice

### 5. Fewer modes, stronger modes

The product should not grow into a mode cemetery.

Preferred pattern:

- one mode covers a family of related jobs if the output type is the same
- one mode splits only when user outcome and artifact shape are meaningfully different

## Global User Needs Ranked From High To Low

This ranking uses four filters:

- frequency of need
- willingness to pay
- global portability across markets
- engineering leverage from the current product base

### Tier 1: Universal, highest value

#### 1. Research -> analyze -> deliver

What users want:

- understand a topic fast
- compare options
- produce a decision-ready summary

Why it matters:

- global
- cross-industry
- already partly supported by `Research`, `Spreadsheet`, and `Visualization`

Best artifact shapes:

- research ZIP
- comparison table
- dashboard
- recommendation memo

#### 2. Draft -> revise -> export

What users want:

- write documents
- write slides
- write web content
- iterate without losing context

Why it matters:

- very high frequency
- broad user base
- already live and strong

Best artifact shapes:

- `DOCX`
- `PPTX`
- website bundle

#### 3. File-grounded chat and memory continuity

What users want:

- continue previous work
- re-use files and decisions
- avoid restating context

Why it matters:

- foundational retention driver
- core reason to keep using one account over time

Best artifact shapes:

- session export
- compression asset
- imported continuation bundle

### Tier 2: Broad and valuable, with controlled scope

#### 4. Structured operational output

What users want:

- SOPs
- checklists
- recurring workflows
- scheduled updates

Why it matters:

- clear business value
- strong repeat use
- low marginal complexity from existing playbook/schedule primitives

Best artifact shapes:

- playbook ZIP
- automation manifest
- scheduled brief

#### 5. Data work for non-analysts

What users want:

- tables
- trackers
- dashboards
- decision visuals

Why it matters:

- global demand
- strong upgrade path from chat to real work product

Best artifact shapes:

- `XLSX`
- visualization bundle
- comparison pack

### Tier 3: High willingness to pay, narrower audience

#### 6. Finance and stock analysis

What users want:

- stock analysis
- ETF/fund comparison
- company/product investment brief
- valuation support
- catalyst/risk tracking

Why it matters:

- high perceived value
- global user interest
- compatible with current `research + spreadsheet + visualization` architecture

Why it should be prioritized:

- it produces clear, inspectable artifacts
- users understand the benefit immediately
- it does not require a brand new interaction model

#### 7. Contract and commercial review

What users want:

- risk review
- clause comparison
- negotiation preparation

Why it matters:

- valuable but narrower than general research/drafting
- already partially shipped

### Tier 4: Attractive but not core right now

#### 8. Story and creator workflows

Valuable, but not as universal as research, docs, spreadsheets, and finance.

#### 9. Full software/app generation

High interest, but dangerous to oversell.

Without a reliable code/package/deploy chain, this becomes fake capability quickly.

#### 10. Video and audio generation

Useful, but currently too likely to expand scope faster than value.

## What The Product Should Not Build Next

These items should stay out of near-term scope:

- social feed features
- community marketplace
- generic "agent store" before the core product is tighter
- too many persona modes
- fully autonomous browser swarms as a consumer-facing promise
- video/audio as top-level modes before artifact quality is real
- "software mode" as a first-class promise until it produces real deployable bundles

## Missing Product Pieces Today

### 1. Product surface still over-explains some capability paths

Problem:

- some visible entry points still behave more like intent starters than true artifact launchers

Required fix:

- the UI should distinguish:
  - real output capabilities
  - conversational assistance

### 2. Revision loop after artifact generation is still too light

Problem:

- users can generate assets, but the product still needs a tighter "review -> adjust -> regenerate" loop

Required fix:

- stronger latest-artifact controls
- clearer regenerate flow by output type
- side-by-side summary of what changed

### 3. Finance vertical is not productized yet

Problem:

- the current platform has the primitives for finance analysis, but not a focused finance package

Required fix:

- ship one finance capability family with strong boundaries and obvious value

### 4. Website and app need stricter product honesty

Problem:

- website is real
- app/software is not yet equally real

Required fix:

- keep `website` as a live capability
- keep `app/software` off the same product tier until it can emit a real code/project bundle with docs

### 5. Mobile still needs output-first polish

Problem:

- mobile chat is much better than before, but long-session output workflows should be even simpler

Required fix:

- fewer visible controls
- stronger latest-output access
- easier handoff from chat to artifact download

## Recommended Product Roadmap

## Phase P0: Surface Integrity

Target:

- make the visible product surface match the true backend capability surface

Build:

- remove prompt-starter positioning from primary capability entry points
- present only real shipped capabilities as first-class modes
- promote direct artifact actions for:
  - `PPTX`
  - `DOCX`
  - `Website`
  - `Story`
  - `Spreadsheet`
  - `Contract Review`
  - `Research`
  - `Playbook`
  - `Design`
  - `Scheduled Tasks`
  - `Visualization`

Exit criteria:

- no top-level user flow implies a capability that is not real

## Phase P1: Artifact Revision Loop

Target:

- make outputs feel editable and reusable, not one-shot

Build:

- regenerate current artifact from updated session context
- show latest artifact summary more clearly
- improve export/share/re-send flow
- keep download metadata visible and trustworthy

Exit criteria:

- users can iterate on artifacts without starting over

## Phase P2: Finance Analysis Family

Target:

- add one high-value vertical with strong global demand and moderate build cost

Recommended finance capability family:

### Finance Capability 1: `Market Brief`

Use cases:

- stock snapshot
- company update
- earnings/event reaction brief
- thematic sector brief

Outputs:

- decision memo
- catalyst and risk table
- source log
- summary dashboard

### Finance Capability 2: `Equity Research Kit`

Use cases:

- single-stock thesis
- bull/base/bear framing
- KPI watchlist
- management/product/competitive review

Outputs:

- thesis memo
- risk and catalyst matrix
- assumptions table
- valuation worksheet
- chart package

### Finance Capability 3: `Fund / ETF Comparison`

Use cases:

- compare ETFs
- compare funds
- compare multiple securities on strategy, risk, fee, and exposure

Outputs:

- comparison workbook
- scoring table
- recommendation summary

Why this is the right next vertical:

- high user value
- global relevance
- strong willingness to pay
- reuses the current `research + spreadsheet + visualization + doc export` stack

Important boundaries:

- not personal investment advice
- not portfolio execution
- not broker integration
- all analysis should show timestamp, assumptions, and sources

## Phase P3: Repeatable Intelligence

Target:

- make good analysis recur automatically

Build:

- scheduled market brief
- repeated watchlist update
- recurring company update package
- email delivery of generated finance outputs

Exit criteria:

- a user can keep one finance workspace alive over time instead of rerunning everything manually

## Recommended User Segments

Prioritize these segments in order:

### 1. Founders, operators, and independent professionals

Why:

- broadest global fit
- immediate need for docs, research, spreadsheets, and planning

### 2. Consultants, analysts, and strategy roles

Why:

- heavy artifact output
- strong appreciation for research + deck + memo workflows

### 3. Finance-interested power users and semi-professional investors

Why:

- high perceived value
- excellent fit for research, spreadsheet, and visualization outputs

### 4. Professional finance users

Why:

- high willingness to pay
- but requires stricter trust, source, and compliance boundaries

### 5. Creative writers

Why:

- useful secondary segment
- not the primary global monetization anchor

## Delivery Shapes To Standardize

The product should standardize around a small set of durable output shapes:

- `DOCX`
- `PPTX`
- `XLSX`
- multi-file `ZIP`
- dashboard bundle
- machine-readable manifest JSON

This is enough to cover most high-value work without exploding the engineering surface.

## Product Scorecard For Any New Capability

Before shipping a new capability, score it on:

### A. Demand

- Is this a common weekly need?

### B. Artifact clarity

- Can it produce a real durable output?

### C. Reuse of existing primitives

- Can it be built using current session, research, spreadsheet, and visualization systems?

### D. Trust burden

- Does it require regulated claims, strong compliance review, or risky integrations?

### E. Mobile viability

- Can the user still understand and control it on a phone?

If a capability fails `B`, it should not ship.

## Recommended Immediate Next Build Order

1. Fix product surface integrity so visible capabilities always map to real artifact actions.
2. Strengthen artifact revision loops.
3. Productize one finance capability family:
   - `Market Brief`
   - `Equity Research Kit`
   - `Fund / ETF Comparison`
4. Add recurring finance/report scheduling on top of the existing schedule system.
5. Only then reconsider broader "software/app generation" as a real output family.

## Final Decision

The next version of AibrowserAtlas should not try to be everything.

It should become:

- the best chat-first workspace for
- research,
- drafting,
- spreadsheet/data work,
- visualization,
- operational packaging,
- and finance analysis

with real outputs, strong memory, and portable artifacts.

That is globally valuable, technically realistic, and much easier to defend than a broad catalog of half-real modes.
