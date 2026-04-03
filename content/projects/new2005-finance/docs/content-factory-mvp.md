# Structured Content Factory MVP

## Goal

Build a content graph that can produce real finance pages from reusable entities instead of ad-hoc prose. The MVP seeds six object families:

- `market`
- `exchange`
- `index`
- `company`
- `sector`
- `term`

The immediate outcome is a typed, validated dataset that can feed:

- SEO landing pages
- API responses
- internal authoring tools
- future AI-assisted page generation

## Directory Layout

- `data/content-factory/*.json` — human-editable source records
- `data/content-factory/compiled/catalog.json` — exported site-consumable artifact
- `src/lib/content-factory.ts` — schema types, validation, enrichment, catalog access
- `scripts/build-content-catalog.mjs` — validation + export script
- `src/app/api/content/catalog/route.ts` — minimal API surface
- `src/app/[locale]/content-factory/page.tsx` — visual inspection page and launchpad into live hubs
- `src/app/[locale]/{markets,indices,companies,sectors,terms}` — browseable hub pages
- `src/app/[locale]/{markets,indices,companies,sectors,terms}/[slug]` — first wave of structured detail pages

## Current live scale

As of this iteration the seed graph contains:

- `7` markets
- `9` exchanges
- `10` indices
- `25` companies
- `8` sectors
- `10` terms

That is `69` validated records in the compiled catalog.

## Schema Design

### 1. `market`
Represents a macro equity universe.

Core fields:

- `id`
- `slug`
- `name`
- `region`
- `primaryCountries`
- `primaryCurrencies`
- `timezoneAnchors`
- `description`
- `exchangeIds`
- `indexIds`

### 2. `exchange`
Represents a listing and trading venue.

Core fields:

- `id`
- `slug`
- `name`
- `mic`
- `marketId`
- `countryCode`
- `city`
- `timezone`
- `localTradingHours`
- `primaryCurrency`
- `website`
- `description`
- `indexIds`

### 3. `index`
Represents a benchmark that can anchor hub pages, constituent pages, and explainers.

Core fields:

- `id`
- `slug`
- `symbol`
- `name`
- `marketId`
- `homeExchangeId`
- `provider`
- `baseCurrency`
- `launchYear`
- `methodology`
- `description`
- `representativeSectorIds`
- `representativeCompanyIds`

### 4. `company`
Represents an issuer page target.

Core fields:

- `id`
- `slug`
- `ticker`
- `name`
- `exchangeId`
- `marketId`
- `sectorId`
- `indexIds`
- `countryCode`
- `headquarters`
- `foundedYear`
- `isin`
- `website`
- `investorRelationsUrl`
- `description`
- `primaryTermIds`

### 5. `sector`
Represents an industry grouping that can power rankings, leaders, and glossary cross-links.

Core fields:

- `id`
- `slug`
- `name`
- `classificationSystem`
- `description`
- `typicalMetrics`
- `marketIds`
- `representativeCompanyIds`

### 6. `term`
Represents glossary and education inventory that can be reused across pages.

Core fields:

- `id`
- `slug`
- `name`
- `category`
- `plainEnglishDefinition`
- `whyItMatters`
- `formula`
- `appliesToTypes`
- `relatedSectorIds`

## Object Relationships

The content graph is intentionally simple:

- one `market` → many `exchange`
- one `market` → many `index`
- one `exchange` → many `company`
- one `sector` → many `company`
- one `company` → many `index`
- one `company` → many `term`
- one `sector` → many `term` through relevance

This is enough to generate cross-linked pages such as:

- market overview → linked exchanges and indices
- exchange overview → trading hours, venue details, representative companies
- index overview → methodology, linked sectors, linked companies
- company page → exchange, sector, benchmark, glossary links
- sector hub → representative companies, relevant terms
- glossary term → linked sectors and company examples

The current app now implements real page families for:

- market detail pages
- index detail pages
- company detail pages
- sector detail pages
- glossary term detail pages

These pages are not placeholder shells: each one includes structured fact blocks plus links into related objects from the graph.

## URL Structure

Canonical non-localized patterns in the catalog:

- `/markets/[slug]`
- `/exchanges/[slug]`
- `/indices/[slug]`
- `/companies/[slug]`
- `/sectors/[slug]`
- `/terms/[slug]`

Localized site pages can prepend `/{locale}`:

- `/en/markets/us-equities`
- `/en/exchanges/nasdaq`
- `/en/indices/sp-500`
- `/en/companies/apple`
- `/en/sectors/technology`
- `/en/terms/free-cash-flow`

Recommended hub pages:

- `/[locale]/markets`
- `/[locale]/exchanges`
- `/[locale]/indices`
- `/[locale]/companies`
- `/[locale]/sectors`
- `/[locale]/terms`

Implemented in this milestone:

- `/[locale]/markets`
- `/[locale]/indices`
- `/[locale]/companies`
- `/[locale]/sectors`
- `/[locale]/terms`

## Export Flow

Run:

```bash
npm run build:content
npm run lint
npm run build
```

What it does:

1. loads the six JSON seed files
2. validates IDs, slugs, and cross-object references
3. adds canonical paths
4. emits `data/content-factory/compiled/catalog.json`

The compiled JSON is the handoff format for:

- static page generation
- external CMS sync
- embeddings or retrieval indexing
- API caching/CDN layers

## Path to 1000+ Pages

This MVP is small, but the graph scales cleanly.

### Layer 1: Expand entity inventory

Grow to:

- 30+ markets and exchanges
- 200+ indices
- 500+ companies
- 50+ sectors/subsectors
- 300+ terms

### Layer 2: Multiply page families per entity

Each object can support multiple page templates:

- overview
- FAQ
- compare
- calendar/events
- methodology
- glossary explainer
- top peers / leaders / laggards

Example: 200 companies × 3 templates already produces 600 pages.

### Layer 3: Add derived pages

Use relationships to generate:

- `/companies/[slug]/vs/[slug]`
- `/indices/[slug]/constituents`
- `/sectors/[slug]/leaders`
- `/markets/[slug]/trading-hours`
- `/terms/[slug]/examples`

### Layer 4: Add locale multiplication

The current app already has locale-aware routing. Once translations or locale-specific summaries exist, the same graph can fan out by language without changing object identity.

### Layer 5: Add freshness and evidence

Later iterations can attach:

- price snapshots
- earnings dates
- economic calendar data
- news evidence
- AI-generated summaries grounded by the structured graph

## Practical next expansions

The current route system is now ready for the next multiplier steps:

1. add exchange detail pages to complete the venue layer already present in the catalog
2. add derived list pages like `/indices/[slug]/constituents` and `/sectors/[slug]/leaders`
3. attach page-specific metadata generation and breadcrumbs from the same graph helpers
4. add locale-specific copy generation while keeping object identity and relationships stable

## Why This MVP Matters

This is not placeholder documentation. The repo now has:

- a concrete schema
- real seed entities
- cross-reference validation
- a compiled export format
- a live API route
- a live inspection page inside the existing Next.js app

That is enough to start shipping structured SEO inventory without breaking the current site.
