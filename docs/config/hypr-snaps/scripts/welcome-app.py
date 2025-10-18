#!/usr/bin/env python3
"""
WehttamSnaps Hyprland Setup - Welcome Application
GitHub: https://github.com/Crowdrocker
"""

import gi
gi.require_version("Gtk", "3.0")
gi.require_version("Gdk", "3.0")
from gi.repository import Gtk, Gdk, GdkPixbuf, GLib, Pango
import os
import json
import sys


class WehttamSnapsWelcome:
    def __init__(self):
        self.window = Gtk.Window()
        self.window.set_title("Welcome to WehttamSnaps Setup")
        self.window.set_default_size(900, 700)
        self.window.set_position(Gtk.WindowPosition.CENTER)
        self.window.set_resizable(False)
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

        # Add WehttamSnaps logo/banner
        self.add_welcome_image(main_box)

        # Add main content
        self.add_main_text(main_box)

        # Add action buttons
        self.add_buttons(main_box)

        self.window.add(main_box)
        self.window.connect("destroy", self.on_window_destroy)
        self.window.show_all()

    def add_welcome_image(self, container):
        """Add WehttamSnaps banner image"""
        home_dir = os.path.expanduser("~")
        image_path = os.path.join(
            home_dir, ".config", "hypr-snaps", "assets", "images", "welcome-banner.png"
        )

        if os.path.exists(image_path):
            try:
                pixbuf = GdkPixbuf.Pixbuf.new_from_file(image_path)
                width = pixbuf.get_width()
                height = pixbuf.get_height()
                target_width = int(900 * 0.8)
                scale_factor = target_width / width
                new_width = target_width
                new_height = int(height * scale_factor)
                pixbuf = pixbuf.scale_simple(
                    new_width, new_height, GdkPixbuf.InterpType.BILINEAR
                )

                image = Gtk.Image.new_from_pixbuf(pixbuf)
                image.set_halign(Gtk.Align.CENTER)
                container.pack_start(image, False, False, 10)
            except Exception as e:
                print(f"Could not load welcome banner: {e}")
                # Fallback to ASCII art
                self.add_ascii_banner(container)
        else:
            self.add_ascii_banner(container)

    def add_ascii_banner(self, container):
        """Fallback ASCII banner"""
        ascii_label = Gtk.Label()
        ascii_label.set_markup(
            '<span font_family="monospace" size="10000" weight="bold" foreground="#8A2BE2">'
            ' __        __   _     _   _                    ____                        \n'
            ' \\ \\      / /__| |__ | |_| |_ __ _ _ __ ___   / ___| _ __   __ _ _ __  ___ \n'
            '  \\ \\ /\\ / / _ \\ \'_ \\| __| __/ _` | \'_ ` _ \\  \\___ \\| \'_ \\ / _` | \'_ \\/ __|\n'
            '   \\ V  V /  __/ | | | |_| || (_| | | | | | |  ___) | | | | (_| | |_) \\__ \\\n'
            '    \\_/\\_/ \\___|_| |_|\\__|\\__\\__,_|_| |_| |_| |____/|_| |_|\\__,_| .__/|___/\n'
            '                                                                  |_|        '
            '</span>'
        )
        ascii_label.set_halign(Gtk.Align.CENTER)
        container.pack_start(ascii_label, False, False, 10)

    def add_main_text(self, container):
        """Add main welcome text content"""
        version = self.get_setup_version()

        scrolled_window = Gtk.ScrolledWindow()
        scrolled_window.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
        scrolled_window.set_size_request(-1, 450)

        text_view = Gtk.TextView()
        text_view.set_editable(False)
        text_view.set_cursor_visible(False)
        text_view.set_wrap_mode(Gtk.WrapMode.WORD)
        text_view.set_left_margin(40)
        text_view.set_right_margin(40)
        text_view.set_top_margin(20)
        text_view.set_bottom_margin(20)

        font_desc = Pango.FontDescription()
        font_desc.set_family("JetBrains Mono")
        font_desc.set_size(12 * Pango.SCALE)
        text_view.override_font(font_desc)

        buffer = text_view.get_buffer()

        # Welcome content
        content = [
            f"Welcome to WehttamSnaps Hyprland Setup v{version}\n\n",
            "🎯 About This Setup\n\n",
            "This is a personalized Arch Linux Hyprland environment designed for photography, "
            "gaming, and streaming. It combines beautiful aesthetics with powerful functionality, "
            "featuring the elegant Noctalia shell and a full J.A.R.V.I.S. theme integration.\n\n",

            "⚡ Quick Start - Essential Keybindings\n\n",
            "System Controls:\n",
            "• SUPER + Space    → Application Launcher\n",
            "• SUPER + S        → Control Center (Noctalia)\n",
            "• SUPER + ,        → Settings\n",
            "• SUPER + Enter    → Terminal (Ghostty)\n",
            "• SUPER + F        → File Manager\n",
            "• SUPER + Q        → Close Window\n",
            "• SUPER + L        → Lock Screen\n\n",

            "Workflow Tools:\n",
            "• SUPER + V        → Clipboard History\n",
            "• SUPER + C        → Calculator\n",
            "• SUPER + W        → YouTube WebApp\n",
            "• SUPER + I        → Instagram WebApp\n\n",

            "Gaming & Streaming:\n",
            "• SUPER + G             → Toggle Gaming Mode\n",
            "• SUPER + Shift + S     → Toggle Streaming Mode\n",
            "• SUPER + Shift + R     → Screen Recording\n\n",

            "Customization:\n",
            "• SUPER + Ctrl + Space  → Cycle Wallpapers\n",
            "• SUPER + T             → Theme Switcher\n\n",

            "🤖 J.A.R.V.I.S. Integration\n\n",
            "This setup features a complete J.A.R.V.I.S. theme with custom sounds for system events, "
            "gaming mode activation, and streaming notifications. J.A.R.V.I.S. will greet you on startup "
            "and provide audio feedback for important events.\n\n",

            "🎨 Brand Identity\n\n",
            "Colors: Violet to Cyan gradient (#8A2BE2 → #00FFFF)\n",
            "Style: Modern, tech-focused with photographic elements\n",
            "Themes: TokyoNight, Sweet-Ambar, Flat-Remix\n\n",

            "📚 Documentation\n\n",
            "Complete guides are available in ~/.config/hypr-snaps/docs/\n",
            "• KEYBINDS.md - Full keybinding reference\n",
            "• GAMING.md - Gaming optimization guide\n",
            "• STREAMING.md - Streaming setup guide\n",
            "• AUDIO_ROUTING.md - qpwgraph setup (Voicemeter alternative)\n\n",

            "💡 Tips\n\n",
            "• Press SUPER + H to view the keybindings cheat sheet\n",
            "• Check out the custom Noctalia widgets for quick access to apps\n",
            "• Use qpwgraph for advanced audio routing (replaces Voicemeter)\n",
            "• Gaming mode automatically optimizes performance\n",
            "• All configs are modular and easy to customize\n\n",

            "🎮 Gaming Ready\n\n",
            "AMD RX 580 optimizations enabled with:\n",
            "• Gamemode integration\n",
            "• CoreCtrl for GPU management\n",
            "• LACT for fan control\n",
            "• Proton-GE configured\n",
            "• Steam launch options optimized\n\n",
        ]

        iter_end = buffer.get_end_iter()
        for part in content:
            buffer.insert(iter_end, part)
            iter_end = buffer.get_end_iter()

        # Add signature
        signature_tag = buffer.create_tag("signature", scale=1.3, weight=700)
        buffer.insert_with_tags(
            iter_end,
            "\nMade with ❤️ by Matthew (WehttamSnaps)\n",
            signature_tag
        )
        iter_end = buffer.get_end_iter()

        buffer.insert(iter_end, '"It just works!"\n\n')
        iter_end = buffer.get_end_iter()

        # Add clickable links
        github_tag = buffer.create_tag("github_link", foreground="#8A2BE2", underline=True)
        buffer.insert_with_tags(iter_end, "GitHub: Crowdrocker", github_tag)
        iter_end = buffer.get_end_iter()

        buffer.insert(iter_end, " | ")
        iter_end = buffer.get_end_iter()

        twitch_tag = buffer.create_tag("twitch_link", foreground="#00FFFF", underline=True)
        buffer.insert_with_tags(iter_end, "Twitch: WehttamSnaps", twitch_tag)
        iter_end = buffer.get_end_iter()

        buffer.insert(iter_end, " | ")
        iter_end = buffer.get_end_iter()

        youtube_tag = buffer.create_tag("youtube_link", foreground="#FF0000", underline=True)
        buffer.insert_with_tags(iter_end, "YouTube: WehttamSnaps", youtube_tag)

        # Connect click events
        text_view.connect("button-press-event", self.on_text_clicked)

        scrolled_window.add(text_view)
        container.pack_start(scrolled_window, True, True, 0)

    def add_buttons(self, container):
        """Add action buttons"""
        button_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=10)
        button_box.set_halign(Gtk.Align.FILL)
        button_box.set_margin_start(40)
        button_box.set_margin_end(40)

        # View Keybindings button
        keybinds_button = Gtk.Button(label="📋 View Keybindings")
        keybinds_button.connect("clicked", self.on_view_keybindings)
        button_box.pack_start(keybinds_button, True, True, 0)

        # Dismiss Forever button
        dismiss_button = Gtk.Button(label="✓ Dismiss Forever")
        dismiss_button.connect("clicked", self.on_dismiss_forever)
        button_box.pack_start(dismiss_button, True, True, 0)

        # Close button
        close_button = Gtk.Button(label="✕ Close")
        close_button.connect("clicked", self.on_close)
        button_box.pack_start(close_button, True, True, 0)

        container.pack_start(button_box, False, False, 0)

    def on_view_keybindings(self, button):
        """Open keybindings cheat sheet"""
        os.system("xdg-open ~/.config/hypr-snaps/docs/KEYBINDS.md &")

    def on_dismiss_forever(self, button):
        """Dismiss welcome permanently"""
        config_dir = os.path.expanduser("~/.config/hypr-snaps")
        os.makedirs(config_dir, exist_ok=True)

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
        """Close window"""
        Gtk.main_quit()

    def on_text_clicked(self, text_view, event):
        """Handle link clicks"""
        if event.button == 1:
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
                            os.system("xdg-open https://github.com/Crowdrocker &")
                            return True
                        elif tag_name == "twitch_link":
                            os.system("xdg-open https://twitch.tv/WehttamSnaps &")
                            return True
                        elif tag_name == "youtube_link":
                            os.system("xdg-open https://youtube.com/@WehttamSnaps &")
                            return True

        return False

    def get_setup_version(self):
        """Read setup version from VERSION file"""
        home_dir = os.path.expanduser("~")
        version_path = os.path.join(
            home_dir, ".config", "hypr-snaps", "VERSION"
        )

        try:
            with open(version_path, "r") as f:
                version = f.read().strip()
                return version
        except Exception as e:
            print(f"Could not read version file: {e}")
            return "1.0.0"

    def on_window_destroy(self, widget):
        """Handle window destruction"""
        Gtk.main_quit()


