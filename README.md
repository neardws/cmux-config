# cmux config

Personal cmux configuration for macOS.

## Files

- `cmux/cmux.json` - cmux app settings, using JSONC.
- `ghostty/config` - Ghostty terminal settings used by cmux for terminal appearance and behavior.
- `scripts/cmux-notification-sound-policy` - notification hook that keeps visual alerts but deduplicates repeated sounds.
- `scripts/install.sh` - backs up existing local config files and links this repo into the expected locations.

## Install

From this repository:

```sh
./scripts/install.sh
cmux reload-config
```

The installer backs up existing files with a timestamped `.bak` suffix before creating symlinks.

## Local Paths

cmux reads configuration from:

```text
~/.config/cmux/cmux.json
~/.config/ghostty/config
```

cmux can report and validate these paths with:

```sh
cmux config paths
cmux config check
```

## What To Configure

Required for this repo:

- Keep `cmux/cmux.json` as the global cmux settings file. It should include `$schema` and `schemaVersion: 1` so editors can validate it against the published cmux schema.
- Keep `ghostty/config` for terminal rendering settings. cmux uses Ghostty for terminal behavior, so font, font size, theme, padding, scrollback, cursor, split styling, opacity, and blur belong there.
- Reload after edits with `cmux reload-config` or `Cmd+Shift+,`.

Good candidates to version here:

- App behavior: appearance, confirm-quit behavior, workspace placement, workspace directory inheritance, markdown viewer settings, file editor wrapping, and sidebar preferences.
- Terminal behavior: `font-family`, `font-size`, `theme`, `scrollback-limit`, padding, cursor style, split divider color, background opacity, and background blur.
- Keyboard shortcuts: store custom shortcuts under `shortcuts.bindings`; use a string for one-step shortcuts, a two-item array for prefix chords, and `null` or an empty string to unbind a shortcut.
- Browser defaults: search engine, custom search URL, whether terminal links open in cmux browser, and embedded-browser host allowlists such as `localhost`.
- Notifications: badge, sound, pane flash, menu bar behavior, notification command, and notification hooks when they are portable.
- Automation defaults: socket access mode, agent integration toggles, subagent notification suppression, and workspace port allocation.
- Workspace colors and sidebar appearance when they are personal preferences rather than project-specific state.

## Current Workflow Choices

This config is tuned for parallel agent work:

- New workspaces open after the current workspace and inherit the working directory.
- Forked conversations default to a right split.
- Workspaces with new notifications can move toward the top.
- Agent sessions automatically resume when cmux reopens.
- Agent Hibernation is enabled with a conservative 30-minute idle window and up to 12 live restorable terminals.
- Codex/Claude/Cursor/Gemini/Amp/Kiro integrations stay enabled, while nested subagent notifications are suppressed.
- The sidebar shows working directory, PR metadata, git status, ports, SSH details, logs, progress, notification messages, and custom metadata.
- Workspace colors use a muted custom palette with the active workspace shown as a left rail.

Notifications use the built-in `Ping` sound plus `scripts/cmux-notification-sound-policy`. The hook keeps badges, unread rings, pane flash, and notification history, but disables repeated sounds from the same workspace/surface/title/subtitle within 20 seconds. Override the window with:

```sh
export CMUX_SOUND_DEDUPE_WINDOW=45
```

The install script links the hook to:

```text
~/.local/bin/cmux-notification-sound-policy
```

Use project-local config instead of this global repo for project behavior:

- `.cmux/cmux.json` inside a project for project-specific actions, command palette entries, workspace layouts, and surface tab bar buttons.
- `.cmux/dock.json` inside a project for shared Dock controls such as dev servers, logs, test watchers, git status, queues, or TUIs.
- `~/.config/cmux/dock.json` for a personal Dock that should apply outside a specific repo.

Do not commit:

- API keys, tokens, socket passwords, SSH keys, private hostnames, or credentials.
- Machine-specific absolute paths unless they are intentionally personal and harmless.
- Project Dock commands that rely on unavailable local tools or private env files.
- SSH identity files or raw SSH options. Put those in `~/.ssh/config` instead.

## Useful cmux Commands

```sh
cmux config paths
cmux config check
cmux reload-config
cmux shortcuts
cmux docs settings
cmux docs dock
cmux docs api
cmux browser --help
```

## Notes

- Do not commit secrets, API keys, socket passwords, private hostnames, or machine-specific credentials.
- Terminal font, theme, padding, cursor, opacity, and keybindings are controlled by the Ghostty config.
- cmux can reload both cmux and Ghostty configuration without restarting the app.

## References

- [cmux Configuration](https://cmux.com/docs/configuration)
- [cmux Custom Commands](https://cmux.com/docs/custom-commands)
- [cmux Dock](https://cmux.com/docs/dock)
- [cmux Keyboard Shortcuts](https://cmux.com/docs/keyboard-shortcuts)
- [cmux CLI Reference](https://cmux.com/docs/api)
- [cmux Browser Automation](https://cmux.com/docs/browser-automation)
- [cmux Notifications](https://cmux.com/docs/notifications)
- [cmux SSH](https://cmux.com/docs/ssh)
