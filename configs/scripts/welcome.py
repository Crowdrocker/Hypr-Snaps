#!/usr/bin/env python3

import gi

gi.require_version("Gtk", "3.0")
gi.require_version("Gdk", "3.0")
from gi.repository import Gtk, Gdk, GdkPixbuf, GLib, Pango
import os
import json
import sys
import subprocess


class WelcomeWindow:
    def __init__(self):
        self.window = Gtk.Window()
        self.window.set_title("Welcome to WehttamSnaps Hyprland")
        self.window.set_default_size(800, 600)
        self.window.set_position(Gtk.WindowPosition.CENTER)
        self.window.set_resizable(False)

        # Make window explicitly non-modal
        self.window.set_modal(False)
        self.window.set_keep_above(False)
        self.window.set_focus_on_map(False)
        self.window.set_type_hint(Gdk.WindowTypeHint.NORMAL)

        # Create main container
        main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=20)
        main_box.set_margin_start(0)
        main_box.set_margin_end(0)
        main_box.set_margin_top(0)
        main_box.set_margin_bottom(30)

        # Add Welcome image
        self.add_welcome_image(main_box)

        # Add main text
        self.add_main_text(main_box)

        # Add buttons
        self.add_buttons(main_box)

        self.window.add(main_box)
        self.window.connect("destroy", self.on_window_destroy)
        self.window.show_all()

    def add_welcome_image(self, container):
        # Add Welcome image
        home_dir = os.environ.get("HOME") or os.path.expanduser("~")
        image_path = os.path.join(
            home_dir, ".config", "hypr", "assets", "images", "welcome.png"
        )

        if os.path.exists(image_path):
            try:
                pixbuf = GdkPixbuf.Pixbuf.new_from_file(image_path)
                width = pixbuf.get_width()
                height = pixbuf.get_height()
                target_width = int(800 * 0.7)
                scale_factor = target_width / width
                new_width = target_width
                new_height = int(height * scale_factor)
                pixbuf = pixbuf.scale_simple(
                    new_width, new_height, GdkPixbuf.InterpType.BILINEAR
                )

                image = Gtk.Image.new_from_pixbuf(pixbuf)
                image.set_halign(Gtk.Align.FILL)
                container.pack_start(image, False, False, 0)
            except Exception as e:
                print(f"Could not load welcome.png: {e}")

    def add_main_text(self, container):
        # Read version
        version = self.get_version()

        # Create scrollable text view
        scrolled_window = Gtk.ScrolledWindow()
        scrolled_window.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
        scrolled_window.set_size_request(-1, 400)

        text_view = Gtk.TextView()
        text_view.set_editable(False)
        text_view.set_cursor_visible(False)
        text_view.set_wrap_mode(Gtk.WrapMode.WORD)
        text_view.set_left_margin(40)
        text_view.set_right_margin(40)
        text_view.set_top_margin(20)
        text_view.set_bottom_margin(20)

        # Set font
        font_desc = Pango.FontDescription()
        font_desc.set_family("JetBrains Mono Nerd Font")
        font_desc.set_size(13 * Pango.SCALE)
        text_view.override_font(font_desc)

        buffer = text_view.get_buffer()

        # Create text content
        text_content_parts = [
            f"Welcome to WehttamSnaps Hyprland Setup v{version}\n\n",
            "A professional Arch Linux Hyprland configuration optimized for photography, gaming, and content creation.\n\n",
            "🚀 QUICK START\n\n",
            "This setup combines the best of multiple worlds:\n",
            "• Jakoolit's beautiful theming\n",
            "• Omarchy's efficient workflow\n",
            "• Noctalia shell (Quickshell-based)\n",
            "• Optimized for AMD RX 580\n\n",
            "Essential Shortcuts:\n",
            "• SUPER + H  →  Help Screen (Keybindings)\n",
            "• SUPER + C  →  Control Center (Noctalia)\n",
            "• SUPER + COMMA  →  Settings\n",
            "• SUPER + D  →  App Launcher\n",
            "• SUPER + ENTER  →  Terminal (Ghostty)\n",
            "• SUPER + B  →  Browser\n",
            "• SUPER + Q  →  Close Window\n\n",
            "Webapps (Quick Access):\n",
            "• SUPER + SHIFT + Y  →  YouTube\n",
            "• SUPER + SHIFT + T  →  Twitch\n",
            "• SUPER + SHIFT + D  →  Discord\n",
            "• SUPER + SHIFT + S  →  Spotify\n\n",
            "Customization:\n",
            "• SUPER + W  →  Wallpaper Selector\n",
            "• SUPER + CTRL + SPACE  →  Random Wallpaper\n",
            "• SUPER + COMMA  →  Settings Panel\n\n",
            "Gaming Mode:\n",
            "• SUPER + SHIFT + G  →  Toggle Gaming Mode\n",
            "  (Disables animations, optimizes performance)\n\n",
            "🎯 PHILOSOPHY\n\n",
            "This setup respects your workflow while providing powerful tools for:\n",
            "• Photography and image editing\n",
            "• Gaming with optimal performance\n",
            "• Streaming and content creation\n",
            "• Professional productivity\n\n",
            "Everything is customizable and documented. Make it your own!\n\n",
            "Enjoy your new environment! 🎨🎮📸\n",
        ]

        # Insert text parts
        iter_end = buffer.get_end_iter()
        for part in text_content_parts:
            buffer.insert(iter_end, part)
            iter_end = buffer.get_end_iter()

        # Insert signature
        signature_tag = buffer.create_tag("signature", scale=1.2, weight=Pango.Weight.BOLD)
        buffer.insert_with_tags(iter_end, "\n\nWehttamSnaps", signature_tag)
        iter_end = buffer.get_end_iter()

        buffer.insert(iter_end, "\n\n")
        iter_end = buffer.get_end_iter()

        # Insert clickable link for GitHub
        github_tag = buffer.create_tag(
            "github_link", foreground="#89b4fa", underline=True
        )
        buffer.insert_with_tags(iter_end, "GitHub: Crowdrocker", github_tag)
        iter_end = buffer.get_end_iter()

        buffer.insert(iter_end, " | ")
        iter_end = buffer.get_end_iter()

        # Insert clickable link for Twitch
        twitch_tag = buffer.create_tag(
            "twitch_link", foreground="#9147ff", underline=True
        )
        buffer.insert_with_tags(iter_end, "Twitch: WehttamSnaps", twitch_tag)
        iter_end = buffer.get_end_iter()

        # Connect click events
        text_view.connect("button-press-event", self.on_text_clicked)

        scrolled_window.add(text_view)
        container.pack_start(scrolled_window, True, True, 0)

    def add_buttons(self, container):
        # Create button box
        button_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=10)
        button_box.set_halign(Gtk.Align.FILL)
        button_box.set_margin_start(40)
        button_box.set_margin_end(40)

        # Dismiss Forever button
        dismiss_button = Gtk.Button(label="Dismiss Forever")
        dismiss_button.connect("clicked", self.on_dismiss_forever)
        dismiss_button.set_halign(Gtk.Align.START)
        button_box.pack_start(dismiss_button, False, False, 0)

        # Spacer
        spacer = Gtk.Box()
        button_box.pack_start(spacer, True, True, 0)

        # Close button
        close_button = Gtk.Button(label="Close")
        close_button.connect("clicked", self.on_close)
        close_button.set_halign(Gtk.Align.END)
        button_box.pack_start(close_button, False, False, 0)

        container.pack_start(button_box, False, False, 0)

    def on_dismiss_forever(self, button):
        # Create config directory
        config_dir = os.path.expanduser("~/.config/wehttamsnaps")
        os.makedirs(config_dir, exist_ok=True)

        # Write welcome.json
        welcome_config = {"dismissed": True, "timestamp": GLib.get_real_time()}

        config_file = os.path.join(config_dir, "welcome.json")
        try:
            with open(config_file, "w") as f:
                json.dump(welcome_config, f, indent=2)
            print("Welcome dismissed forever")
        except Exception as e:
            print(f"Error saving welcome config: {e}")

        Gtk.main_quit()

    def on_close(self, button):
        Gtk.main_quit()

    def on_text_clicked(self, text_view, event):
        """Handle clicks on text view to open links"""
        if event.button == 1:  # Left click
            x, y = text_view.window_to_buffer_coords(
                Gtk.TextWindowType.WIDGET, int(event.x), int(event.y)
            )
            iter_result = text_view.get_iter_at_location(x, y)

            if iter_result[0]:
                iter_pos = iter_result[1]
                tags = iter_pos.get_tags()

                for tag in tags:
                    if hasattr(tag, "get_property"):
                        tag_name = tag.get_property("name")
                        if tag_name == "github_link":
                            subprocess.Popen(["xdg-open", "https://github.com/Crowdrocker"])
                            return True
                        elif tag_name == "twitch_link":
                            subprocess.Popen(["xdg-open", "https://twitch.tv/WehttamSnaps"])
                            return True

        return False

    def get_version(self):
        """Read version from VERSION file"""
        home_dir = os.environ.get("HOME") or os.path.expanduser("~")
        version_path = os.path.join(home_dir, ".config", "wehttamsnaps", "VERSION")

        try:
            with open(version_path, "r") as f:
                version = f.read().strip()
                return version
        except Exception:
            return "1.0.0"

    def on_window_destroy(self, widget):
        """Handle window destruction"""
        Gtk.main_quit()


