#!/usr/bin/env sh
# Symlinks this repo's editor config into place and installs VS Code extensions.
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
    Darwin) vscode_user_dir="$HOME/Library/Application Support/Code/User" ;;
    *)      vscode_user_dir="$HOME/.config/Code/User" ;;
esac
link "$repo_dir/vscode/settings.json" "$vscode_user_dir/settings.json"

if command -v code >/dev/null 2>&1; then
    echo "Installing base VS Code extensions..."
    xargs -n1 code --install-extension < "$repo_dir/vscode/extensions.txt"
else
    echo "VS Code CLI ('code') not found on PATH; skipping extension install."
    echo "Run 'Shell Command: Install code command in PATH' from VS Code's command palette, then re-run this script."
fi

echo
echo "IntelliJ plugins are not installed automatically — see intellij/README.md."
