#!/usr/bin/env bash
#
# install-packages.sh — Interactive installer for WehttamSnaps packages
#
# Purpose:
# - Installs core packages (packages/core-packages.txt) via pacman
# - Optionally installs optional/AUR packages (packages/optional-packages-aur.txt)
# - Detects packages available in official repos vs AUR and handles them appropriately
# - Uses paru or yay if available for AUR installs; otherwise offers instructions
#
# Usage:
#   ./install-packages.sh [--core-file PATH] [--optional-file PATH] [--yes] [--dry-run]
#
# Example:
#   ./install-packages.sh --core-file packages/core-packages.txt --optional-file packages/optional-packages-aur.txt
#
set -euo pipefail

# CONFIG
REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
CORE_LIST_DEFAULT="$REPO_ROOT/packages/core-packages.txt"
OPTIONAL_LIST_DEFAULT="$REPO_ROOT/packages/optional-packages-aur.txt"
LOGFILE="${HOME}/wehttamsnaps-install-$(date +%Y%m%d-%H%M%S).log"

# Flags
DRY_RUN=0
ASSUME_YES=0
CORE_FILE="$CORE_LIST_DEFAULT"
OPTIONAL_FILE="$OPTIONAL_LIST_DEFAULT"

# Utilities
echoinfo() { printf '\033[1;34m[INFO]\033[0m %s\n' "$*"; }
echowarn() { printf '\033[1;33m[WARN]\033[0m %s\n' "$*"; }
echoerr()  { printf '\033[1;31m[ERR]\033[0m %s\n' "$*"; }
echook()   { printf '\033[1;32m[OK]\033[0m %s\n' "$*"; }

prompt_yes_no() {
  local prompt="${1:-Continue?}"
  if [[ $ASSUME_YES -eq 1 ]]; then
    return 0
  fi
  while true; do
    read -r -p "$prompt [y/N]: " yn
    case "${yn,,}" in
      y|yes) return 0 ;;
      n|no|'') return 1 ;;
      *) echo "Please answer yes or no." ;;
    esac
  done
}

# Parse args
while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=1; shift ;;
    --yes|-y) ASSUME_YES=1; shift ;;
    --core-file) CORE_FILE="$2"; shift 2 ;;
    --optional-file) OPTIONAL_FILE="$2"; shift 2 ;;
    --help|-h) echo "Usage: $0 [--core-file PATH] [--optional-file PATH] [--yes] [--dry-run]"; exit 0 ;;
    *) echoerr "Unknown arg: $1"; echo "Use --help for usage"; exit 2 ;;
  esac
done

# Ensure pacman exists
if ! command -v pacman >/dev/null 2>&1; then
  echoerr "pacman not found. This script assumes Arch Linux (or an Arch derivative)."
  exit 1
fi

# Read package file into array, ignoring empty lines & comments (#)
read_packages_from_file() {
  local file="$1"
  local -n out_array=$2
  out_array=()
  if [[ ! -f "$file" ]]; then
    echowarn "Package file not found: $file"
    return 1
  fi
  while IFS= read -r line || [[ -n "$line" ]]; do
    # Strip comments and whitespace
    line="${line%%#*}"
    line="${line##+([[:space:]])}"
    line="${line%%+([[:space:]])}"
    if [[ -n "$line" ]]; then
      out_array+=("$line")
    fi
  done < "$file"
  return 0
}

classify_packages() {
  # takes an input array $1 (name), returns arrays: avail_pkgs and aur_pkgs
  local -n in_array=$1
  local -n avail_pkgs=$2
  local -n aur_pkgs=$3

  avail_pkgs=()
  aur_pkgs=()

  echoinfo "Checking availability for ${#in_array[@]} packages..."
  for pkg in "${in_array[@]}"; do
    # Some lines in optional file might be meta comments like "- package" — ensure valid token
    pkg="$(echo "$pkg" | tr -d '[:space:]')"
    if [[ -z "$pkg" ]]; then
      continue
    fi

    # pacman -Si returns 0 if package found in repos
    if pacman -Si "$pkg" >/dev/null 2>&1; then
      avail_pkgs+=("$pkg")
    else
      aur_pkgs+=("$pkg")
    fi
  done
}

