# Install And Permissions

## Read this first

This repository does **not** bundle Ghost OS and does **not** currently claim a successful local Ghost install on the authoring machine.

As of **2026-03-17**, local verification found:

- host OS: `Darwin`
- `ghost`: **not found on `PATH`**

So treat this document as a practical setup guide for the next step, not a fake success report.

## Prerequisites

Before OpenClaw can use Ghost OS as a desktop adapter, you need:

- a local macOS machine with an active GUI session
- Ghost OS installed according to its official upstream instructions
- a `ghost` executable available on `PATH`
- a terminal or host process that OpenClaw will actually run through

## Installation posture

Because the exact Ghost OS install flow can change upstream, this repo intentionally does **not** hardcode an unverified install command.

Instead, follow this order:

1. Install Ghost OS from its official upstream documentation
2. Confirm the binary is available:

   ```bash
   command -v ghost
   ghost --help
   ```

3. Run the upstream doctor/health check if available:

   ```bash
   ghost doctor
   ```

4. Run the repo-level verification wrapper:

   ```bash
   ./scripts/verify-ghost-os.sh
   ```

If step 4 fails, do not claim the adapter is ready.

## macOS permissions you should expect

The exact prompts can vary depending on how Ghost OS is packaged upstream, but these are the normal macOS permission classes to plan for.

### Accessibility

Usually required for:

- reading UI structure
- clicking controls
- typing into native apps
- navigating menus and dialogs

Important detail: the permission must often be granted to the **actual invoking process**, not just to Ghost OS in the abstract. That can mean your terminal app, your launcher, or another host process.

### Screen Recording

Often needed for:

- screenshot-based fallbacks
- richer desktop state capture
- evidence collection when the accessibility tree is incomplete

If Ghost OS or your surrounding toolchain captures screenshots, assume you may need this permission.

### Automation / Apple Events

Often needed when one process controls another macOS application. If Ghost OS or the launcher triggers app-level control through Apple Events or related automation bridges, macOS may prompt for permission.

### Files And Folders / Full Disk Access

Sometimes relevant for:

- Finder workflows over protected folders
- moving files in `Desktop`, `Documents`, `Downloads`, or cloud-synced locations
- reading or validating outputs after a GUI export

Do not request these permissions by default unless the workflow actually needs them.

## Where to manage permissions

Open:

`System Settings -> Privacy & Security`

The exact pane names may differ slightly by macOS release, but look for:

- Accessibility
- Screen Recording
- Automation
- Files and Folders
- Full Disk Access

## Verification checklist

After installation and permissions, the minimum honest checklist is:

- `command -v ghost` returns a real path
- `ghost --help` or `ghost --version` works
- `ghost doctor` exits successfully
- `./scripts/verify-ghost-os.sh` exits successfully
- at least one real workflow is executed and verified by post-action evidence

Until all of that is true, describe the system as **partially prepared** rather than fully working.

## Common blocked states

### `ghost-not-installed`

Meaning: the repo is present, but the execution layer is missing.

Action:

- install Ghost OS
- ensure the binary is on `PATH`
- rerun `./scripts/verify-ghost-os.sh`

### `doctor-failed`

Meaning: Ghost OS exists, but its own health check says the local environment is not ready.

Action:

- read the doctor output carefully
- fix the concrete blocker instead of guessing
- rerun the verification script

### Permission denied or silent no-op behavior

Meaning: the host may be missing Accessibility, Screen Recording, or Automation trust.

Action:

- check `System Settings -> Privacy & Security`
- confirm the permission applies to the actual invoking process
- rerun the local verification flow
