# VS Code setup

This config applies to both VS Code and VSCodium — they read the same
`settings.json` format and pull extensions from compatible marketplaces
(VSCodium defaults to Open VSX, which carries all three extensions below).

## 1. Settings

[`settings.json`](settings.json) holds the shared config used across all
profiles: Vim emulation (leader key, search/clipboard behavior) plus
Which-Key menus that mirror the IdeaVim mappings in the repo root's
`.ideavimrc`, so muscle memory carries over between VS Code and JetBrains IDEs.

Symlink it into the default profile:

```sh
ln -sf "$(pwd)/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
ln -sf "$(pwd)/settings.json" "$HOME/Library/Application Support/VSCodium/User/settings.json"
```

(`install.sh` at the repo root does this for you, for both editors. On Linux
these paths are `~/.config/Code/User/settings.json` and
`~/.config/VSCodium/User/settings.json`.)

## 2. Extensions

Base set, needed in every profile ([`extensions.txt`](extensions.txt)):

```sh
xargs -n1 code --install-extension < extensions.txt
xargs -n1 codium --install-extension < extensions.txt
```

| Extension | Purpose |
| --- | --- |
| `vscodevim.vim` | Vim emulation, driven by the `vim.*` keys in `settings.json` |
| `vspacecode.whichkey` | Leader-key popup menu |
| `anthropic.claude-code` | Claude Code |

Optional Java profile add-ons ([`extensions-java.txt`](extensions-java.txt)):

```sh
xargs -n1 code --install-extension < extensions-java.txt
```

(Java language support, debugger, test runner, Maven/Gradle tooling — install
these into a dedicated VS Code profile rather than the default one, via
`Profiles > Create Profile`, to keep the default profile lean.)