def should_show_welcome():
    """Check if welcome should be shown"""
    config_file = os.path.expanduser("~/.config/hypr-snaps/welcome.json")

    if not os.path.exists(config_file):
        return True

    try:
        with open(config_file, "r") as f:
            config = json.load(f)
        return not config.get("dismissed", False)
    except:
        return True


def main():
    if len(sys.argv) > 1 and sys.argv[1] == "--force":
        pass
    elif not should_show_welcome():
        print("Welcome has been dismissed")
        return

    # CSS Styling
    css_provider = Gtk.CssProvider()
    css_data = """
    * {
        font-family: "JetBrains Mono", "Nerd Font", monospace;
    }

    window {
        background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
        color: #cdd6f4;
    }

    label {
        color: #cdd6f4;
    }

    textview {
        background: rgba(26, 26, 46, 0.95);
        color: #cdd6f4;
        border: 1px solid #8A2BE2;
        border-radius: 12px;
    }

    textview text {
        background: rgba(26, 26, 46, 0.95);
        color: #cdd6f4;
    }

    button {
        background: linear-gradient(135deg, #8A2BE2 0%, #00FFFF 100%);
        color: #ffffff;
        border: none;
        border-radius: 10px;
        padding: 12px 20px;
        font-weight: bold;
        min-width: 120px;
        min-height: 40px;
        transition: all 0.3s ease;
    }

    button:hover {
        background: linear-gradient(135deg, #9d3ff5 0%, #00e6e6 100%);
        box-shadow: 0 4px 15px rgba(138, 43, 226, 0.4);
    }

    scrolledwindow {
        border: none;
        background: transparent;
    }
    """

    css_provider.load_from_data(css_data.encode())
    screen = Gdk.Screen.get_default()
    Gtk.StyleContext.add_provider_for_screen(
        screen, css_provider, Gtk.STYLE_PROVIDER_PRIORITY_USER
    )

    WehttamSnapsWelcome()
    Gtk.main()


if __name__ == "__main__":
    main()
