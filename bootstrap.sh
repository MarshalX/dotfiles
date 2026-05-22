#!/usr/bin/env bash
#
# bootstrap.sh — set up a fresh macOS machine after cloning this repo.
#
# Pre-requisites (do these first; see README):
#   - Homebrew installed and on PATH
#   - Repo cloned (you're running this from its root)
#
# Interactive: oh-my-zsh, mackup, and .macos will prompt for input/sudo.
# Idempotent: safe to re-run.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_DIR"

echo "==> brew bundle"
HOMEBREW_NO_INSTALL_FROM_API=1 brew bundle --file=Brewfile

echo "==> oh-my-zsh"
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  RUNZSH=no CHSH=no sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

echo "==> zsh plugins"
clone_plugin() {
  local url="$1" dest="$2"
  [[ -d "$dest" ]] || git clone --depth=1 "$url" "$dest"
}
clone_plugin https://github.com/zsh-users/zsh-autosuggestions          "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_plugin https://github.com/zsh-users/zsh-history-substring-search "$ZSH_CUSTOM/plugins/zsh-history-substring-search"
clone_plugin https://github.com/zsh-users/zsh-syntax-highlighting      "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
clone_plugin https://github.com/MichaelAquilina/zsh-you-should-use     "$ZSH_CUSTOM/plugins/you-should-use"

echo "==> mackup restore"
cp "$REPO_DIR/.mackup.cfg" "$HOME/.mackup.cfg"
mackup restore

echo "==> .macos system preferences"
./.macos

cat <<'EOF'

Bootstrap complete. Manual followups (see README):
  - Add IsoKeyboardRemap.workflow to Login Items
  - Sign into VS Code with GitHub for Settings Sync
  - Walk the manual macOS checklist (iCloud, wallpaper, screen saver, etc.)
  - Log out / restart to apply all .macos changes
EOF
