# .dotfiles

An attempt to ease setting up my own dev environment.

## What's here

- [`.ideavimrc`](.ideavimrc) — Vim keybindings shared by any JetBrains IDE
  (leader key, which-key, debug/buffer/navigation mappings).
- [`intellij/`](intellij/) — IntelliJ-family plugin list and setup notes.
- [`vscode/`](vscode/) — VS Code `settings.json` and extension lists.
- [`install.sh`](install.sh) — symlinks the above into place and installs the
  base VS Code extensions.

## Quick start on a new machine

```sh
git clone <this-repo> ~/Codes/Projects/.dotfiles
cd ~/Codes/Projects/.dotfiles
./install.sh
```

Then follow [`intellij/README.md`](intellij/README.md) to install the
JetBrains plugins (no CLI-free way to do this until the IDE has run once).

See [`vscode/README.md`](vscode/README.md) for details on the VS Code
extension sets, including the optional Java profile.
