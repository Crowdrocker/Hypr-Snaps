-- WehttamSnaps Quickshell: Bar + Widgets
-- Reload: hyprctl reload or killall quickshell && quickshell
-- To add: Uncomment lines, edit paths. Theme: Violet-Cyan gradient.

local quickshell = require("quickshell")
local widgets = require("widgets")  -- Your ~/scripts/quickshell-widgets.lua (below)

-- Bar Setup (Bottom, smooth animations, brand colors)
local bar = quickshell.shelfs:make_bottom_bar({
    widgets = {
        widgets.work_launcher,  -- Work buttons
        quickshell.modules.text({ text = " | " }),
        widgets.gaming_launcher,  -- Gaming buttons
        quickshell.modules.text({ text = " | WehttamSnaps" }),
        quickshell.modules.workarea(),  -- Workspaces
        quickshell.modules.systray(),
        widgets.temp_monitor,  -- GPU/CPU temp (for cooling)
    },
    style = {
        background = "linear-gradient(to right, #8A2BE2, #00FFFF)",  -- Brand
        padding = 10,
        border_radius = 10,
        animation = { speed = 15 },  -- Smooth
    },
})

-- J.A.R.V.I.S. Themed: Add sound on hover/click
bar:on_enter(function() os.execute("paplay ~/.sounds/jarvis-notification.mp3") end)

-- Load widgets (modular)
bar:load()

-- Sidebars (From ArchEclipse-inspired, optional)
local sidebar_work = quickshell.windows:make_window({ layer = "overlay", sidebar = true })
sidebar_work:load(widgets.work)  -- Load work panel
```
**widgets.lua** (`~/.config/quickshell/widgets.lua`—source in init.lua):
```lua
-- Modular Widgets (Toggle with -- comments)
local widgets = {}

-- Gaming Launcher (Buttons + FPS)
widgets.gaming_launcher = function()
    local launcher = quickshell.modules.horizontal_box({
        children = {
            quickshell.modules.button({ text = "🎮 Steam", on_click = function() os.execute("gamemoderun steam") end }),
            quickshell.modules.button({ text = "📺 Twitch", on_click = function() os.execute("brave https://twitch.tv/wehttamsnaps") end }),
            quickshell.modules.button({ text = "🎲 Lutris", on_click = function() os.execute("lutris") end }),
            quickshell.modules.button({ text = "🦸 Heroic", on_click = function() os.execute("heroic") end }),
            quickshell.modules.button({ text = "🎵 Spotify", on_click = function() os.execute("spotify") end }),  -- Or webapp
            -- FPS Monitor (via MangoHud pipe)
            quickshell.modules.text({ text = "FPS: ", poll = "mangohud --dlsym --pid $(pgrep -f game)" }),  -- Newbie: Toggle poll=false
        },
        -- Gaming mode trigger
        on_click = function() os.execute("~/.scripts/jarvis-sounds.sh gaming; hyprctl dispatch workspace 6") end,  -- Switch to gaming WS
    })
    return launcher
end

-- Work Launcher (Shortcuts + Mount drive)
widgets.work_launcher = function()
    local launcher = quickshell.modules.horizontal_box({
        children = {
            quickshell.modules.button({ text = "🖼️ Inkscape", on_click = function() os.execute("inkscape") end }),
            quickshell.modules.button({ text = "💬 Discord", on_click = function() os.execute("discord") end }),
            quickshell.modules.button({ text = "🎨 Krita", on_click = function() os.execute("krita") end }),
            quickshell.modules.button({ text = "🖌️ GIMP", on_click = function() os.execute("gimp") end }),
            quickshell.modules.button({ text = "📁 Mount Photos", on_click = function() os.execute("udisksctl mount -b /dev/sdX1") end }),  -- 1TB SSD
            -- -- Optional: Webapps (YouTube/Twitch/Instagram/AI)
            -- quickshell.modules.button({ text = "📹 YouTube", on_click = function() os.execute("brave https://youtube.com") end }),
        },
        on_click = function() os.execute("hyprctl dispatch workspace 1") end,  # Work WS
    })
    return launcher
end

-- Temp Monitor (GPU/CPU for cooling alerts)
widgets.temp_monitor = quickshell.modules.text({
    text = "Temp: ",
    poll = "sensors | grep 'amdgpu' | awk '{print $2}'",  # AMD GPU
    style = { color = "#FF69B4" },  -- Hot pink warning
    on_update = function(value)
        if value > 80 then os.execute("~/.scripts/jarvis-sounds.sh warning") end
    end,
})

-- Full sidebar for work (Toggle with keybind)
widgets.work = quickshell.modules.vertical_box({ children = { widgets.work_launcher() } })

return widgets
