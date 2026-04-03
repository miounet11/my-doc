# HarmonyOS Packaging

This project now includes a HarmonyOS shell scaffold at [apps/aibrowseratlas-harmony](/Users/lu/.openclaw/workspace/projects/chat-mirror/apps/aibrowseratlas-harmony).

Current direction:
- application model: `Stage`
- surface: ArkTS + `Web` component
- package target: `HAP`
- workspace URL: `https://chat.aibrowseratlas.com`

Why this path is valid:
- Huawei's HarmonyOS application development guide defines the standard application development path for Stage-model apps.
- Huawei's `Web` component documentation provides the official browser/webview surface used to embed remote content inside HarmonyOS apps.

Current host truth:
- HarmonyOS source scaffold is ready.
- HarmonyOS project-source zip can now be published into the download center for handoff to a Huawei build machine.
- No installable `HAP` has been generated yet on this machine.
- The remaining blocker is toolchain availability, not product architecture.

Required toolchain:
- DevEco Studio
- HarmonyOS SDK
- Huawei signing profile if you want a distributable signed package

Suggested next step on a Harmony-capable machine:
1. import `apps/aibrowseratlas-harmony` into DevEco Studio
2. sync Harmony SDK components
3. replace the placeholder media assets
4. build the `entry` module to generate `HAP`
5. publish the generated HAP back into `release-downloads/files/`
