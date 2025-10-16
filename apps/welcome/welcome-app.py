#!/usr/bin/env python3

# ╦ ╦┌─┐┬ ┬┌┬┐┌┬┐┌─┐┌┬┐╔═╗┌┐┌┌─┐┌─┐┌─┐
# ║║║├┤ ├─┤ │  │ ├─┤│││╚═╗│││├─┤├─┘└─┐
# ╚╩╝└─┘┴ ┴ ┴  ┴ ┴ ┴┴ ┴╚═╝┘└┘┴ ┴┴  └─┘
#
# Welcome App for WehttamSnaps Hyprland Setup
# GitHub: https://github.com/Crowdrocker/Hypr-Snaps
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import gi
gi.require_version("Gtk", "3.0")
gi.require_version("Gdk", "3.0")
from gi.repository import Gtk, Gdk, GdkPixbuf, GLib, Pango
import os
import json
import sys


class WelcomeWindow:
    def __init__(self):
        self.window = Gtk.Window()
        self.window.set_title("Welcome to WehttamSnaps Hyprland Setup")
        self.window.set_default_size(900, 700)
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
        image_path = os.path.join(home_dir, ".config", "wehttamsnaps", "assets", "icon.png")

        if os.path.exists(image_path):
            try:
                pixbuf = GdkPixbuf.Pixbuf.new_from_file(image_path)
                width = pixbuf.get_width()
                height = pixbuf.get_height()
                target_width = int(900 * 0.4)
                scale_factor = target_width / width
                new_width = target_width
                new_height = int(height * scale_factor)
                pixbuf = pixbuf.scale_simple(new_width, new_height, GdkPixbuf.InterpType.BILINEAR)

                image = Gtk.Image.new_from_pixbuf(pixbuf)
                image.set_halign(Gtk.Align.FILL)
                container.pack_start(image, False, False, 0)
            except Exception as e:
                print(f"Could not load icon.png: {e}")

    def add_main_text(self, container):
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
        font_desc.set_family("Inter")
        font_desc.set_size(12 * Pango.SCALE)
        text_view.override_font(font_desc)

        buffer = text_view.get_buffer()

        # Create text content
        text_content_parts = [
            "Welcome to WehttamSnaps Hyprland Setup!\n\n",
            "This is a complete Arch Linux Hyprland configuration optimized for photography, gaming, and streaming.\n\n",
            "🚀 QUICK START\n\n",
            "Essential Shortcuts:\n",
            "• SUPER + SPACE  →  Application Launcher (Noctalia)\n",
            "• SUPER + S  →  Control Center\n",
            "• SUPER + COMMA  →  Settings\n",
            "• SUPER + ENTER  →  Terminal (Ghostty)\n",
            "• SUPER + B  →  Browser\n",
            "• SUPER + F  →  File Manager\n",
            "• SUPER + Q  →  Close Window\n",
            "• SUPER + L  →  Lock Screen\n\n",
            "Customization:\n",
            "• SUPER + CTRL + SPACE  →  Cycle Wallpapers\n",
            "• SUPER + CTRL + D  →  Toggle Dark Mode\n",
            "• SUPER + V  →  Clipboard History\n",
            "• SUPER + C  →  Calculator\n\n",
            "Gaming & Streaming:\n",
            "• SUPER + G  →  Toggle Gaming Mode\n",
            "• SUPER + SHIFT + S  →  Screenshot\n",
            "• SUPER + SHIFT + R  →  Screen Recording\n\n",
            "🎨 FEATURES\n\n",
            "• Noctalia Shell - Beautiful, minimal desktop shell\n",
            "• Material Design 3 color schemes with Matugen\n",
            "• AMD GPU optimizations for RX 580\n",
            "• PipeWire audio with advanced routing\n",
            "• J.A.R.V.I.S. sound integration\n",
            "• Custom keybindings and workflows\n\n",
            "📚 DOCUMENTATION\n\n",
            "For complete documentation, keybindings, and guides:\n",
            "• GitHub: https://github.com/Crowdrocker/Hypr-Snaps\n",
            "• Press SUPER + H for help screen\n",
            "• Check ~/.config/hypr/ for configuration files\n\n",
            "🎮 GAMING SETUP\n\n",
            "Your gaming drive is mounted at:\n",
            "/run/media/wehttamsnaps/LINUXDRIVE-1\n\n",
            "Gaming optimizations are enabled:\n",
            "• Gamemode for performance\n",
            "• AMD GPU optimizations\n",
            "• Vulkan and DXVK support\n",
            "• Steam, Lutris, and Heroic ready\n\n",
            "Enjoy your new setup! 🎉\n\n",
        ]

        # Insert text parts
        iter_end = buffer.get_end_iter()
        for part in text_content_parts:
            buffer.insert(iter_end, part)
            iter_end = buffer.get_end_iter()

        # Insert signature
        signature_tag = buffer.create_tag("signature", scale=1.3, weight=Pango.Weight.BOLD)
        buffer.insert_with_tags(iter_end, "WehttamSnaps", signature_tag)
        iter_end = buffer.get_end_iter()

        buffer.insert(iter_end, "\n\n")
        iter_end = buffer.get_end_iter()

        # Insert clickable links
        github_tag = buffer.create_tag("github_link", foreground="#8A2BE2", underline=True)
        buffer.insert_with_tags(iter_end, "GitHub", github_tag)
        iter_end = buffer.get_end_iter()

        buffer.insert(iter_end, " • ")
        iter_end = buffer.get_end_iter()

        twitch_tag = buffer.create_tag("twitch_link", foreground="#9146FF", underline=True)
        buffer.insert_with_tags(iter_end, "Twitch", twitch_tag)
        iter_end = buffer.get_end_iter()

        buffer.insert(iter_end, " • ")
        iter_end = buffer.get_end_iter()

        youtube_tag = buffer.create_tag("youtube_link", foreground="#FF0000", underline=True)
        buffer.insert_with_tags(iter_end, "YouTube", youtube_tag)

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
        dismiss_button = Gtk.Button(label="Don't Show Again")
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
                            os.system("xdg-open https://github.com/Crowdrocker/Hypr-Snaps &")
                            return True
                        elif tag_name == "twitch_link":
                            os.system("xdg-open https://twitch.tv/WehttamSnaps &")
                            return True
                        elif tag_name == "youtube_link":
                            os.system("xdg-open https://youtube.com/@WehttamSnaps &")
                            return True

        return False

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


def main():
    if len(sys.argv) > 1 and sys.argv[1] == "--force":
        # Force show welcome
        pass
    elif not should_show_welcome():
        print("Welcome has been dismissed")
        return

    # Set up CSS
    css_provider = Gtk.CssProvider()
    css_data = """
    * {
        font-family: "Inter", "Roboto", sans-serif;
    }

    window {
        background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
        color: #f0f0f0;
    }

    label {
        color: #f0f0f0;
    }

    textview {
        background: rgba(30, 30, 46, 0.8);
        color: #f0f0f0;
        border: none;
    }

    textview text {
        background: rgba(30, 30, 46, 0.8);
        color: #f0f0f0;
    }

    button {
        background: linear-gradient(135deg, #8A2BE2 0%, #00FFFF 100%);
        color: #ffffff;
        border: none;
        border-radius: 8px;
        padding: 10px 20px;
        font-weight: bold;
        min-width: 120px;
        min-height: 36px;
    }

    button:hover {
        background: linear-gradient(135deg, #9B3BF3 0%, #11FFFF 100%);
    }

    scrolledwindow {
        border: none;
        background: rgba(30, 30, 46, 0.8);
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