# Quickstart — Getting running with WehttamSnaps Hyprland setup

1. Clone:
   - git clone https://github.com/Crowdrocker/Hypr-Snaps.git
   - cd Hypr-Snaps

2. Bootstrap repository:
   - ./install.sh --bootstrap

3. Create local branches (optional):
   - ./install.sh --create-branches

4. Symlink configs (optional, careful):
   - ./install.sh --symlink

5. Install packages:
   - Review packages/package.list.txt and install core packages with pacman/paru.
   - Example: sudo pacman -Syu - < packages/core.list (or use a helper script)

6. Start Hyprland:
   - Ensure your display manager / session is configured to start Hyprland.
   - On first login, run the welcome app:
     - python3 configs/quickshell-apps/welcome.py

7. Add widgets:
   - ./scripts/create_widget.sh mywidget "My widget description"

8. Audio:
   - Run configs/scripts/audio-setup.sh (to create virtual sinks and layout for qpwgraph)