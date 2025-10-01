-- WehttamSnaps Quickshell Bar - J.A.R.V.I.S. Enhanced
-- Newbie Edit: Add/remove buttons in launchers. Reload: hyprctl reload

local quickshell = require("quickshell")
local widgets = quickshell.widgets

-- Bar (Bottom, violet-cyan gradient)
local bar = quickshell.host.bars({
    edges = { "bottom" },
    layer = "top",
    properties = {
        width = "100%",
        height = 30,
        background = { bg = "#8A2BE2aa" },  -- Violet base
        border = { radius = 10, color = "#00FFFF" },  # Cyan accent
    },
    contents = {
        widgets.spacer(10),
        widgets.button({
            text = "WehttamSnaps",  # Brand
            on_click = function() quickshell.run("brave --new-tab https://twitch.tv/wehttamsnaps") end,
            style = { fg = "#00FFFF", font = "Sans Bold 12" },
        }),
        widgets.spacer(20),
        -- Work Widgets (Draggable)
        widgets.button({ text = "Discord", on_click = function() quickshell.run("discord") end }),
        widgets.button({ text = "GIMP", on_click = function() quickshell.run("gimp") end }),
        widgets.button({ text = "Krita", on_click = function() quickshell.run("krita") end }),
        widgets.button({ text = "Inkscape", on_click = function() quickshell.run("inkscape") end }),
        widgets.spacer(40),
        -- Gaming Widgets
        widgets.button({ text = "Steam", on_click = function() quickshell.run("steam") end }),
        widgets.button({ text = "Lutris", on_click = function() quickshell.run("lutris") end }),
        widgets.button({ text = "Heroic", on_click = function() quickshell.run("heroic") end }),
        widgets.button({ text = "OBS", on_click = function() quickshell.run("obs") end }),
        widgets.button({ text = "Spotify", on_click = function() quickshell.run("spotify") end }),
        widgets.spacer(20),
        -- System Widgets (Draggable, easy add)
        widgets.workspaces(),
        widgets.spacer(10),
        widgets.systray(),
        widgets.clock({ format = "%H:%M", style = { fg = "#FF69B4" } }),  # Hot pink
        widgets.battery({ style = { fg = "#0066CC" } }),  # Deep blue
        widgets.pulseaudio({ style = { fg = "#00FFFF" } }),
        widgets.spacer(10),
        widgets.button({
            text = "Power", on_click = function() quickshell.run("~/.config/hypr/scripts/power-menu.sh") end,
            style = { fg = "#FF69B4" },
        }),
    },
})

-- Gaming Mode Toggle Widget (Draggable sidebar on hover)
local gaming_widget = widgets.button({
    text = "Gaming Mode",
    on_click = function()
        quickshell.run("gamemoderun %")  -- Activates on game start
        quickshell.play_sound("~/.local/share/sounds/jarvis-gaming.mp3")
    end,
    properties = { visible = false },  -- Show on WS2
})

-- Work Launcher (Separate draggable panel)
local work_launcher = widgets.panel({
    anchor = "left", width = 200, height = "100%",
    contents = {
        widgets.heading("Work - WehttamSnaps"),
        widgets.button({ text = "Photos (/run/media/...)", on_click = function() quickshell.run("thunar /run/media/wehttamsnaps/LINUXDRIVE-1") end }),
        widgets.button({ text = "YouTube Studio", on_click = function() quickshell.run("brave https://studio.youtube.com") end }),
        widgets.button({ text = "Twitch Dashboard", on_click = function() quickshell.run("brave https://dashboard.twitch.tv") end }),
        -- Add more: e.g., widgets.webapp("Instagram", "https://instagram.com")
    },
    style = { background = "#0066CCaa" },  # Deep blue
})

quickshell.host:run()
