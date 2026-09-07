# VS Code setup

This config applies to VS Code, VSCodium, and Kiro — all three are Code-OSS
based, so they read the same `settings.json` format and pull extensions from
compatible marketplaces (VSCodium and Kiro default to Open VSX, which carries
all three extensions below). Kiro also ships its own built-in AI agent panel,
so `anthropic.claude-code` may be redundant there — install it anyway if you
want Claude Code specifically, skip it otherwise.

## 1. Settings

[`settings.json`](settings.json) holds the shared config used across all
profiles: Vim emulation (leader key, search/clipboard behavior) plus
Which-Key menus that mirror the IdeaVim mappings in the repo root's
`.ideavimrc`, so muscle memory carries over between VS Code and JetBrains IDEs.

Symlink it into the default profile:

```sh
ln -sf "$(pwd)/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
ln -sf "$(pwd)/settings.json" "$HOME/Library/Application Support/VSCodium/User/settings.json"
ln -sf "$(pwd)/settings.json" "$HOME/Library/Application Support/Kiro/User/settings.json"
```

(`install.sh` at the repo root does this for you, for all three editors. On
Linux these paths are `~/.config/Code/User/settings.json`,
`~/.config/VSCodium/User/settings.json`, and `~/.config/Kiro/User/settings.json`.)

## 2. Extensions

Base set, needed in every profile ([`extensions.txt`](extensions.txt)):

```sh
xargs -n1 code --install-extension < extensions.txt
xargs -n1 codium --install-extension < extensions.txt
xargs -n1 kiro --install-extension < extensions.txt
```

| Extension | Purpose |
| --- | --- |
| `vscodevim.vim` | Vim emulation, driven by the `vim.*` keys in `settings.json` |
| `vspacecode.whichkey` | Leader-key popup menu |
| `anthropic.claude-code` | Claude Code |

Optional per-language profile add-ons — install each into its own dedicated
profile rather than the default one, via `Profiles > Create Profile`, to keep
the default profile lean:

**Java** ([`extensions-java.txt`](extensions-java.txt)) — language support,
debugger, test runner, Maven/Gradle tooling:

```sh
xargs -n1 code --install-extension < extensions-java.txt
```

**Python** ([`extensions-python.txt`](extensions-python.txt)) — language
support (Pylance), debugger, and Ruff for linting/formatting:

```sh
xargs -n1 code --install-extension < extensions-python.txt
```

**TypeScript** ([`extensions-typescript.txt`](extensions-typescript.txt)) —
ESLint and Prettier (TypeScript/JavaScript language support itself is built
into VS Code):

```sh
xargs -n1 code --install-extension < extensions-typescript.txt
```

Swap `code` for `codium` or `kiro` to install into those editors instead.