def should_show_welcome():
    """Check if welcome should be shown"""
    config_file = os.path.expanduser("~/.config/wehttamsnaps/welcome.json")

    if not os.path.exists(config_file):
        return True

    try:
        with open(config_file, "r") as f:
            config = json.load(f)
        return not config.get("dismissed", False)
    except:
        return True


def play_jarvis_startup():
    """Play J.A.R.V.I.S. startup sound"""
    sound_file = os.path.expanduser("~/.config/hypr/sounds/jarvis-startup.mp3")
    if os.path.exists(sound_file):
        try:
            subprocess.Popen(["mpv", "--no-video", sound_file], 
                           stdout=subprocess.DEVNULL, 
                           stderr=subprocess.DEVNULL)
        except:
            pass


def main():
    if len(sys.argv) > 1 and sys.argv[1] == "--force":
        pass
    elif not should_show_welcome():
        print("Welcome has been dismissed")
        return

    # Play J.A.R.V.I.S. startup sound
    play_jarvis_startup()

    # Set up CSS
    css_provider = Gtk.CssProvider()
    css_data = """
    * {
        font-family: "JetBrains Mono Nerd Font", monospace;
    }

    window {
        background: rgba(17, 17, 27, 1.0);
        color: #cdd6f4;
    }

    label {
        color: #cdd6f4;
    }

    textview {
        background: rgba(17, 17, 27, 1.0);
        color: #cdd6f4;
        border: none;
    }

    textview text {
        background: rgba(17, 17, 27, 1.0);
        color: #cdd6f4;
    }

    button {
        background: rgba(137, 180, 250, 1.0);
        color: #1e1e2e;
        border: none;
        border-radius: 8px;
        padding: 8px 16px;
        font-weight: bold;
        min-width: 100px;
        min-height: 32px;
    }

    button:hover {
        background: rgba(116, 199, 236, 1.0);
    }

    scrolledwindow {
        border: none;
        background: rgba(17, 17, 27, 1.0);
    }
    """

    css_provider.load_from_data(css_data.encode())

    screen = Gdk.Screen.get_default()
    Gtk.StyleContext.add_provider_for_screen(
        screen, css_provider, Gtk.STYLE_PROVIDER_PRIORITY_USER
    )

    WelcomeWindow()
    Gtk.main()


if __name__ == "__main__":
    main()