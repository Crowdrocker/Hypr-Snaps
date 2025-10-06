# PipeWire Audio Routing Guide for WehttamSnaps

## Overview
This guide explains how to set up advanced audio routing similar to Voicemeter on Windows.

## Installing Required Tools
```bash
sudo pacman -S pipewire pipewire-pulse wireplumber pavucontrol qpwgraph
```

## Creating Virtual Sinks

### Method 1: Using pw-cli (Temporary)
```bash
# Game audio sink
pw-cli create-node adapter '{ factory.name=support.null-audio-sink node.name=game_sink media.class=Audio/Sink audio.position=FL,FR }'

# Discord audio sink
pw-cli create-node adapter '{ factory.name=support.null-audio-sink node.name=discord_sink media.class=Audio/Sink audio.position=FL,FR }'

# Browser audio sink
pw-cli create-node adapter '{ factory.name=support.null-audio-sink node.name=browser_sink media.class=Audio/Sink audio.position=FL,FR }'

# Music (Spotify) sink
pw-cli create-node adapter '{ factory.name=support.null-audio-sink node.name=music_sink media.class=Audio/Sink audio.position=FL,FR }'
```

### Method 2: Persistent Configuration
Create `~/.config/pipewire/pipewire.conf.d/virtual-sinks.conf`:
```
context.objects = [
    {
        factory = adapter
        args = {
            factory.name     = support.null-audio-sink
            node.name        = "game_sink"
            node.description = "Game Audio"
            media.class      = "Audio/Sink"
            audio.position   = [ FL FR ]
        }
    }
    {
        factory = adapter
        args = {
            factory.name     = support.null-audio-sink
            node.name        = "discord_sink"
            node.description = "Discord Audio"
            media.class      = "Audio/Sink"
            audio.position   = [ FL FR ]
        }
    }
    {
        factory = adapter
        args = {
            factory.name     = support.null-audio-sink
            node.name        = "browser_sink"
            node.description = "Browser Audio"
            media.class      = "Audio/Sink"
            audio.position   = [ FL FR ]
        }
    }
    {
        factory = adapter
        args = {
            factory.name     = support.null-audio-sink
            node.name        = "music_sink"
            node.description = "Music Audio"
            media.class      = "Audio/Sink"
            audio.position   = [ FL FR ]
        }
    }
]
```

Restart PipeWire:
```bash
systemctl --user restart pipewire pipewire-pulse
```

## Using qpwgraph

1. Launch `qpwgraph`
2. You'll see nodes representing your audio devices and virtual sinks
3. Connect application outputs to virtual sinks:
   - Steam games → game_sink
   - Discord → discord_sink
   - Firefox/Chrome → browser_sink
   - Spotify → music_sink
4. Connect virtual sink outputs to your headphones/speakers
5. Save the patch bay: File → Save As → `~/.config/qpwgraph/gaming-setup.qpwgraph`

## Using Pavucontrol

1. Launch `pavucontrol`
2. Go to "Playback" tab
3. For each application, select the desired output sink from the dropdown
4. Adjust individual volume levels

## Streaming Setup

### OBS Audio Sources
In OBS, add separate audio sources:
- Game Audio (from game_sink)
- Discord Audio (from discord_sink)
- Music Audio (from music_sink)
- Microphone (your physical mic)

This gives you individual control over each audio stream in your mix.

## Scripts for Quick Switching

Create `~/.local/bin/audio-profiles.sh`:
```bash
#!/bin/bash

case $1 in
    gaming)
        qpwgraph -a ~/.config/qpwgraph/gaming-setup.qpwgraph
        ;;
    streaming)
        qpwgraph -a ~/.config/qpwgraph/streaming-setup.qpwgraph
        ;;
    music)
        qpwgraph -a ~/.config/qpwgraph/music-setup.qpwgraph
        ;;
    *)
        echo "Usage: $0 {gaming|streaming|music}"
        ;;
esac
```

## Troubleshooting

### No sound from virtual sinks
Check if sinks are created:
```bash
pw-cli list-objects | grep -i sink
```

### Applications don't show up in qpwgraph
Make sure PulseAudio compatibility is enabled:
```bash
systemctl --user status pipewire-pulse
```

### Audio crackling
Increase buffer size in `/etc/pipewire/pipewire.conf`:
```
default.clock.allowed-rates = [ 44100 48000 ]
default.clock.quantum = 1024
default.clock.min-quantum = 512
```

## Keybinds for Quick Access

Add to Niri config:
```kdl
Mod+A { spawn "qpwgraph"; }
Mod+Shift+A { spawn "pavucontrol"; }
```
