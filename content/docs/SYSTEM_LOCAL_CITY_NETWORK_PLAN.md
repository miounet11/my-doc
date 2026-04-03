# Nationwide Local Lifestyle City-Site Network Plan

## Goal

Build a powerful nationwide local lifestyle network similar in spirit to `bendibao.com`, covering cities across China. Each city gets its own subdomain and an effectively independent site experience, while sharing a unified platform, content system, operational control plane, and SEO/GEO strategy.

Primary objective:

- cover all major Chinese cities first, then expand to broader prefecture-level coverage
- each city lives at its own subdomain
- each city site has complete local landing pages, content hubs, taxonomy pages, and operational independence at the content layer
- architecture must support SEO, GEO, scale, automation, templated replication, and Codex-driven implementation

This document is written as an execution handoff for Codex.

---

## 1. Product Definition

This is not a single website. It is a **multi-city local lifestyle publishing platform**.

Think of it as:

- one platform
- many city sites
- shared infra
- localized content, navigation, taxonomy, and SEO surfaces

The system should behave like a network of city portals, not just one site with a city filter.

### Core user value

For each city, users should quickly find:

- local guides
- events and exhibitions
- travel and city services
- transportation and metro updates
- policy and public service explainers
- schools / enrollment / permits / social services
- leisure, shopping, activities, and practical life information
- evergreen local guides
- time-sensitive local updates

### Business value

This architecture supports:

- organic search traffic by city + topic intent
- scalable content expansion
- city-by-city monetization later
- ad, lead-gen, affiliate, local service, or merchant expansion later
- centralized platform operations with distributed local surface area

---

## 2. Strategic Positioning

### What we are building

A **China-wide city-site matrix** where every city is represented as a dedicated subdomain and local destination.

Examples:

- `beijing.example.com`
- `shanghai.example.com`
- `guangzhou.example.com`
- `shenzhen.example.com`
- `chengdu.example.com`
- `wuhan.example.com`

Potential later expansion:

- district-level or topic-specialized sub-sites
- e.g. `haidian.beijing.example.com` is usually too complex initially; instead keep district pages inside city sites

### What we are not building first

Do not start with:

- full UGC community product
- marketplace transactions
- merchant CRM
- social graph
- super app behavior

The first version should be a **search-first local content platform** with strong structured publishing and local SEO.

---

## 3. Recommended Domain Strategy

### Primary structure

Use one apex brand domain and city subdomains:

- `example.com` = network / national gateway / city selector / brand home
- `<city>.example.com` = dedicated city site

Recommended:

- apex domain: national entry and network hub
- each city subdomain: independent city portal

### Why subdomains

Subdomains fit the product model because:

- each city can be treated as a separately optimized site surface
- easier geographic segmentation
- easier ops isolation by city configuration
- easier per-city sitemap partitioning
- supports future differential monetization and ownership

### Important caution

Subdomains create more SEO and ops complexity than subdirectories. Use them only because the product explicitly wants city-level independence.

This means the platform must compensate with:

- excellent internal linking
n- consistent schema
- strong city hubs
- network sitemap strategy
- canonical discipline
- reusable templates

---

## 4. Platform Architecture Overview

Build one shared codebase that renders many city sites.

### High-level architecture

1. **Platform core**
   - shared app/runtime
   - shared design system
   - shared publishing engine
   - shared templates
   - shared taxonomy and data models

2. **City configuration layer**
   - city metadata
   - city-specific nav
   - local categories enabled
   - local SEO copy
   - local content inventory
   - local modules and page priorities

3. **Content layer**
   - evergreen pages
   - local service pages
   - time-sensitive articles
   - city topic hubs
   - event lists
   - FAQ / guide pages

4. **SEO layer**
   - city-specific title/meta templates
   - article schema, breadcrumb schema, FAQ schema
   - city-level sitemaps
   - network-level sitemap index
   - geo-aware internal linking

5. **Automation layer**
   - city rollout scripts
   - content planning
   - content generation and review pipeline
   - freshness jobs
   - expired content cleanup / archival

6. **Deployment layer**
   - global frontend/CDN
   - content storage
   - regional backend if needed
   - caching
   - monitoring

---

## 5. Recommended Technical Direction

### Best-fit stack

Use a modern SSR/SSG-capable web stack with strong routing, metadata, and templating support.

Recommended first choice:

- **Next.js** with App Router
- TypeScript
- shared content/data layer
- static generation where possible
- ISR / partial regeneration or runtime external content loading where necessary

Why:

