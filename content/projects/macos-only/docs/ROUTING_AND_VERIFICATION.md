# Routing And Verification

## Routing rule in one sentence

Use the **simplest surface that can produce strong evidence**.

## Surface selection

### Shell

Use shell when the task is primarily:

- file creation, movement, or inspection by known path
- local CLI operations
- environment checks
- repo scripts and system state validation

Prefer shell over Ghost when:

- the file path is already known
- a native app does not need to be touched
- the result can be proven with command output or filesystem state

### Browser

Use browser automation when:

- the target is a normal website with stable DOM access
- form filling, clicking, downloads, and navigation can be done through page structure
- URL, element, or page-text checks can verify success cleanly

Prefer browser over Ghost when:

- the browser DOM is available and reliable
- the task does not require native dialogs or other desktop apps

### Ghost Desktop

Use Ghost OS when:

- the target is a native macOS app
- the task crosses multiple desktop apps or windows
- Finder, Slack Desktop, Messages, Telegram Desktop, or System Settings must be driven directly
- a repeated GUI procedure should become a reusable recipe
- browser or shell surfaces are insufficient for the real interaction

Do **not** use Ghost when:

- shell or browser already gives a cleaner path
- the task is coding or repo implementation work
- you cannot verify the resulting desktop state

### ACP / Codex

Use ACP/Codex when the task is primarily:

- writing code
- patching files
- analyzing logs or architecture
- adding scripts, tests, or documentation

Do not route implementation work into Ghost OS just because the tool exists.

## Routing table

| Surface | Best for | Avoid when | Verification style |
| --- | --- | --- | --- |
| Shell | Files, CLI, local state | A native UI must be driven | Exit status, stdout, file existence |
| Browser | DOM-stable websites | Native app or desktop dialog needed | URL, DOM, visible text, download state |
| Ghost Desktop | Native macOS apps and cross-app GUI flows | A shell/browser path is cleaner | Window state, visible text, file state, app confirmation |
| ACP/Codex | Code and repo work | No file/code change is needed | Changed files, tests, script output |

## Evidence-first doctrine

Tool output is not the same as completion.

For Ghost work, success should be backed by at least one real post-action signal such as:

- the expected window opened
- the expected control or text appeared
- a dialog closed because the intended action completed
- a file now exists where it should exist
- the target app clearly changed state

For OpenClaw-level completion, stronger bundles are better:

- route result
- post-action UI evidence
- filesystem or network artifact if relevant
- human confirmation if the workflow is sensitive

## Verification states to report honestly

### Blocked

Use this when the required execution surface is not available or not trusted.

Examples:

- `ghost` is not installed
- `ghost doctor` fails
- required permissions are missing

### Executed but unverified

Use this when the tool ran, but the outcome is not proven.

Examples:

- the click happened, but the resulting window was not checked
- a command returned `ok`, but no file or UI change was confirmed

### Verified

Use this only when post-action evidence supports the claimed result.

Examples:

- a Slack compose box shows the new draft text
- Finder now shows the file in the target folder
- System Settings displays the expected toggle state

## Composition patterns

### Browser + Shell

Use when:

- the web action is DOM-friendly
- the final proof is a local file or command result

Example:

- Browser clicks Export
- Shell waits for file in `Downloads`
- Shell validates file name and size

### Browser + Ghost

Use when:

- the website is normal until a native picker or system dialog appears

Example:

- Browser navigates to upload page
- Ghost handles the macOS file picker
- Browser verifies upload completion

### Ghost + Shell

Use when:

- the action is native UI driven
- the proof is easier to collect by file inspection or CLI

Example:

- Ghost exports from a native app
- Shell confirms the output file exists and is fresh

### ACP/Codex + Anything

Use when the task has both implementation and operational parts.

Example:

- ACP/Codex patches a script
- Shell runs it
- Ghost is used only for the remaining native UI portion

## Minimal reporting template

For Ghost-backed work, a clean report is:

- chosen surface and why
- action taken
- post-action evidence collected
- final status: `verified`, `executed but unverified`, or `blocked`

That reporting style keeps OpenClaw honest and keeps desktop automation from turning into narrative-only success.
