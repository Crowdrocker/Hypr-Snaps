PR Title:
Add interactive package installer and curated package lists

PR Body:
Summary
Adds an interactive package installer script and curated package lists to bootstrap the WehttamSnaps Hyprland setup.

What this PR contains
- scripts/install-packages.sh
  - Interactive installer for core and optional packages
  - Category chooser for optional packages (supports fzf multi-select + numbered-menu fallback)
  - Classifies packages between official repos and AUR
  - Uses paru/yay if available for AUR packages; provides instructions if not
  - Supports --choose, --optional-file, --dry-run, and --yes modes
  - Builds a temporary optional package list from packages/optional/* selections
  - Logs actions to ~/wehttamsnaps-install-YYYYMMDD-HHMMSS.log
- packages/core-packages.txt
  - Curated minimal core package list required to run Hyprland + Noctalia + streaming/gaming basics
- packages/optional/*
  - Split category files for optional packages (browser, photography, gaming, audio, hardware, devops, fonts, etc.)
- packages/ANNOTATED_PACKAGES.md
  - Rationale and guidance for core vs optional lists

Motivation
This PR adds a repeatable, safe way to bootstrap the workstation with a minimal core set and opt-in categories for extras. It reduces manual errors, documents package decision rationale, and helps new contributors replicate the environment.

How to run locally (recommended)
1. Checkout the branch (if not already):
   git fetch origin
   git checkout -b wehttamsnaps/package-installer origin/wehttamsnaps/package-installer

2. Make script executable:
   chmod +x scripts/install-packages.sh

3. Dry-run a category selection to verify behavior (no changes):
   ./scripts/install-packages.sh --choose --dry-run

4. Run interactive installer (choose categories when prompted):
   ./scripts/install-packages.sh --choose

Notes
- AUR packages require an AUR helper (paru or yay). The script will prompt and/or provide instructions to install paru.
- For a better interactive experience install fzf (the script will use fzf for multi-select with previews).
- The core list is intentionally conservative to avoid filling the small Linux SSD. Install large creative suites on the 1TB drive if space is an issue.

Suggested labels
- enhancement
- tooling
- docs
- needs-review

Suggested reviewers
- @Crowdrocker (maintainer)
- (Add any collaborators you want to review shell scripts or packaging choices)

Related issues
- (link any existing issues or roadmaps)




Reviewer checklist — WehttamSnaps package installer

Before merging
- [ ] Confirm branch: wehttamsnaps/package-installer
- [ ] Confirm PR targets the intended base branch (main or develop)
- [ ] Confirm commit message style and summary are acceptable

Code review
- [ ] scripts/install-packages.sh
  - [ ] No obvious shell syntax errors (run shellcheck manually if desired)
  - [ ] Reasonable use of set -euo pipefail and safe prompt defaults
  - [ ] Proper handling of --dry-run and --yes flags
  - [ ] No harmful unconditional sudo commands (script requires explicit user consent)
  - [ ] Logging to $HOME is acceptable and log file naming is clear
  - [ ] Temporary files are properly cleaned up on exit
  - [ ] fzf usage is guarded (fallback present if fzf missing)
  - [ ] classify_packages guard handles comments/annotations reliably
- [ ] packages/core-packages.txt
  - [ ] Confirm each core package is intended (no accidental big packages)
  - [ ] Confirm essential dependencies such as mesa or other GPU libs are available
- [ ] packages/optional/* category files
  - [ ] Categories are sensible and split by intent (browser, photography, gaming, audio, hardware, devops, fonts, aur-helpers)
  - [ ] No duplication across categories (or duplication is intentional)
- [ ] packages/ANNOTATED_PACKAGES.md
  - [ ] Rationale for core/optional choices is clear and accurate

Functional testing (recommended)
- [ ] On a test machine or VM (Arch or Arch-derivative):
  - [ ] Run: ./scripts/install-packages.sh --choose --dry-run
    - [ ] fzf selection appears if fzf is installed
    - [ ] Numbered menu works when fzf is not installed
  - [ ] Run a non-destructive update prompt: ./scripts/install-packages.sh --choose (decline sudo update)
  - [ ] Confirm that temporary optional file is built in /tmp and removed after run
  - [ ] For a small set (pick 1-2 lightweight packages), run with --choose and allow pacman to install (observe logs)
  - [ ] If AUR helper present, test AUR install path by adding a known AUR-only small package to a category (or use --dry-run)

Acceptance criteria
- [ ] Installer runs without fatal errors on at least one test machine
- [ ] Category multi-select builds expected optional package list
- [ ] Repo vs AUR classification is correct for sample packages
- [ ] The installer prompts for confirm before performing installs
- [ ] Documentation (ANNOTATED_PACKAGES.md) answers initial questions about package placement

Security & safety notes
- The script runs pacman and AUR helpers. Reviewers should verify no untrusted remote code is executed silently.
- The script uses sudo for pacman actions. Confirm maintainers are comfortable with interactive sudo in this workflow.
- AUR - GitHub runners or CI should not auto-run AUR installs.

Post-merge tasks
- [ ] Add a short HOWTO in docs/ for "How to run the installer"
- [ ] Optionally add CI checks (shellcheck, shfmt) to validate scripts on PRs
- [ ] Add a link in README.md pointing to packages/ and instructions to use the installer