- flexible dynamic routing
- mature metadata support
- good SEO support
- easy city-subdomain host-based rendering
- easy combination of static and dynamic content
- compatible with large publishing surfaces

### Alternative

If content generation and static-first behavior dominate, a Python or static-site pipeline can work, but for this scale and multi-city routing, Next.js is the more practical default.

---

## 6. Multi-City Routing Model

### Required behavior

The platform must resolve content by subdomain.

Examples:

- `beijing.example.com/` → Beijing homepage
- `beijing.example.com/metro/` → Beijing metro hub
- `beijing.example.com/events/` → Beijing events hub
- `beijing.example.com/permits/residence/` → Beijing residence permit guide
- `shanghai.example.com/` → Shanghai homepage

### Routing rules

1. Hostname determines active city
2. Path determines content type and taxonomy
3. Shared route definitions, city-specific data
4. If a page is not available for a city, either:
   - return 404
   - or route to closest valid city taxonomy page if explicitly intended

### Key principle

Do not create separate repos per city.

Use:
- one app
- one route system
- one platform data model
- city-specific content/config

This gives independence at the site layer without exploding engineering complexity.

---

## 7. City Rollout Model

### Recommended phases

#### Phase 1: National core cities

Launch first batch:

- Beijing
- Shanghai
- Guangzhou
- Shenzhen
- Chengdu
- Hangzhou
- Wuhan
- Nanjing
- Suzhou
- Chongqing
- Xi’an
- Tianjin
- Zhengzhou
- Changsha
- Qingdao
- Ningbo
- Xiamen
- Fuzhou
- Hefei
- Jinan

#### Phase 2: Expanded provincial and strong prefecture cities

Add 50–100 more cities.

#### Phase 3: Full prefecture-level coverage

Target broad nationwide coverage.

### Why phased rollout matters

Because:

- taxonomy must stabilize first
- templates must mature first
- local content generation quality must be proven first
- internal linking and freshness systems must be tested at medium scale before full national rollout

---

## 8. Site Structure Per City

Every city site should feel complete, not hollow.

### Minimum required pages per city

1. **Homepage**
   - city positioning
   - key topic blocks
   - latest useful updates
   - evergreen local guides
   - popular searches / shortcuts

2. **Topic hubs**
   Recommended hubs:
   - `/events/`
   - `/metro/`
   - `/transport/`
   - `/travel/`
   - `/life-services/`
   - `/education/`
   - `/housing/`
   - `/social-security/`
   - `/permits/`
   - `/shopping/`
   - `/weekend/`
   - `/food/`
   - `/family/`
   - `/health-services/` (careful, informational only)

3. **Evergreen guides**
   Examples:
   - city introduction pages
   - airport guide
   - railway station guide
   - residence permit guide
   - school enrollment guide
   - housing fund guide
   - weekend destination guide

4. **Time-sensitive content pages**
   Examples:
   - holiday arrangements
   - exhibition schedules
   - local event calendars
   - transport changes
   - public policy notices

5. **Utility/index pages**
   - category indexes
   - tag indexes
   - date/event archives
   - update pages

### Important principle

A city site should not be just a homepage plus 3 thin articles. It needs meaningful hub depth to satisfy SEO and user trust.

---

## 9. Content Model

Split content into clear classes.

### A. Evergreen content
Long-lived, high-value, frequently searched.

Examples:
- “Beijing residence permit guide”
- “Shanghai metro card guide”
- “Shenzhen weekend family activities guide”

### B. Freshness-sensitive utility content
Needs regular updates.

Examples:
- event schedules
- holiday notices
- temporary route changes
- ticketing updates

### C. Seasonal content
Examples:
- Spring Festival transport guide
- summer destinations
- university enrollment season pages

### D. City hub pages
Examples:
- “Beijing local services”
- “Shanghai events this month”
- “Chengdu travel guide”

### E. Network/national pages
Use apex domain for:
- city directory
- top city comparisons
- nationwide topic pages linking into cities
- brand/about/docs/advertise/contact

---

## 10. GEO + SEO Strategy

This project depends on SEO and geographic intent alignment.

### Search intent model
The dominant pattern is:

- city + topic
- city + service + guide
- city + event + time
- city + permit + process
- city + metro + line / station / card
- city + school + enrollment
- city + weekend + destination

### Every city page should satisfy:

1. local keyword relevance
2. clear city entity signal
3. practical utility
4. freshness where required
5. strong internal linking
6. structured data where appropriate

### Required SEO surfaces

