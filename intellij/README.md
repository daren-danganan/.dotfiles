# IntelliJ IDEA setup

Applies to any JetBrains IDE that bundles IdeaVim (WebStorm, PyCharm, RustRover,
etc.), though the plugin list here was captured from IntelliJ IDEA.

## 1. IdeaVim config

The `.ideavimrc` at the repo root defines the Vim keybindings (leader key,
NERDTree, which-key, debug/buffer/navigation mappings). Symlink it into place:

```sh
ln -sf "$(pwd)/../.ideavimrc" ~/.ideavimrc
```

(`install.sh` at the repo root does this for you.)

Reload it from inside the IDE without restarting via
`Tools > Reload IdeaVim Configuration` (or `:source ~/.ideavimrc` in the IdeaVim
Ex command line).

## 2. Plugins

Install everything listed in [`plugins.txt`](plugins.txt):

- **GUI**: `Settings/Preferences > Plugins > Marketplace`, search by name and
  install (names are commented next to each ID in the file).
- **Headless / scripted**, once the IDE has been run at least once so its
  config directory exists:

  ```sh
  idea installPlugins $(grep -v '^#' intellij/plugins.txt | grep -v '^$' | awk '{print $1}' | tr '\n' ' ')
  ```

  (`idea` is the CLI launcher; substitute `webstorm`, `pycharm`, etc. for other
  products. Restart the IDE afterwards.)

What each plugin is for:

| Plugin | Purpose |
| --- | --- |
| IdeaVIM | Vim emulation, driven by `.ideavimrc` |
| Which-Key | Leader-key popup, mirrors the `<leader>` mappings in `.ideavimrc` |
| IdeaVim Multicursor | `set multicursor` support referenced in `.ideavimrc` |
| VSCode Keymap | Keeps non-Vim shortcuts consistent with VS Code |
| GitHub Copilot | AI code completion |
| Material Theme UI Lite | Editor/UI theme |
| MCP Server | Exposes the IDE over MCP (e.g. for Claude Code / Claude Desktop integration) |

## 3. Keymap

Set `Settings/Preferences > Keymap` to **VSCode** so muscle memory carries over
between the IDE and VS Code; `.ideavimrc` layers Vim bindings on top of that.
