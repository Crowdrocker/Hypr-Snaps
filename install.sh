#!/usr/bin/env bash
# install.sh — bootstrap script to scaffold repo structure and create branches
# Runs locally; will not push remote branches automatically.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
CONFIG_TARGET="$HOME/.config/wehttamsnaps"

echo "WehttamSnaps bootstrap installer"
echo "- Repo root: $REPO_ROOT"
echo "- Target config: $CONFIG_TARGET"
echo

usage(){
  cat <<EOF
Usage: $0 [--bootstrap] [--create-branches] [--symlink]
  --bootstrap        Create recommended folders and sample files locally
  --create-branches  Create branch skeletons locally (requires git)
  --symlink          Symlink configs to ~/.config/wehttamsnaps (careful!)
EOF
  exit 1
}

if [[ "$#" -eq 0 ]]; then
  usage
fi

while [[ $# -gt 0 ]]; do
  case "$1" in
    --bootstrap)
      echo "Creating folders..."
      mkdir -p "$REPO_ROOT"/{configs/{hyprland/conf.d,noctalia/widgets,quickshell-apps,sounds,webapps},scripts,docs,wallpapers,themes}
      cp -n "$REPO_ROOT"/logo.txt "$REPO_ROOT"/configs/logo.txt || true
      echo "Bootstrap complete."
      shift
      ;;
    --create-branches)
      if ! command -v git >/dev/null 2>&1; then
        echo "git not found"
        exit 1
      fi
      pushd "$REPO_ROOT" >/dev/null
      for br in develop wehttamsnaps-theme wehttamsnaps-widgets wallpapers jarvis-sounds; do
        if git show-ref --verify --quiet "refs/heads/$br"; then
          echo "Branch exists: $br"
        else
          git checkout -b "$br"
          git commit --allow-empty -m "chore: create $br branch"
          git checkout - # return to previous
        fi
      done
      popd >/dev/null
      echo "Branches created."
      shift
      ;;
    --symlink)
      echo "Creating symlink: $CONFIG_TARGET -> $REPO_ROOT/configs"
      mkdir -p "$(dirname "$CONFIG_TARGET")"
      if [[ -e "$CONFIG_TARGET" && ! -L "$CONFIG_TARGET" ]]; then
        echo "Warning: $CONFIG_TARGET exists and is not a symlink. Backing up to ${CONFIG_TARGET}.bak"
        mv "$CONFIG_TARGET" "${CONFIG_TARGET}.bak"
      fi
      ln -sfn "$REPO_ROOT/configs" "$CONFIG_TARGET"
      echo "Symlink done."
      shift
      ;;
    *)
      usage
      ;;
  esac
done

echo "Done. Review configs, then run 'make install' or follow docs/INSTALL.md"
