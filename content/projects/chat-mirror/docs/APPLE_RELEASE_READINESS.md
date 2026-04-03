# Apple Release Readiness

Current host and signing posture for `AibrowserAtlas`.

## Current Truth

- mac shell bundle id: `com.qs.mlchat`
- iOS mobile bundle id: `com.qs.mlchat`
- current client version: `1.0.2`

## What Is Already Working

- macOS `Developer ID Application` signing now works on this host
- `notarytool` and `stapler` are available through `xcrun`
- App Store Connect API-key authentication now works with:
  - key file: `/Users/lu/Downloads/AuthKey_P78732PRV7.p8`
  - key id: `P78732PRV7`
  - issuer id: `147d3592-7cc0-4c95-a064-a4c9f04b4aff`
- the desktop shell now builds with `hardenedRuntime: true`
- Android packaging is no longer the blocker

## Current macOS Notarization State

Authentication is no longer the blocker.

The first real submission with working credentials failed because the app bundle was signed without hardened runtime. That has now been fixed in the desktop build config, and the rebuilt DMG is the correct artifact to submit.

The active notarization paths are:

1. preflight:
   - `bash scripts/notarize-mac.sh check`
2. submit:
   - `bash scripts/notarize-mac.sh submit`

The older key at `/Users/lu/Downloads/signature_all/ios/AuthKey_AH52399668.p8` should not be treated as the default notarization key for this release line.

## What Still Blocks iOS IPA Export

The remaining blocker is now toolchain-only:

1. Full Xcode is not selected on this host
   - current `xcode-select -p` points to Command Line Tools
   - `xcodebuild` archive/export is not available until full Xcode is installed and selected

The provisioning profile and bundle id are now aligned by default:

- current app id: `com.qs.mlchat`
- profile app id: `2B7JZ4N26U.com.qs.mlchat`

## Files Provided So Far

- mac certificate:
  - `/Users/lu/Downloads/signature_all/mac/milichat_mac.p12`
  - `/Users/lu/Downloads/signature_all/mac/developerID_application.cer`
- iOS certificate and profile:
  - `/Users/lu/Downloads/signature_all/ios/mili.p12`
  - `/Users/lu/Downloads/signature_all/ios/distribution.cer`
  - `/Users/lu/Downloads/signature_all/ios/milichat.mobileprovision`
- notarization API key:
  - `/Users/lu/Downloads/AuthKey_P78732PRV7.p8`

## Added Tooling

- doctor:
  - `bash scripts/apple-release-doctor.sh`
- notarization preflight / submit:
  - `bash scripts/notarize-mac.sh check`
  - `bash scripts/notarize-mac.sh submit`
- iOS release-mode switch:
  - `bash scripts/package-shell.sh configure-ios-default`
- public source bundles:
  - default bundle: `AibrowserAtlas-1.0.2-ios-project.zip`
  - current bundle id inside the source bundle: `com.qs.mlchat`

## Minimal Next Handoff

To finish mac notarization:

1. run `bash scripts/notarize-mac.sh submit`
2. wait for `Accepted`
3. staple and validate the DMG
4. rerun `node scripts/publish-downloads.mjs` so download metadata reflects notarized status

To finish iOS IPA export:

1. install full Xcode and point `xcode-select` to it
2. archive/export from `apps/aibrowseratlas-shell/ios/App/App.xcworkspace`
