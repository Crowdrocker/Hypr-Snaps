# Optional packages — categories & usage

This folder contains split optional/AUR package lists grouped by category. Install categories selectively to keep your Linux SSD lean.

Files and purpose:
- browser-packages.txt — extra browsers (AUR entries included)
- photography-packages.txt — photo editing, RAW processing, image tools
- productivity-packages.txt — office & messaging apps
- kde-theme-packages.txt — KDE theming and SDDM theme (only if you use KDE components)
- gaming-packages.txt — Lutris, Proton / Proton GE, Heroic
- audio-packages.txt — JACK/DSP and advanced audio tooling
- hardware-packages.txt — hardware control and thermal/fan tooling (install carefully)
- devops-packages.txt — developer and system utilities
- fonts-packages.txt — additional fonts & icon themes
- aur-helpers-and-extras.txt — AUR helpers and selected AUR-only extras

How to install a category with the interactive installer
1. Use the main script you already have (scripts/install-packages.sh).
2. To install a specific category, pass it as the optional file:

   ./scripts/install-packages.sh --optional-file packages/optional/gaming-packages.txt

3. Or run the script interactively with the default optional file and follow prompts:

   ./scripts/install-packages.sh

Tips
- AUR packages require an AUR helper (paru/yay). The installer will prompt or provide instructions if none are found.
- Install hardware-packages.txt only after confirming compatibility with your motherboard/GPU and reading each tool's docs.
- For photography apps, consider installing them on the larger 1TB drive if disk space on the 120GB Linux SSD is limited.
- You can merge multiple category files when calling the installer by concatenating them or by pointing to a combined file.