#### Site-level
- robots.txt
- sitemap index at apex
- subdomain-specific sitemaps
- canonical tags
- hreflang if multilingual later

#### Page-level
- city-aware title templates
- city-aware meta descriptions
- breadcrumbs
- Article schema for editorial pages
- FAQ schema for guide pages
- ItemList schema for hub pages when appropriate
- organization/site schema on homepages

### GEO considerations

Because each city is on its own subdomain, the city identity must be reinforced through:

- hostname
- city-specific title/meta
- city name in nav and footer
- city-specific local hubs
- internal links among related local pages
- city-specific business/about/contact surface where appropriate

---

## 11. Internal Linking Strategy

Internal linking is critical because subdomains fragment authority.

### Required linking layers

1. **Within city site**
   - homepage → all core hubs
   - hub → article / guide pages
   - article → related local hub and related guides
   - utility pages → parent hub and adjacent local topics

2. **Across network**
   - apex city directory links to each city site
   - topic-based national pages can link to top city versions
   - related-city comparisons can cross-link carefully

3. **Freshness modules**
   - homepage latest local updates
   - hub latest relevant updates
   - evergreen pages link to fresh updates when relevant

### Warning

Do not overdo cross-city duplicate pages or sitewide duplicate blocks. They can look templated and thin if not handled carefully.

---

## 12. Content Quality Requirements

The platform must not become a thin-content city farm.

### Hard requirements

- no fake local presence claims
- no fabricated statistics
- no fake events or fabricated public notices
- no scraped duplicate pages with city-name swaps only
- no medical/legal/financial advice beyond informational summaries
- no false urgency or clickbait spam
- no empty city sites

### Page quality doctrine

Every page must have at least one of:

- concrete local utility
- clear local structure
- useful steps / addresses / process explanation
- curated and validated event/service information
- durable city-specific insight

### Anti-pattern to avoid

“Replace city name in the same template 300 times” is not acceptable. Codex and the content pipeline must build genuine city-adapted structures, not city-token spam.

---

## 13. Data and Taxonomy Model

Create a strong shared taxonomy.

### Core entities

- city
- district
- venue
- station
- event
- service
- policy
- guide
- category
- tag
- seasonal topic

### City model should include

- slug
- pinyin slug / subdomain name
- Chinese display name
- province
- tier / importance
- latitude / longitude (optional)
- districts
- enabled categories
- seo defaults
- launch status
- editorial priority

### Page model should include

- city
- content type
- topic family
- slug
- title
- summary
- publish date
- update date
- freshness class
- canonical url
- related entities
- schema type

---

## 14. Content Generation and Editorial Workflow

Because this is huge scale, content must be partially automated.

### Recommended workflow

1. **Platform defines page templates and taxonomy**
2. **Codex builds the site platform and content generators**
3. **Topic planning layer generates city-topic inventory**
4. **LLM-assisted drafting fills structured content**
5. **Validation and review gates filter low-quality output**
6. **Publish into city site content stores**
7. **Freshness jobs update or archive time-sensitive pages**

### Recommended content generation levels

#### Level 1
Direct generation for small snippets:
- summaries
- FAQ answers
- intro blurbs

#### Level 2
Frame + draft for normal city guides.

#### Level 3
Frame + outline + draft + review for:
- cornerstone city hubs
- high-value evergreen pages
- important local policy/service guides

### Critical note

Do not fully trust one-shot generation for public pages. A review gate is mandatory.

---

## 15. Codex-Driven Development Strategy

This project is ideal for Codex-led implementation.

The development should be split into bounded work packages.

### Recommended Codex workstreams

1. **Platform architecture Codex**
   - overall app scaffold
   - host-based city routing
   - shared config/data model

2. **SEO and metadata Codex**
   - metadata system
   - sitemaps
   - schemas
   - canonical handling

3. **City config and taxonomy Codex**
   - city registry
   - district taxonomy
   - topic model

4. **Editorial CMS/content pipeline Codex**
   - content schema
   - ingestion format
   - content build pipeline

5. **Automation Codex**
   - topic planning
   - freshness jobs
   - generation/review orchestration

6. **Frontend UX Codex**
   - city homepage
   - hub layouts
   - article templates
   - search / filter / nav

7. **Deployment Codex**
   - domain routing
   - wildcard subdomain config
   - CDN / edge / nginx
   - observability

8. **QA / integration Codex**
   - route checks
   - sitemap checks
   - metadata checks
   - city coverage checks

---

## 16. Recommended Product Modules

### Module A: National gateway
At apex domain:

