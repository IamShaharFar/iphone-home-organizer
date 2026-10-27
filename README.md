# iPhone Home Organizer

![AI-generated concept illustration of organizing an iPhone Home Screen through a Mac.](linkedin-cover.png)

*AI-generated concept illustration, not a screenshot or evidence of device execution.*

**Requires Computer Use.** To apply changes, your agent must already be authorized to **see and control the native iPhone Mirroring window on your Mac**, including supported drag gestures. Installing this skill does not add GUI tools, grant permissions, or make a CLI desktop-capable.

An agent-neutral [Agent Skills](https://agentskills.io/specification) workflow: **ask → inspect → propose an exact layout → get explicit approval → move in small batches → verify**.

**Prototype, not device-tested.** The author reports doing a similar task with Codex, Computer Use, and Apple's iPhone Mirroring. This reusable package was prepared without that Mac or its precise tool/OS configuration. No listed agent has been end-to-end tested with this package.

[עברית — התחלה מהירה](docs/START-HERE.he.md)

## Compatibility: instructions are not device control

The same vendor-neutral `SKILL.md` is copied for every target. Paths below are documented discovery locations, **not certification that an agent can operate your Mac**.

| Agent | Documented skill discovery / installer target | Native Mac Computer Use | This package's device test |
|---|---|---|---|
| [Codex](https://learn.chatgpt.com/docs/build-skills) | `~/.agents/skills`; `--agent codex` also honors `CODEX_HOME` | Requires an existing capable, authorized environment | Not tested |
| [Claude Code](https://code.claude.com/docs/en/skills) | `~/.claude/skills`; `--agent claude` | Separate compatible desktop-control setup required; not supplied here | Not tested |
| [Cursor](https://cursor.com/docs/skills) | `~/.cursor/skills` or shared `~/.agents/skills`; `--agent cursor` | [Self-hosted computer-use option](https://cursor.com/docs/cloud-agent/self-hosted/computer-use) exists; requires separate setup/permissions | Not tested |
| [Gemini CLI](https://geminicli.com/docs/cli/skills/) | `~/.gemini/skills` or shared `~/.agents/skills`; `--agent gemini` | Separate compatible integration required; not validated here | Not tested |
| [OpenCode](https://opencode.ai/docs/skills/) | `~/.config/opencode/skills` or shared `~/.agents/skills`; `--agent opencode` | Separate compatible integration required; not validated here | Not tested |
| Other agents, including Grok Bot | No import path assumed. Ask the host to read the file directly if supported. No installer target. | Must establish actual access to this Mac, not just a cloud/browser computer | Not tested |

`--agent shared` (the default) uses `~/.agents/skills`, documented for Codex, Cursor, Gemini CLI, and OpenCode. Use the Claude target for Claude Code. Custom host configurations may use other roots: follow that host's documentation rather than assuming discovery. Format/discovery compatibility does not imply Computer Use compatibility.

## Quick install

Review [the repository](https://github.com/IamShaharFar/iphone-home-organizer) and `install.sh` first. Default shared location:

```sh
git clone https://github.com/IamShaharFar/iphone-home-organizer.git && sh iphone-home-organizer/install.sh
```

Choose a native target instead, for example Claude Code:

```sh
git clone https://github.com/IamShaharFar/iphone-home-organizer.git && sh iphone-home-organizer/install.sh --agent claude
```

Already downloaded or cloned? Run from the repository root, choosing **one** target:

```sh
sh install.sh --agent shared
# Other choices: codex, claude, cursor, gemini, opencode
```

Only `skills/iphone-home-organizer/SKILL.md` is copied. Existing files, directories, and symlink destinations are refused, with no overwrite/force option. No network calls, `sudo`, app installs, GUI permission changes, or iPhone actions occur inside the installer.

For an explicit custom/legacy Codex home:

```sh
CODEX_HOME="$HOME/.codex" sh install.sh --agent codex
```

Only the `codex` target reads `CODEX_HOME`; shared and other targets ignore it. No-argument installation always chooses the shared path. To update, review and move the old skill yourself before reinstalling. To uninstall, remove only the installed `iphone-home-organizer` folder after checking for anything you want to keep. Do not install duplicate copies into multiple search roots of the same agent without reviewing precedence.

## Use

1. Ensure Apple's iPhone Mirroring works on your Mac. Its requirements include Apple silicon/T2, macOS 15+, iOS 18+ with a passcode, the same Apple Account with two-factor authentication, Wi-Fi/Bluetooth, and a nearby locked iPhone. Check [Apple's current requirements and regional availability](https://support.apple.com/en-us/120421).
2. Complete setup and authentication yourself; do not send passwords, passcodes, or verification codes to the agent.
3. Use your host's documented skill selector, or attach/open `skills/iphone-home-organizer/SKILL.md` directly. For example: Codex supports `$iphone-home-organizer`; Claude Code and Cursor support `/iphone-home-organizer`. For other hosts, ask to use the named skill and follow their discovery/approval flow.
4. Start with this agent-neutral request:

```text
Read and follow the iphone-home-organizer skill to help organize my iPhone
Home Screen through Apple's iPhone Mirroring on my Mac. First check your
actual Computer Use capabilities. Ask briefly about my priority apps and
folder preferences. Keep my Dock and widgets unchanged by default. Show the
exact change list and wait for my explicit approval before applying it.
If you cannot control this Mac and the mirrored iPhone, provide a plan and
manual steps only. Do not claim the plan was applied.
```

## Safety and privacy

- Preserves the Dock and existing widgets by default; asks about protected items and preferences.
- Inventories visible pages, then proposes exact moves and folder changes before seeking explicit approval.
- Re-observes after each drag and stops on uncertainty, rather than repeating blind gestures.
- Does not delete apps, change app data, edit App Library's automatic categories, or change Focus, Lock Screen, accounts, authentication, or other device settings.
- Screenshots are visual records, **not restorable backups**. Full restoration is not guaranteed.
- With no device or suitable Computer Use, provides **planning/manual instructions only**.
- Contains no personal app inventory, device screenshots, credentials, or device data. Do not publish private task records in a fork or issue; use fictional examples.

## Validation and limits

- Open Agent Skills-style frontmatter/naming checked with `quick_validate.py`.
- `sh tests/test-install.sh`: **31 isolated installer tests**, covering all six targets, paths with spaces, arguments, source validation, existing destinations, and no clobbering. Tests use temporary homes, not your real agent configuration.
- Shell tests ran on Linux, not macOS. No client discovery integration, Mac/iPhone end-to-end, or Computer Use integration test was performed. Documentation-supported paths are not observed successful client imports.
- No device changes or real-home installation were performed while creating/testing the package.

Prepared 2026-10-27. Independent project, not an official product of Apple or any listed agent vendor. **License: [MIT](LICENSE).**
