# Install & Repo Structure (scaffold)

Overview:
- This document describes the folder layout and the recommended commands to scaffold the repository.

Top-level structure
- README.md
- logo.txt
- install.sh                # scaffolding / install helper (interactive)
- package.list.txt          # curated core + optional lists
- docs/
  - INSTALL.md
  - QUICKSTART.md
- configs/
  - hyprland/
    - hypr.conf
    - conf.d/
      - 00-base.conf
      - 10-rules.conf
      - 20-work.conf
      - 30-gaming.conf
      - 99-overrides.conf
  - noctalia/
    - config.yaml
    - widgets/
      - widget-template/
        - manifest.json
        - widget.sh
        - style.css
      - work/
      - gaming/
  - quickshell-apps/
    - welcome.py
    - settings.sh
  - sounds/
    - jarvis-startup.mp3
    - jarvis-shutdown.mp3
    - jarvis-notification.mp3
  - webapps/
    - twitch.webapp
    - youtube.webapp
  - scripts/
    - create_widget.sh
    - toggle-gamemode.sh
    - audio-setup.sh
    - save-configs.sh

Branch strategy
- main
- develop
- wehttamsnaps-theme
- wehttamsnaps-widgets
- wallpapers
- jarvis-sounds
- docs

Install process (high level)
1. Clone repo.
2. Run ./install.sh --bootstrap
   - Optional: create branches automatically.
   - Create symlinks from configs/ -> ~/.config/wehttamsnaps/
3. Review package.list.txt and install core packages manually or via install script.
4. Log into Hyprland, validate Noctalia bar, and test welcome.py.