- city selector
- search entry
- popular cities
- national categories
- comparison and discovery pages

### Module B: City site shell
Per city:

- city header/nav/footer
- city homepage
- city local service blocks
- city trending content

### Module C: Topic hubs
Per city and topic family.

### Module D: Guide/article templates
For evergreen and fresh utility content.

### Module E: Content ops console
Internal tooling to:
- enable cities
- assign topics
- monitor freshness
- review generated drafts
- rebuild sitemap partitions

### Module F: Search and recommendation
Can start simple, then grow.

---

## 17. Deployment and Infrastructure Plan

### DNS strategy

- apex domain for national site
- wildcard subdomain support: `*.example.com`
- city subdomains resolve through wildcard DNS or generated records

### Hosting model

Recommended:

- frontend on edge/CDN-capable platform if possible
- app supports host-based city resolution
- content stored in external structured store or content directory
- cache heavily at page and hub layer

### If using Next.js
Possible deployment models:

#### Option A: Vercel / edge-friendly deployment
Good for speed of launch, but review subdomain and China access constraints carefully.

#### Option B: Self-hosted Next.js + CDN + nginx wildcard
More control, likely better for this project.

Recommended first serious production route:
- self-hosted app cluster or standalone app
- nginx wildcard host routing
- CDN in front
- object storage / content store for generated content

### Wildcard SSL
Need wildcard certificate for city subdomains.

### Caching
- homepage and hub pages cached
- article pages cached strongly but revalidated on update
- sitemap generation cached carefully

---

## 18. Operational Scale Considerations

At national scale, expect:

- hundreds of subdomains
- thousands of hub pages
- tens of thousands of guides and articles
- freshness and expiration pressure
- category drift and taxonomy drift

### Therefore the system must support

- city enable/disable flags
- content status flags
- stale-content detection
- broken-link checks
- duplicate-content checks
- city coverage dashboards
- sitemap partitioning
- indexability monitoring

---

## 19. SEO Rollout Doctrine

Do not launch 300 empty or thin city subdomains at once.

### Correct rollout

1. launch national domain + 10–20 strong city sites
2. ensure each city has:
   - homepage
   - 5–10 real hubs
   - 20–50 meaningful pages
3. verify indexing and traffic signals
4. expand to more cities in waves

### Why

Because a thin subdomain farm can hurt trust, crawl efficiency, and long-term rankings.

---

## 20. Phase-by-Phase Delivery Plan

### Phase 1: Foundation MVP

Deliver:
- national gateway
- city routing
- first 10–20 cities
- city homepage template
- 5–8 topic hubs per city
- article/guide template
- metadata and sitemap system

### Phase 2: Content Scale System

Deliver:
- city registry expansion
- structured content model
- generation/review pipeline
- freshness jobs
- ops console basics

### Phase 3: National Expansion

Deliver:
- 100+ cities
- broader taxonomy
- stronger internal linking
- city coverage dashboards
- duplicate/thin page detection

### Phase 4: Monetization / advanced ops

Possible future:
- advertising system
- lead forms
- merchant pages
- local service partnerships
- newsletter by city
- app or mini-program integration

---

## 21. What Codex Should Build First

Priority order for implementation:

1. repository scaffold and architecture docs
2. city host routing and city registry
3. shared page templates and metadata system
4. first 10 city sites with real config
5. content model and seeded page generation
6. sitemap and schema system
7. ops/admin tooling for city rollout
8. automation pipeline for scaling content

---

## 22. Required Deliverables From Codex

Codex should produce:

1. `SYSTEM_LOCAL_CITY_NETWORK_PLAN.md`
2. repository scaffold
3. city registry and taxonomy model
4. host-based routing implementation
5. first set of city templates and sample content
6. SEO/schema/sitemap implementation
7. deployment docs for wildcard subdomains
8. content operations plan
9. rollout checklist
10. QA checklist for city launches

---

## 23. Key Non-Negotiables

- one shared platform, not one repo per city
- city subdomains must feel like complete local sites
- no thin city-name-swap spam
- city SEO must be explicit and structured
- rollout must be phased, not all-at-once
- automation must include quality gates
- content freshness must be managed as a system
- Codex should do the majority of implementation work

---

## 24. Final Recommendation

The best way to build this is:

- one shared codebase
- host-based city subdomains
- strong city registry + taxonomy system
- phased rollout from top cities to nationwide coverage
- SEO-first local content architecture
- Codex-led implementation broken into bounded modules

Do not try to brute-force 300 city sites manually.

Build the platform once, then scale city surfaces systematically.
