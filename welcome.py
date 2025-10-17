#!/usr/bin/env python3
"""
WehttamSnaps Welcome App (GTK3)
- Branded for WehttamSnaps
- Loads a local image from ~/.local/share/wehttamsnaps/images/welcome.png
- Optional J.A.R.V.I.S. startup sound played via `paplay` or `mpv` if available.
- Saves dismissal state at ~/.config/wehttamsnaps/welcome.json
"""
import gi
import os
import sys
import json
import subprocess
from datetime import datetime

gi.require_version("Gtk", "3.0")
gi.require_version("Gdk", "3.0")
from gi.repository import Gtk, Gdk, GdkPixbuf, GLib, Pango  # type: ignore

APP_NAME = "WehttamSnaps Welcome"
HOME = os.path.expanduser("~")
CONFIG_DIR = os.path.join(HOME, ".config", "wehttamsnaps")
ASSETS_DIR = os.path.join(HOME, ".local", "share", "wehttamsnaps")
SOUNDS_DIR = os.path.join(ASSETS_DIR, "sounds")
WELCOME_JSON = os.path.join(CONFIG_DIR, "welcome.json")
WELCOME_IMG = os.path.join(ASSETS_DIR, "images", "welcome.png")
JARVIS_START = os.path.join(SOUNDS_DIR, "jarvis-startup.mp3")


def play_startup_sound():
    # Play startup sound if available. Try paplay, then mpv.
    if not os.path.exists(JARVIS_START):
        return
    try:
        if subprocess.call(["which", "paplay"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL) == 0:
            subprocess.Popen(["paplay", JARVIS_START])
        elif subprocess.call(["which", "mpv"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL) == 0:
            subprocess.Popen(["mpv", "--no-video", JARVIS_START])
    except Exception:
        pass


class WelcomeWindow:
    def __init__(self):
        self.window = Gtk.Window()
        self.window.set_title(APP_NAME)
        self.window.set_default_size(820, 620)
        self.window.set_position(Gtk.WindowPosition.CENTER)
        self.window.set_resizable(False)
        # Window hints for Hyprland floating rules
        self.window.set_type_hint(Gdk.WindowTypeHint.DIALOG)

        main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=12)
        main_box.set_margin_start(12)
        main_box.set_margin_end(12)
        main_box.set_margin_top(12)
        main_box.set_margin_bottom(12)

        # Logo / Image
        if os.path.exists(WELCOME_IMG):
            try:
                pixbuf = GdkPixbuf.Pixbuf.new_from_file(WELCOME_IMG)
                # Scale to fit nicely
                target_width = 640
                scale = target_width / pixbuf.get_width()
                new_h = int(pixbuf.get_height() * scale)
                pixbuf = pixbuf.scale_simple(target_width, new_h, GdkPixbuf.InterpType.BILINEAR)
                image = Gtk.Image.new_from_pixbuf(pixbuf)
                main_box.pack_start(image, False, False, 0)
            except Exception as e:
                print("Could not load welcome image:", e)

        # Text area
        scrolled = Gtk.ScrolledWindow()
        scrolled.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
        scrolled.set_size_request(-1, 320)
        text_view = Gtk.TextView()
        text_view.set_editable(False)
        text_view.set_wrap_mode(Gtk.WrapMode.WORD)
        font_desc = Pango.FontDescription("Paper Mono 11")
        text_view.override_font(font_desc)
        buffer = text_view.get_buffer()

        # Insert content
        content = []
        content.append("Welcome to WehttamSnaps' Hyprland setup — quickstart & links\n\n")
        content.append("Quick actions:\n")
        content.append("• SUPER + ENTER → Ghostty terminal\n")
        content.append("• SUPER + SPACE → Noctalia launcher\n")
        content.append("• SUPER + B → Default browser / webapps\n")
        content.append("• SUPER + H → Keybind cheatsheet\n\n")
        content.append("File locations:\n")
        content.append(f"• Configs: ~/.config/wehttamsnaps/\n")
        content.append(f"• Hyprland confs: ~/.config/wehttamsnaps/hyprland/\n")
        content.append(f"• Noctalia widgets: ~/.config/wehttamsnaps/noctalia/widgets/\n\n")
        content.append("Useful commands:\n")
        content.append("• ./install.sh --apply → Bootstrap this repo into ~/.config/wehttamsnaps\n")
        content.append("• ./scripts/create_widget.sh → Create a new Quickshell widget template\n\n")
        content.append("Repo: https://github.com/Crowdrocker/Hypr-Snaps.git\n")
        buffer.set_text("".join(content))

        scrolled.add(text_view)
        main_box.pack_start(scrolled, True, True, 0)

        # Buttons
        btn_box = Gtk.Box(spacing=8)
        dismiss = Gtk.Button(label="Dismiss forever")
        dismiss.connect("clicked", self.on_dismiss)
        open_cfg = Gtk.Button(label="Open Config Folder")
        open_cfg.connect("clicked", self.on_open_config)
        close_btn = Gtk.Button(label="Close")
        close_btn.connect("clicked", self.on_close)
        btn_box.pack_start(dismiss, False, False, 0)
        btn_box.pack_start(open_cfg, False, False, 0)
        btn_box.pack_end(close_btn, False, False, 0)

        main_box.pack_start(btn_box, False, False, 0)
        self.window.add(main_box)
        self.window.connect("destroy", Gtk.main_quit)
        self.window.show_all()

    def on_dismiss(self, widget):
        os.makedirs(CONFIG_DIR, exist_ok=True)
        payload = {"dismissed": True, "ts": datetime.utcnow().isoformat()}
        with open(WELCOME_JSON, "w") as f:
            json.dump(payload, f, indent=2)
        Gtk.main_quit()

    def on_open_config(self, widget):
        # Open in default file manager; fallback to xdg-open
        folder = CONFIG_DIR if os.path.exists(CONFIG_DIR) else HOME
        subprocess.Popen(["xdg-open", folder])

    def on_close(self, widget):
        Gtk.main_quit()


def should_show():
    if not os.path.exists(WELCOME_JSON):
        return True
    try:
        with open(WELCOME_JSON, "r") as f:
            cfg = json.load(f)
        return not cfg.get("dismissed", False)
    except Exception:
        return True


def main():
    if len(sys.argv) > 1 and sys.argv[1] == "--force":
        pass
    elif not should_show():
        return

    # Play startup sound once (if available)
    play_startup_sound()
    win = WelcomeWindow()
    Gtk.main()


if __name__ == "__main__":
    main()
