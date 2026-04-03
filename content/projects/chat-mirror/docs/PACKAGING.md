# Packaging Guide

This project now ships with a dedicated native shell at [apps/aibrowseratlas-shell](/Users/lu/.openclaw/workspace/projects/chat-mirror/apps/aibrowseratlas-shell).

Current packaging strategy:
- `Electron + electron-builder` for macOS and Windows
- `Capacitor` for iOS and Android
- native WeChat Mini Program shell for WeChat distribution
- all shells point to the live workspace at `https://chat.aibrowseratlas.com`
- mobile/webview shells use `https://chat.aibrowseratlas.com` as the canonical workspace entry

Brand and listing source of truth:
- [store-listing.json](/Users/lu/.openclaw/workspace/projects/chat-mirror/apps/aibrowseratlas-shell/metadata/store-listing.json)
- [STORE_METADATA.md](/Users/lu/.openclaw/workspace/projects/chat-mirror/docs/STORE_METADATA.md)

## Product Identity

- product name: `AibrowserAtlas`
- desktop bundle id: `com.qs.mlchat`
- iOS bundle id: `com.qs.mlchat`
- Android bundle id: `com.aibrowseratlas.mobile`
- release line: `v1.0.2 stable`

## What Exists Now

- desktop shell:
  - Developer ID signed `.dmg` / `.zip` on macOS Apple Silicon when a valid macOS identity is available in keychain
  - unsigned `nsis` / `portable` artifacts for Windows ARM64
- mobile shell:
  - Android signed `release APK`, `debug APK`, and `release AAB`
  - import-ready WeChat Mini Program source shell for WeChat DevTools
  - native `ios/` project plus downloadable iOS project-source zip aligned to `com.qs.mlchat`
  - downloadable HarmonyOS project-source zip plus Stage-model app scaffold
  - `cap sync` based update path after web-shell config changes

## Host Requirements

- use Node `22` or `24` via [with-node-lts.sh](/Users/lu/.openclaw/workspace/projects/chat-mirror/scripts/with-node-lts.sh)
- Android packaging later needs Android Studio + SDK
- iOS packaging later needs full Xcode + CocoaPods + Apple Developer team
- macOS signed release later needs Developer ID Application certificate
- Windows signed release later needs OV/EV code-signing certificate on a Windows-capable signing path
- first Android sync on a fresh machine may spend several minutes downloading the Gradle distribution

## One Command Entry

Use [package-shell.sh](/Users/lu/.openclaw/workspace/projects/chat-mirror/scripts/package-shell.sh):

```bash
./scripts/package-shell.sh all
./scripts/package-shell.sh doctor
```

Brand-only refresh:

```bash
cd apps/aibrowseratlas-shell
../../scripts/with-node-lts.sh npm run brand:build
```

Packaging flow:

```bash
./scripts/package-shell.sh doctor
./scripts/package-shell.sh doctor-apple
./scripts/package-shell.sh configure-ios-default
./scripts/package-shell.sh bootstrap-mobile
./scripts/package-shell.sh dist-mac
./scripts/package-shell.sh dist-win
```

Meaning:
- `doctor`: verify shell metadata
- `doctor-apple`: verify Apple host readiness, notarization auth inputs, and iOS provisioning alignment
- `configure-ios-default`: reapply the default `com.qs.mlchat` + `milichat` iOS signing alignment after a sync
- `bootstrap-mobile`: install deps, create `android/ios` if missing, run `cap sync`
- `dist-mac`: produce mac desktop artifacts
- `dist-win`: run Windows desktop packaging config from the current host
- `all`: install, doctor, bootstrap mobile, and run desktop directory packaging smoke

## Signing Placeholders

Current posture is mixed by platform so packaging can move before every store certificate arrives.

Desktop:
- macOS signing is enabled automatically when `electron-builder` can see a valid `Developer ID Application` identity in keychain
- Windows executable signing is disabled with `signAndEditExecutable: false`

Later certificate handoff:
- macOS:
  - provide Developer ID Application certificate in keychain
  - provide notarization credentials, ideally `APPLE_NOTARY_KEY`, `APPLE_NOTARY_KEY_ID`, and `APPLE_NOTARY_ISSUER`
  - enable hardened runtime / notarization once identity is real
- Windows:
  - provide OV/EV certificate
  - likely build/sign on Windows CI or a Windows host
- iOS:
  - open `apps/aibrowseratlas-shell/ios/App/App.xcworkspace`
  - set Apple team, signing identity, and provisioning profile

## Expected Artifacts

Desktop output path:
- `apps/aibrowseratlas-shell/dist/`

Likely artifact names:
- `AibrowserAtlas-1.0.2-mac-arm64.dmg`
- `AibrowserAtlas-1.0.2-mac-arm64.zip`
- `AibrowserAtlas-1.0.2-setup-arm64.exe`
- `AibrowserAtlas-1.0.2-portable-arm64.exe`

Mobile output path:
- Android Studio build outputs under `apps/aibrowseratlas-shell/android/app/build/outputs/`
- Xcode archives created from `apps/aibrowseratlas-shell/ios/App/`
- release download catalog under `release-downloads/catalog.json`

Current downloadable matrix:
- installable test packages: macOS DMG/ZIP, Windows setup/portable, Android signed release APK, Android debug APK
- build artifacts: Android release AAB
- source bundles: WeChat Mini Program source zip, iOS project zip, HarmonyOS project zip
- blocked/pending: iOS IPA on a full Xcode host, HarmonyOS HAP on a Huawei build host

Apple-specific readiness notes:
- [APPLE_RELEASE_READINESS.md](/Users/lu/.openclaw/workspace/projects/chat-mirror/docs/APPLE_RELEASE_READINESS.md)

Public install assistance pages:
- Android: `/android-install.html`
- Desktop: `/desktop-install.html`
- WeChat Mini Program: `/wechat-mini-install.html`
- iOS: `/ios-install.html`
- HarmonyOS: `/harmony-install.html`

## Review Constraints

This shell currently loads remote web content from `chat.aibrowseratlas.com`.

That is acceptable for internal distribution and rapid packaging, but later app-store review may require:
- stronger offline handling
- clearer privacy copy
- native file/import/export affordances
- store-review-compliant remote content explanation

## Recommended Next Certificate Drop

When certificates are ready, the minimal next handoff should be:
1. macOS Developer ID cert name
2. Apple team id for iOS signing
3. Windows certificate path or CI signing method
4. final icons for desktop/mobile stores
