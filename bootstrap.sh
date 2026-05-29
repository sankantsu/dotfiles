#!/usr/bin/env bash
set -euo pipefail

YADM_URL="https://github.com/yadm-dev/yadm/raw/bbb58e6625de5d934fd49b4b81c1981e137e3057/yadm"
DOTFILES_REPO="https://github.com/sankantsu/dotfiles.git"
YADM_BIN="$HOME/bin/yadm"
DOTFILES_BRANCH="main"

while getopts "b:" opt; do
    case "$opt" in
        b) DOTFILES_BRANCH="$OPTARG" ;;
        *) echo "Usage: $0 [-b branch]" >&2; exit 1 ;;
    esac
done

echo "==> Bootstrap: setting up dev environment"

# Ensure ~/bin exists and is in PATH
if [ ! -d "$HOME/bin" ]; then
    echo "==> Creating ~/bin"
    mkdir -p "$HOME/bin"
fi
export PATH="$HOME/bin:$PATH"

# Install yadm
if [ -x "$YADM_BIN" ]; then
    echo "==> yadm already installed at $YADM_BIN, skipping"
else
    echo "==> Installing yadm to $YADM_BIN"
    curl -fLo "$YADM_BIN" "$YADM_URL"
    chmod a+x "$YADM_BIN"
    echo "==> yadm installed"
fi

# Clone dotfiles with yadm
if "$YADM_BIN" status &>/dev/null; then
    echo "==> dotfiles already managed by yadm, skipping clone"
else
    echo "==> Cloning dotfiles from $DOTFILES_REPO (branch: $DOTFILES_BRANCH)"
    "$YADM_BIN" clone --branch "$DOTFILES_BRANCH" "$DOTFILES_REPO"
fi

# Configure sparse-checkout to exclude README.md and bootstrap.sh
echo "==> Configuring sparse-checkout"
"$YADM_BIN" sparse-checkout init
"$YADM_BIN" sparse-checkout set --no-cone '/*' '!README.md' '!bootstrap.sh'

echo "==> Bootstrap complete!"
