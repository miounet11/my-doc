# Mydoc Sync Publish Guardrail

Status: active guardrail
Date: 2026-03-30

## Problem
A workspace document can exist locally while the mydoc mirror and remote site still do not contain it. Old `.last-workspace-sync.json` and `.last-workspace-deploy.json` files can create a false sense of freshness if their timestamps are not checked.

## Rule
Do not present a mydoc URL as delivered unless all of the following are true for the current artifact:
1. source file exists in workspace
2. mirrored file exists under `my-doc-site/content/...`
3. `.last-workspace-sync.json` is fresh for the current action and includes evidence of a recent sync
4. if remote publish is claimed, `.last-workspace-deploy.json` is fresh for the current action
5. if remote URL is claimed, URL verification for that publish actually succeeded

## Minimum Honest Labels
- source only: `local-only`
- source + mirror only: `mirrored-local`
- source + mirror + verified remote deploy: `published-verified`
- source + mirror + git pushed, but live site not verified: `git-pushed-awaiting-live`
- any missing freshness/evidence: `unverified-publish`

## Operator Checklist
Before giving a mydoc link:
- check source path
- check mirror path
- check sync timestamp freshness
- check deploy timestamp freshness
- avoid reusing stale successful deploy state from a prior day as proof for today's artifact
- treat Git sync evidence as coordination evidence, not live publish evidence
