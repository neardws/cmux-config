# cmux config

Personal cmux configuration for macOS.

## Files

- `cmux/cmux.json` - cmux app settings, using JSONC.
- `ghostty/config` - Ghostty terminal settings used by cmux for terminal appearance and behavior.
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

## Notes

- Do not commit secrets, API keys, socket passwords, private hostnames, or machine-specific credentials.
- Terminal font, theme, padding, cursor, opacity, and keybindings are controlled by the Ghostty config.
- cmux can reload both cmux and Ghostty configuration without restarting the app.

