# Store Metadata

Canonical store metadata now lives in [store-listing.json](/Users/lu/.openclaw/workspace/projects/chat-mirror/apps/aibrowseratlas-shell/metadata/store-listing.json).

Use it as the source of truth for:
- app name and tagline
- short descriptions
- full descriptions
- keyword sets
- release notes
- bundle identifiers

## Brand Assets

Brand source files:
- [icon.svg](/Users/lu/.openclaw/workspace/projects/chat-mirror/apps/aibrowseratlas-shell/brand/icon.svg)
- [foreground.svg](/Users/lu/.openclaw/workspace/projects/chat-mirror/apps/aibrowseratlas-shell/brand/foreground.svg)
- [splash-square.svg](/Users/lu/.openclaw/workspace/projects/chat-mirror/apps/aibrowseratlas-shell/brand/splash-square.svg)
- [splash-portrait.svg](/Users/lu/.openclaw/workspace/projects/chat-mirror/apps/aibrowseratlas-shell/brand/splash-portrait.svg)
- [splash-landscape.svg](/Users/lu/.openclaw/workspace/projects/chat-mirror/apps/aibrowseratlas-shell/brand/splash-landscape.svg)

Generated outputs:
- [icon.icns](/Users/lu/.openclaw/workspace/projects/chat-mirror/apps/aibrowseratlas-shell/build-resources/icon.icns)
- [icon.ico](/Users/lu/.openclaw/workspace/projects/chat-mirror/apps/aibrowseratlas-shell/build-resources/icon.ico)
- [icon.png](/Users/lu/.openclaw/workspace/projects/chat-mirror/apps/aibrowseratlas-shell/build-resources/icon.png)

## Commands

Generate or refresh all brand assets:

```bash
cd projects/chat-mirror/apps/aibrowseratlas-shell
../../scripts/with-node-lts.sh npm run brand:build
```

Run the full packaging helper with brand refresh included:

```bash
cd projects/chat-mirror
./scripts/package-shell.sh all
```

## Current Submission Readiness

- macOS: icon and product metadata are wired
- Windows: icon and product metadata are wired
- Android: launcher icons, adaptive foreground, app name, and version are wired
- iOS: app icon, display name, and marketing version are wired

Remaining non-brand blockers:
- full Xcode is still required before iOS native packaging can fully complete
- public store submission still needs a privacy policy URL and support email
