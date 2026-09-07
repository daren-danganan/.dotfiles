#!/usr/bin/env sh
# Symlinks this repo's editor config into place and installs VS Code /
# VSCodium / Kiro extensions.
# Safe to re-run; existing symlinks are replaced, but it will not clobber a
# real (non-symlink) file without asking first.
set -eu

repo_dir="$(cd "$(dirname "$0")" && pwd)"

link() {
    src="$1"
    dest="$2"
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        printf 'Skipping %s: a real file already exists there (move it aside first)\n' "$dest"
        return
    fi
    mkdir -p "$(dirname "$dest")"
    ln -sf "$src" "$dest"
    printf 'Linked %s -> %s\n' "$dest" "$src"
}

link "$repo_dir/.ideavimrc" "$HOME/.ideavimrc"

case "$(uname -s)" in
    Darwin)
        vscode_user_dir="$HOME/Library/Application Support/Code/User"
        vscodium_user_dir="$HOME/Library/Application Support/VSCodium/User"
        kiro_user_dir="$HOME/Library/Application Support/Kiro/User"
        ;;
    MINGW*|MSYS*|CYGWIN*)
        vscode_user_dir="$(cygpath -u "$APPDATA")/Code/User"
        vscodium_user_dir="$(cygpath -u "$APPDATA")/VSCodium/User"
        kiro_user_dir="$(cygpath -u "$APPDATA")/Kiro/User"
        echo "Windows detected: symlinking requires Developer Mode enabled (Settings > Update & Security > For developers), or running Git Bash as Administrator — otherwise 'ln -s' below will fail with Permission denied."
        ;;
    *)
        vscode_user_dir="$HOME/.config/Code/User"
        vscodium_user_dir="$HOME/.config/VSCodium/User"
        kiro_user_dir="$HOME/.config/Kiro/User"
        ;;
esac
link "$repo_dir/vscode/settings.json" "$vscode_user_dir/settings.json"
link "$repo_dir/vscode/settings.json" "$vscodium_user_dir/settings.json"
link "$repo_dir/vscode/settings.json" "$kiro_user_dir/settings.json"

if command -v code >/dev/null 2>&1; then
    echo "Installing base VS Code extensions..."
    xargs -n1 code --install-extension < "$repo_dir/vscode/extensions.txt"
else
    echo "VS Code CLI ('code') not found on PATH; skipping extension install."
    echo "Run 'Shell Command: Install code command in PATH' from VS Code's command palette, then re-run this script."
fi

if command -v codium >/dev/null 2>&1; then
    echo "Installing base VSCodium extensions..."
    xargs -n1 codium --install-extension < "$repo_dir/vscode/extensions.txt"
else
    echo "VSCodium CLI ('codium') not found on PATH; skipping extension install."
    echo "Run 'Shell Command: Install codium command in PATH' from VSCodium's command palette, then re-run this script."
fi

if command -v kiro >/dev/null 2>&1; then
    echo "Installing base Kiro extensions..."
    xargs -n1 kiro --install-extension < "$repo_dir/vscode/extensions.txt"
else
    echo "Kiro CLI ('kiro') not found on PATH; skipping extension install."
    echo "Run 'Shell Command: Install kiro command in PATH' from Kiro's command palette, then re-run this script."
fi

echo
echo "IntelliJ plugins are not installed automatically — see intellij/README.md."
