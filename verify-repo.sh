#!/usr/bin/env bash
# verify-repo.sh — quick verification for wehttamsnaps/package-installer
set -euo pipefail

REPO_ROOT="$(pwd)"
BRANCH="wehttamsnaps/package-installer"
REQUIRED_FILES=(
  "packages/core-packages.txt"
  "packages/ANNOTATED_PACKAGES.md"
  "scripts/install-packages.sh"
)
OPTIONAL_DIR="packages/optional"

echoinfo(){ printf '\033[1;34m[INFO]\033[0m %s\n' "$*"; }
echowarn(){ printf '\033[1;33m[WARN]\033[0m %s\n' "$*"; }
echoerr(){ printf '\033[1;31m[ERR]\033[0m %s\n' "$*"; }

echoinfo "Current dir: $REPO_ROOT"

# Ensure branch exists locally or track remote
if git rev-parse --verify "$BRANCH" >/dev/null 2>&1; then
  echoinfo "Branch '$BRANCH' exists locally. Checking out..."
  git checkout "$BRANCH"
else
  echoinfo "Branch '$BRANCH' not found locally. Attempting to fetch and check out from origin..."
  git fetch origin "$BRANCH":"$BRANCH" || { echowarn "Branch not found on origin"; }
  git checkout "$BRANCH" || { echoerr "Unable to checkout branch $BRANCH"; exit 1; }
fi

echoinfo "Listing top-level layout (depth 2):"
if command -v tree >/dev/null 2>&1; then
  tree -a -L 2 -I '.git'
else
  find . -maxdepth 2 -type f -print | sed 's|^\./||' || true
fi

echo
echoinfo "Checking required files presence:"
missing=0
for f in "${REQUIRED_FILES[@]}"; do
  if [[ -f "$f" ]]; then
    printf "  [OK] %s\n" "$f"
  else
    printf "  [MISSING] %s\n" "$f"
    missing=$((missing+1))
  fi
done

echo
if [[ -d "$OPTIONAL_DIR" ]]; then
  echoinfo "Optional categories directory exists: $OPTIONAL_DIR"
  ls -la "$OPTIONAL_DIR" || true
else
  echowarn "Optional categories directory missing: $OPTIONAL_DIR"
fi

echo
echoinfo "Recent commits on branch '$BRANCH' (last 8):"
git --no-pager log --oneline -n 8

echo
echoinfo "Check installation script executable bit:"
if [[ -f scripts/install-packages.sh ]]; then
  ls -l scripts/install-packages.sh
else
  echowarn "scripts/install-packages.sh not found."
fi

echo
echoinfo "Check PR status (requires GitHub CLI 'gh')"
if command -v gh >/dev/null 2>&1; then
  echoinfo "Running: gh pr list --head ${GITHUB_REPOSITORY:-Crowdrocker/Hypr-Snaps}:${BRANCH}"
  gh pr list --head Crowdrocker:"$BRANCH" || echowarn "No PRs found or gh API failure"
else
  echowarn "gh CLI not installed. Use GitHub web UI to check PRs for branch $BRANCH."
fi

echo
if [[ $missing -eq 0 ]]; then
  echoinfo "Basic verification complete: all required files present (see above)."
else
  echoerr "Verification found $missing missing required files."
fi

echo
echoinfo "If you want, copy the output above and paste it here so I can help interpret results."