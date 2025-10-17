#!/usr/bin/env bash
#
# scripts/install-packages.sh
# Interactive installer for WehttamSnaps packages with category multi-select
#
# Features:
# - Installs core packages (packages/core-packages.txt) via pacman
# - Lets you pick optional category files from packages/optional/ (multi-select)
# - Concatenates selected categories into a temp file and installs them interactively
# - Detects AUR vs repo packages and uses paru/yay if available (or offers instructions)
# - Supports --dry-run and --yes
#
# Usage:
#   ./scripts/install-packages.sh [--core-file PATH] [--optional-file PATH|--choose] [--yes] [--dry-run]
#   ./scripts/install-packages.sh --choose   # choose categories interactively
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")"/.. && pwd)"
CORE_LIST_DEFAULT="$REPO_ROOT/packages/core-packages.txt"
OPTIONAL_DIR_DEFAULT="$REPO_ROOT/packages/optional"
LOGFILE="${HOME}/wehttamsnaps-install-$(date +%Y%m%d-%H%M%S).log"

DRY_RUN=0
ASSUME_YES=0
CORE_FILE="$CORE_LIST_DEFAULT"
OPTIONAL_FILE=""
CHOOSE_CATEGORIES=0

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

usage() {
  cat <<EOF
Usage: $0 [--core-file PATH] [--optional-file PATH] [--choose] [--yes] [--dry-run] [--help]
  --core-file PATH     Use a different core package list file
  --optional-file PATH Use an optional package file directly (overrides --choose)
  --choose             Interactively choose categories from packages/optional/ (fzf or numbered menu)
  --yes, -y            Assume yes to all prompts
  --dry-run            Print actions but don't install
  --help               Show this help
EOF
  exit 1
}

# Parse args
while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=1; shift ;;
    --yes|-y) ASSUME_YES=1; shift ;;
    --core-file) CORE_FILE="$2"; shift 2 ;;
    --optional-file) OPTIONAL_FILE="$2"; shift 2 ;;
    --choose) CHOOSE_CATEGORIES=1; shift ;;
    --help|-h) usage ;;
    *) echoerr "Unknown arg: $1"; usage ;;
  esac
done

if ! command -v pacman >/dev/null 2>&1; then
  echoerr "pacman not found. This script assumes Arch Linux or derivative."
  exit 1
fi

# Read a package file into array (strips comments & blanks)
read_packages_from_file() {
  local file="$1"
  local -n out_array=$2
  out_array=()
  if [[ ! -f "$file" ]]; then
    return 1
  fi
  while IFS= read -r line || [[ -n "$line" ]]; do
    line="${line%%#*}"
    line="${line##+([[:space:]])}"
    line="${line%%+([[:space:]])}"
    if [[ -n "$line" ]]; then
      out_array+=("$line")
    fi
  done < "$file"
  return 0
}

# Classify packages into repo vs AUR
classify_packages() {
  local -n in_array=$1
  local -n avail_pkgs=$2
  local -n aur_pkgs=$3

  avail_pkgs=()
  aur_pkgs=()

  echoinfo "Checking availability for ${#in_array[@]} packages..."
  for pkg in "${in_array[@]}"; do
    pkg="${pkg%%[*}" # guard against stray annotations
    pkg="$(echo "$pkg" | xargs)"
    [[ -z "$pkg" ]] && continue
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
    echoinfo "(dry-run) sudo pacman -S --needed ${pkgs[*]}"
    return 0
  fi

  sudo pacman -Syu --needed "${pkgs[@]}"
  echook "Pacman install finished."
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
    echoinfo "(dry-run) $helper -S --needed ${pkgs[*]}"
    return 0
  fi

  if [[ "$helper" == "paru" || "$helper" == "yay" ]]; then
    if prompt_yes_no "Use --noconfirm for $helper (will not prompt)?"; then
      $helper -S --needed --noconfirm "${pkgs[@]}"
    else
      $helper -S --needed "${pkgs[@]}"
    fi
  else
    $helper -S --needed "${pkgs[@]}"
  fi

  echook "AUR install with $helper finished."
}

