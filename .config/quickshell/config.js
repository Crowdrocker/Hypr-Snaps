// WehttamSnaps Quickshell Configuration
// J.A.R.V.I.S. Themed Widgets

const { Gtk, Gdk, Gio, GLib, GdkPixbuf } = imports.gi;
const { Quickshell, Widget, RoundedCorners, Hyprland, SystemTray } = imports.gi.Quickshell;

// Color scheme
const colors = {
    primary: "#8A2BE2",
    secondary: "#00FFFF",
    accent: "#FF69B4",
    background: "rgba(10, 10, 10, 0.9)",
    text: "#FFFFFF"
};

// Main Quickshell bar
const bar = Widget({
    className: "quickshell-bar",
    css: `
        background-color: ${colors.background};
        border-radius: 12px;
        margin: 10px;
        padding: 8px;
        border: 1px solid ${colors.primary};
    `,
    children: [
        // Left side - Workspaces
        workspaceWidget(),
        
        // Center - Date/Time
        clockWidget(),
        
        // Right side - System info
        systemWidget()
    ]
});

function workspaceWidget() {
    return Widget({
        className: "workspaces",
        css: `
            background: linear-gradient(45deg, ${colors.primary}, ${colors.secondary});
            border-radius: 8px;
            padding: 4px 8px;
        `,
        setup: (self) => {
            self.hook(Hyprland, (self) => {
                const workspaces = Hyprland.getWorkspaces();
                const active = Hyprland.activeWorkspace.id;
                
                self.children = workspaces.map(ws => 
                    Widget({
                        className: `workspace ${ws.id === active ? "active" : ""}`,
                        label: `${ws.id}`,
                        css: `
                            background: ${ws.id === active ? colors.accent : "transparent"};
                            color: ${colors.text};
                            padding: 4px 8px;
                            border-radius: 4px;
                            margin: 0 2px;
                        `,
                        onClick: () => Hyprland.dispatch(`workspace ${ws.id}`)
                    })
                );
            });
        }
    });
}

function clockWidget() {
    return Widget({
        className: "clock",
        setup: (self) => {
            self.update = () => {
                const now = new Date();
                self.label = now.toLocaleString('en-US', { 
                    weekday: 'short',
                    month: 'short', 
                    day: 'numeric',
                    hour: '2-digit',
                    minute: '2-digit'
                });
            };
            self.update();
            GLib.timeout_add_seconds(0, 60, () => {
                self.update();
                return true;
            });
        },
        css: `
            color: ${colors.text};
            font-size: 14px;
            font-weight: bold;
        `
    });
}

function systemWidget() {
    return Widget({
        className: "system-info",
        children: [
            cpuWidget(),
            memoryWidget(),
            volumeWidget(),
            powerWidget()
        ]
    });
}

function cpuWidget() {
    return Widget({
        className: "cpu",
        setup: (self) => {
            self.update = () => {
                const [success, stdout] = GLib.spawn_command_line_sync("top -bn1 | grep 'Cpu(s)' | awk '{print $2}'");
                if (success) {
                    const usage = parseFloat(stdout.toString());
                    self.label = `CPU: ${usage.toFixed(1)}%`;
                }
            };
            self.update();
            GLib.timeout_add_seconds(0, 2, () => {
                self.update();
                return true;
            });
        },
        css: `color: ${colors.secondary}; margin: 0 4px;`
    });
}

// Game Launcher Widget
const gameLauncher = Widget({
    className: "game-launcher",
    css: `
        background: ${colors.background};
        border: 1px solid ${colors.primary};
        border-radius: 12px;
        padding: 16px;
    `,
    children: [
        Widget({
            tagName: "label",
            label: "🎮 WehttamSnaps Game Hub",
            css: `color: ${colors.text}; font-size: 18px; font-weight: bold; margin-bottom: 12px;`
        }),
        gameButton("Steam", "steam", "Launch Steam"),
        gameButton("Lutris", "lutris", "Launch Lutris"),
        gameButton("Heroic", "heroic", "Launch Heroic"),
        gameButton("Discord", "discord", "Launch Discord")
    ]
});

function gameButton(name, command, tooltip) {
    return Widget({
        tagName: "button",
        label: name,
        tooltip: tooltip,
        onClick: () => GLib.spawn_command_line_async(command),
        css: `
            background: linear-gradient(45deg, ${colors.primary}, ${colors.accent});
            color: ${colors.text};
            border: none;
            border-radius: 8px;
            padding: 8px 16px;
            margin: 4px;
            font-weight: bold;
            transition: all 0.2s ease;
        `,
        setup: (self) => {
            self.connect("enter-notify-event", () => {
                self.css = self.css.replace(/background:[^;]+;/, `background: ${colors.accent};`);
            });
            self.connect("leave-notify-event", () => {
                self.css = self.css.replace(/background:[^;]+;/, `background: linear-gradient(45deg, ${colors.primary}, ${colors.accent});`);
            });
        }
    });
}

// Export widgets
Quickshell.bar = bar;
Quickshell.gameLauncher = gameLauncher;
