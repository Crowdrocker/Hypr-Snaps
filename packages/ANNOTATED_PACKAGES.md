# WehttamSnaps — Curated package lists (core / optional) with annotations

This document explains the split between the "core" packages (recommended to install first)
and the "optional/AUR" packages (install later as needed). Use core to bootstrap a stable,
small Hyprland + Noctalia system optimized for gaming, streaming, and photography.

Quick summary
- Core: minimal, tested essentials for Wayland/Hyprland, audio routing (PipeWire), streaming (OBS), gaming runtimes (lib32 libs, gamemode, gamescope), Noctalia shell, and useful CLI tooling.
- Optional/AUR: large creative apps, multiple browsers, KDE-specific theming, hardware-specific tools, and AUR-only packages. Install these after the base is stable.

Why these choices
- Prefer open-source AMD stack for Wayland: mesa + xf86-video-amdgpu and lib32 Vulkan layers make RX580 the smoother choice for Hyprland.
- Noctalia/Quickshell chosen as your shell/bar. To avoid duplication/conflicts, Waybar and its modules were moved to optional.
- PipeWire + wireplumber + pavucontrol + qpwgraph mimic Windows Voicemeeter workflows and offer advanced audio routing for streaming.
- OBS + wf-recorder + wf/grim/slurp + mpv give you recording, streaming and playback capability immediately.
- Gamemode and Gamescope provide performance profiles and display compositor for games.
- Many AUR packages are powerful but require maintenance — keep them optional until you're ready.

How to install the core list (example)
1. Save `packages/core-packages.txt` locally.
2. Update the system and install:
   - sudo pacman -Syu
   - sudo pacman -S --needed - < packages/core-packages.txt
   (Or iterate through the file with xargs, or use a small script; pacman does not handle AUR.)

AUR packages
- Use an AUR helper (paru or yay) to install items listed in `packages/optional-packages-aur.txt`.
- Example: paru -S <package-name>
- Be careful with -git and -bin packages; read PKGBUILDs when possible.

Recommended next steps after installing core
- Boot into Hyprland, test Noctalia bar and the welcome app.
- Configure PipeWire and use qpwgraph to create virtual sinks for streaming (game, mic, browser).
- Install `mesa-vulkan-drivers` and confirm `vulkaninfo` works (allows Proton & Vulkan games).
- Add optional creative apps (darktable, rawtherapee, gimp) only if you need them — they are large.

Notes & tips
- If you plan to use Flatpak, keep xdg-desktop-portal and portal backends installed (they're in core).
- If you run into proprietary driver needs for NVIDIA, rethink GPU recommendation: RX580 is usually simpler with Wayland.
- Keep fonts limited to essentials to save disk space on the 120GB Linux SSD; install extras on the 1TB games drive if needed.
- For AUR maintenance: consider a separate branch (wehttamsnaps-theme / jarvis-sounds) and track large assets outside the root (LFS or releases).

If you'd like:
- I can generate a small interactive install script that installs core packages and prompts about each optional group (browsers, creative apps, gaming extras, AUR-only).
- I can produce a commit-ready patch (three files in /packages/) that you can push to your Hypr-Snaps repo.