offer_paru_install_instructions() {
  echowarn "No AUR helper (paru/yay) found."
  if ! prompt_yes_no "Show paru install instructions?"; then
    return 1
  fi
  cat <<'INSTR'
paru install instructions:
1. sudo pacman -S --needed base-devel git
2. git clone https://aur.archlinux.org/paru.git /tmp/paru
3. cd /tmp/paru
4. makepkg -si
After paru is installed, re-run this script.
INSTR
}

# Choose categories interactively
choose_categories() {
  local dir="$OPTIONAL_DIR_DEFAULT"
  if [[ ! -d "$dir" ]]; then
    echowarn "Optional categories directory not found: $dir"
    return 1
  fi

  local files=( "$dir"/* )
  if [[ ${#files[@]} -eq 0 ]]; then
    echowarn "No category files found in $dir"
    return 1
  fi

  # fzf multi-select with preview if available
  if command -v fzf >/dev/null 2>&1; then
    echoinfo "Using fzf for category selection (multi-select). Press TAB to select multiple entries."
    local choices
    choices=$(ls "$dir" | fzf --multi --header="Select one or more categories (TAB to select) - Enter to confirm" --preview "sed -n '1,120p' \"$dir/{}\"")
    if [[ -z "$choices" ]]; then
      echowarn "No categories selected."
      return 1
    fi
    echo "$choices"
    return 0
  fi

  # Fallback: numbered menu
  echoinfo "fzf not found; using numbered menu fallback."
  local -a names
  IFS=$'\n' read -d '' -r -a names < <(ls "$dir" && printf '\0')
  for i in "${!names[@]}"; do
    printf "%3d) %s\n" $((i+1)) "${names[i]}"
  done
  printf "\nEnter numbers separated by commas (e.g. 1,3,5) or 'all': "
  read -r input
  if [[ "${input,,}" == "all" ]]; then
    printf "%s\n" "${names[@]}"
    return 0
  fi
  IFS=',' read -r -a idxs <<< "$input"
  local sel=()
  for t in "${idxs[@]}"; do
    t="$(echo "$t" | xargs)" || continue
    if [[ "$t" =~ ^[0-9]+$ ]] && (( t >= 1 && t <= ${#names[@]} )); then
      sel+=("${names[$((t-1))]}")
    fi
  done
  if [[ ${#sel[@]} -eq 0 ]]; then
    echowarn "No valid selection made."
    return 1
  fi
  printf "%s\n" "${sel[@]}"
  return 0
}

# Build the final optional file from selected categories
build_optional_from_categories() {
  local -n categories=$1
  local out_file="$2"
  : > "$out_file"
  for cat in "${categories[@]}"; do
    local path="$OPTIONAL_DIR_DEFAULT/$cat"
    if [[ -f "$path" ]]; then
      sed '/^\s*#/d;/^\s*$/d' "$path" >> "$out_file"
      echo >> "$out_file"
    else
      echowarn "Category file not found: $path"
    fi
  done
}

# MAIN FLOW
echoinfo "WehttamSnaps interactive package installer (category chooser)"
echoinfo "Logfile: $LOGFILE"

core_pkgs_raw=()
if ! read_packages_from_file "$CORE_FILE" core_pkgs_raw; then
  echoerr "Core package file not found: $CORE_FILE"
  exit 1
fi
echoinfo "Loaded core package list (${#core_pkgs_raw[@]} entries)."

temp_optional_file=""
# If user asked to choose categories
if [[ $CHOOSE_CATEGORIES -eq 1 ]]; then
  raw_choices=$(choose_categories) || { echowarn "No categories selected; skipping optional install."; raw_choices=""; }
  if [[ -n "$raw_choices" ]]; then
    # read into array (split by newline)
    IFS=$'\n' read -r -d '' -a selected <<< "$(printf '%s\n' "$raw_choices" && printf '\0')"
    temp_optional_file="$(mktemp /tmp/wehttamsnaps_optional.XXXXXX)"
    build_optional_from_categories selected "$temp_optional_file"
    OPTIONAL_FILE="$temp_optional_file"
    echoinfo "Built temporary optional file: $OPTIONAL_FILE"
  fi
fi

# If optional file provided directly, verify
if [[ -n "$OPTIONAL_FILE" && -f "$OPTIONAL_FILE" ]]; then
  optional_pkgs_raw=()
  read_packages_from_file "$OPTIONAL_FILE" optional_pkgs_raw || optional_pkgs_raw=()
  echoinfo "Loaded optional packages list (${#optional_pkgs_raw[@]} entries)."
else
  optional_pkgs_raw=()
fi

# Update system optionally
if prompt_yes_no "Run 'sudo pacman -Syu' to update system before installing?"; then
  if [[ $DRY_RUN -eq 1 ]]; then
    echoinfo "(dry-run) sudo pacman -Syu"
  else
    sudo pacman -Syu
  fi
fi

# Classify & install core packages
avail_core=()
aur_core=()
classify_packages core_pkgs_raw avail_core aur_core

echoinfo "Core classification: ${#avail_core[@]} repo / ${#aur_core[@]} AUR"

install_pacman_packages avail_core

# Handle core AUR packages
if [[ ${#aur_core[@]} -gt 0 ]]; then
  AUR_HELPER=""
  if command -v paru >/dev/null 2>&1; then AUR_HELPER="paru"; elif command -v yay >/dev/null 2>&1; then AUR_HELPER="yay"; fi

  if [[ -n "$AUR_HELPER" ]]; then
    install_aur_packages_with_helper "$AUR_HELPER" aur_core
  else
    echowarn "Core packages in AUR: ${aur_core[*]}"
    if prompt_yes_no "Show paru install instructions?"; then
      offer_paru_install_instructions
    fi
  fi
fi

# Optional packages flow (if any)
if [[ ${#optional_pkgs_raw[@]} -gt 0 ]]; then
  if prompt_yes_no "Proceed with optional packages installation (${#optional_pkgs_raw[@]})?"; then
    avail_opt=()
    aur_opt=()
    classify_packages optional_pkgs_raw avail_opt aur_opt

    if [[ ${#avail_opt[@]} -gt 0 ]]; then
      echoinfo "Optional repo packages: ${#avail_opt[@]}"
      install_pacman_packages avail_opt
    else
      echoinfo "No optional repo packages detected."
    fi

    if [[ ${#aur_opt[@]} -gt 0 ]]; then
      echoinfo "Optional AUR packages detected (${#aur_opt[@]}):"
      AUR_HELPER="${AUR_HELPER:-$(command -v paru >/dev/null 2>&1 && echo paru || echo yay)}"
      if [[ -n "$AUR_HELPER" ]]; then
        install_aur_packages_with_helper "$AUR_HELPER" aur_opt
      else
        echowarn "No AUR helper found. These are AUR packages:"
        printf '  - %s\n' "${aur_opt[@]}"
        if prompt_yes_no "Show paru install instructions?"; then
          offer_paru_install_instructions
        fi
      fi
    fi
  else
    echowarn "Skipped optional packages installation."
  fi
else
  echoinfo "No optional packages queued for installation."
fi

echo "----------------------------------------"
echoinfo "Run complete. Log: $LOGFILE"
echoinfo "Next steps: verify PipeWire, test Noctalia, and reboot if kernel updates applied."
echook "Done."

# Cleanup temp optional file
if [[ -n "$temp_optional_file" && -f "$temp_optional_file" ]]; then
  rm -f "$temp_optional_file"
fi

exit 0