install_pacman_packages() {
  local -n pkgs=$1
  if [[ ${#pkgs[@]} -eq 0 ]]; then
    echoinfo "No pacman packages to install."
    return 0
  fi

  echoinfo "Pacman packages to install: ${#pkgs[@]}"
  printf '%s\n' "${pkgs[@]}" | sed 's/^/  - /'
  if ! prompt_yes_no "Install these via pacman now?"; then
    echowarn "Skipping pacman installation."
    return 0
  fi

  if [[ $DRY_RUN -eq 1 ]]; then
    echoinfo "(dry-run) Would run: sudo pacman -S --needed ${pkgs[*]}"
    return 0
  fi

  echoinfo "Running: sudo pacman -S --needed ${pkgs[*]}"
  sudo pacman -Syu --needed --noconfirm "${pkgs[@]}" 2>&1 | tee -a "$LOGFILE"
  echook "Pacman install finished (logged to $LOGFILE)."
}

install_aur_packages_with_helper() {
  local helper="$1"
  local -n pkgs=$2
  if [[ ${#pkgs[@]} -eq 0 ]]; then
    echoinfo "No AUR packages to install with $helper."
    return 0
  fi

  echoinfo "AUR packages to install (${#pkgs[@]}) via $helper:"
  printf '%s\n' "${pkgs[@]}" | sed 's/^/  - /'
  if ! prompt_yes_no "Install these AUR packages with $helper now?"; then
    echowarn "Skipping AUR installation with $helper."
    return 0
  fi

  if [[ $DRY_RUN -eq 1 ]]; then
    echoinfo "(dry-run) Would run: $helper -S --needed ${pkgs[*]}"
    return 0
  fi

  echoinfo "Running: $helper -S --needed ${pkgs[*]}"
  if [[ "$helper" == "paru" || "$helper" == "yay" ]]; then
    # prefer non-interactive but still safe: ask whether to use --noconfirm
    if prompt_yes_no "Use --noconfirm for $helper (will not prompt)?"; then
      $helper -S --needed --noconfirm "${pkgs[@]}" 2>&1 | tee -a "$LOGFILE"
    else
      $helper -S --needed "${pkgs[@]}" 2>&1 | tee -a "$LOGFILE"
    fi
  else
    # Unknown helper: try safe invocation
    $helper -S --needed "${pkgs[@]}" 2>&1 | tee -a "$LOGFILE"
  fi

  echook "AUR install with $helper finished (logged to $LOGFILE)."
}

offer_paru_install_instructions() {
  echowarn "No AUR helper (paru/yay) found on the system."
  echoinfo "I can provide instructions to install paru; this requires base-devel and git."
  if ! prompt_yes_no "Show install steps for paru now?"; then
    echowarn "Skipping paru instructions."
    return 1
  fi

  cat <<'INSTR'

paru install instructions (manual):
1. Ensure base-devel and git are installed:
   sudo pacman -S --needed base-devel git

2. Clone paru and build:
   git clone https://aur.archlinux.org/paru.git /tmp/paru
   cd /tmp/paru
   makepkg -si

After paru is installed, re-run this script to allow automatic AUR installs.
INSTR

  return 0
}

# MAIN FLOW
echoinfo "WehttamSnaps interactive package installer"
echoinfo "Logfile: $LOGFILE"
echo "----------------------------------------" | tee -a "$LOGFILE"

# Load core packages
core_pkgs_raw=()
if read_packages_from_file "$CORE_FILE" core_pkgs_raw; then
  echoinfo "Loaded core package list from $CORE_FILE (${#core_pkgs_raw[@]} entries)."
else
  echowarn "No core list found at $CORE_FILE. Aborting."
  exit 1
fi

# Load optional packages (if present)
optional_pkgs_raw=()
if read_packages_from_file "$OPTIONAL_FILE" optional_pkgs_raw; then
  echoinfo "Loaded optional package list from $OPTIONAL_FILE (${#optional_pkgs_raw[@]} entries)."
else
  echowarn "Optional package file not found at $OPTIONAL_FILE. Optional installs will be skipped."
fi

# Confirm updating system
if prompt_yes_no "Would you like to run 'sudo pacman -Syu' to update the system before installing?"; then
  if [[ $DRY_RUN -eq 1 ]]; then
    echoinfo "(dry-run) Would run: sudo pacman -Syu"
  else
    echoinfo "Running: sudo pacman -Syu"
    sudo pacman -Syu 2>&1 | tee -a "$LOGFILE"
  fi
fi

# Classify core packages
avail_core=()
aur_core=()
classify_packages core_pkgs_raw avail_core aur_core

echoinfo "Core packages classification complete: ${#avail_core[@]} repo / ${#aur_core[@]} AUR"
echo "  Repo: ${avail_core[*]}" | tee -a "$LOGFILE"
echo "  AUR: ${aur_core[*]}" | tee -a "$LOGFILE"

# Install repo core packages
install_pacman_packages avail_core

# Handle core AUR candidates
if [[ ${#aur_core[@]} -gt 0 ]]; then
  # detect AUR helpers
  AUR_HELPER=""
  if command -v paru >/dev/null 2>&1; then
    AUR_HELPER="paru"
  elif command -v yay >/dev/null 2>&1; then
    AUR_HELPER="yay"
  fi

  if [[ -n "$AUR_HELPER" ]]; then
    install_aur_packages_with_helper "$AUR_HELPER" aur_core
  else
    echowarn "There are core packages that are only in AUR. No AUR helper found."
    printf 'AUR-only core packages:\n'
    printf '  - %s\n' "${aur_core[@]}"
    if prompt_yes_no "Would you like instructions to install an AUR helper (paru)?"; then
      offer_paru_install_instructions
    else
      echowarn "Skipping AUR installs for core packages. You will need to install them manually."
    fi
  fi
fi

# Ask whether to proceed with optional packages
if [[ ${#optional_pkgs_raw[@]} -gt 0 ]]; then
  if prompt_yes_no "Would you like to review & optionally install optional/AUR packages now?"; then
    # classify optional packages
    avail_opt=()
    aur_opt=()
    classify_packages optional_pkgs_raw avail_opt aur_opt
    echoinfo "Optional packages classification: ${#avail_opt[@]} repo / ${#aur_opt[@]} AUR"
    if [[ ${#avail_opt[@]} -gt 0 ]]; then
      printf 'Optional repo packages:\n'
      printf '  - %s\n' "${avail_opt[@]}"
      if prompt_yes_no "Install these optional repo packages now?"; then
        install_pacman_packages avail_opt
      else
        echowarn "Skipped optional repo packages."
      fi
    else
      echoinfo "No optional repo packages found."
    fi

    # AUR optional
    if [[ ${#aur_opt[@]} -gt 0 ]]; then
      echoinfo "Optional AUR packages detected (${#aur_opt[@]}):"
      printf '  - %s\n' "${aur_opt[@]}"
      if command -v paru >/dev/null 2>&1 || command -v yay >/dev/null 2>&1; then
        AUR_HELPER="${AUR_HELPER:-$(command -v paru >/dev/null 2>&1 && echo paru || echo yay)}"
        if prompt_yes_no "Install optional AUR packages using $AUR_HELPER now?"; then
          install_aur_packages_with_helper "$AUR_HELPER" aur_opt
        else
          echowarn "Skipping optional AUR packages for now."
        fi
      else
        echowarn "No AUR helper found. You can install these manually later:"
        printf '  - %s\n' "${aur_opt[@]}"
        if prompt_yes_no "Show paru install instructions?"; then
          offer_paru_install_instructions
        fi
      fi
    fi
  else
    echowarn "Skipping optional package installation."
  fi
else
  echoinfo "No optional package file loaded; nothing to do for optional packages."
fi

# Final notes & summary
echo "----------------------------------------" | tee -a "$LOGFILE"
echoinfo "Installation run complete. Summary written to $LOGFILE"
echoinfo "What to do next:"
cat <<'NEXT' | tee -a "$LOGFILE"
- Reboot or re-login to ensure kernel modules / services are active (if required).
- Verify PipeWire is running and open qpwgraph/pavucontrol to configure audio routing.
- Launch Hyprland session and test Noctalia widgets.
- If you skipped any AUR packages, consider installing an AUR helper (paru/yay) and re-run this script.
- Review packages/optional-packages-aur.txt and install groups you want.
NEXT

echook "Done."
exit 0