# Intel Brief — 2026-03-19

## Purpose
Track new external signals that should influence OpenClaw design, operations, or evaluation.

## Current signal plan
Because direct X ingestion is not yet automated on the VPS, the immediate operating model is:
- gather official and public web signals first
- treat social/X items as directional signals, not proof
- dedupe by URL + core claim
- only promote items that imply product, architecture, or tooling changes

## Seed topics
- LLM agents
- ACP / agent protocol tooling
- browser automation and browser-native agents
- long-running memory systems
- orchestration / evaluation / recovery loops
- frontier model releases and API changes

## Initial interpretation
OpenClaw should optimize around three realities:
1. raw model strength matters, but **control-plane honesty** matters more
2. persistent memory only helps if retrieval and promotion are disciplined
3. browser / agent / CLI ecosystems are fragmenting, so adapter layers and evidence-first evaluation are strategic advantages

## Next step
Install a VPS-side collection loop that stores new items into:
- `archive/review/<date>/intel-brief.md`
- `archive/review/<date>/evidence.json`
- `archive/review/state/seen.json`
