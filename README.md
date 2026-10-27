# iPhone Home Organizer

**Requires Computer Use.** To apply changes, your Codex environment must already be authorized to **see and control the native iPhone Mirroring window on your Mac**, including supported drag gestures. This skill does not grant GUI tools or permissions. An ordinary Codex CLI installation alone is not enough.

A personalized Home Screen workflow: **ask → inspect → propose an exact layout → get explicit approval → move in small batches → verify**.

**Prototype, not device-tested.** The author reports using Codex with Computer Use and Apple's iPhone Mirroring for a similar task. This reusable package was prepared without access to that Mac, its precise tool configuration, or its OS versions. Compatibility and reliable dragging have not been demonstrated for this package.

[עברית — התחלה מהירה](docs/START-HERE.he.md)

## What it does

- Asks about priority apps, folder preferences, and protected items.
- Maps visible Home Screen pages, apps, folders, existing widgets, and Dock.
- Preserves the Dock and widgets by default and shows the exact proposed changes.
- Waits for explicit approval before editing, then re-observes after each drag.
- Stops on uncertain gestures instead of repeating blind actions.
- Falls back to **planning and manual instructions only** when Computer Use or the device is unavailable.

It does **not** delete apps, change app data, reorganize App Library's automatic categories, or change Focus, Lock Screen, accounts, authentication, or other device settings. Screenshots are visual records, not restorable backups. Full restoration is not guaranteed.

## Prerequisites

1. **An existing, authorized Computer Use setup** that can observe and control native Mac apps. Browser-only automation is insufficient. This repository does not install a driver, model, API integration, or permissions.
2. A compatible Mac/iPhone pair with Apple's iPhone Mirroring working. Apple's requirements include an Apple silicon/T2 Mac with macOS 15+, iOS 18+ with a passcode, the same Apple Account with two-factor authentication, Wi-Fi/Bluetooth, and a nearby locked iPhone. Check [Apple's current requirements and regional availability](https://support.apple.com/en-us/120421).
3. Complete setup and authentication yourself. Do not send passwords, device passcodes, or verification codes to the assistant.

## Install the skill instructions

Repository: [IamShaharFar/iphone-home-organizer](https://github.com/IamShaharFar/iphone-home-organizer). Review the repository and `install.sh` before running it.

Quick install after reviewing the repository:

```sh
git clone https://github.com/IamShaharFar/iphone-home-organizer.git && sh iphone-home-organizer/install.sh
```

For a downloaded/extracted copy, open a terminal in its root and run:

```sh
sh install.sh
```

The installer copies **only** `skills/iphone-home-organizer/SKILL.md` into `$HOME/.agents/skills/iphone-home-organizer/` by default, using the user-level directory in [OpenAI's current skill documentation](https://learn.chatgpt.com/docs/build-skills#where-codex-loads-local-skills). If `CODEX_HOME` is set, it instead uses `$CODEX_HOME/skills/iphone-home-organizer/` for that custom/legacy configuration. It refuses an existing destination, including a symlink, and has no overwrite option. It uses no network calls or `sudo`, and does not touch your iPhone or enable Computer Use.

If your Codex host uses a different skill-discovery mechanism, use that host's supported import method or ask it to read the `SKILL.md` file directly. The install path is not a guarantee of discovery in every host. [Official skill documentation](https://learn.chatgpt.com/docs/build-skills).

Optional custom/legacy Codex home (must be an absolute path; installs under its `skills/` subfolder):

```sh
CODEX_HOME="$HOME/.codex" sh install.sh
```

Installation is separate from granting device access or approving a layout. To update, review the old and new files first; the installer intentionally will not replace an existing skill. To uninstall, remove only the installed `iphone-home-organizer` skill folder after checking that it contains no files you want to keep.

## Use

Open iPhone Mirroring on the Mac, authenticate yourself, and confirm the right iPhone. In a Codex session that has discovered the skill:

```text
Use $iphone-home-organizer to help organize my iPhone Home Screen through
Apple's iPhone Mirroring on my Mac. Check your available Computer Use tools
first. Ask briefly about my priority apps and folder preferences. Keep my Dock
and widgets unchanged by default. Show an exact change list and wait for my
explicit approval before applying it. If you cannot control the device,
provide a plan and manual steps only.
```

Without installing, attach or open `skills/iphone-home-organizer/SKILL.md` and ask Codex to follow it. Do not mistake a text plan for changes applied to your iPhone.

## Privacy and sharing

This repository contains no personal app inventory, screenshots, credentials, or device data. Do not add your task's screenshots or private inventories to a public fork or issue. Use fictional examples when reporting a problem.

## Validation and limits

- Skill frontmatter/naming: checked with Codex's bundled `quick_validate.py`.
- Installer: shell syntax and isolated temporary-home tests, including paths with spaces and no-overwrite cases. Run `sh tests/test-install.sh` to repeat these tests; it does not install into your real home.
- No Mac/iPhone end-to-end test, Computer Use integration test, or guarantee of an exact layout/rollback.
- No device changes or global installation were performed while creating and testing this draft.

Prepared 2026-10-27. This is an independent project, not an Apple or OpenAI product. **License: [MIT](LICENSE).**
