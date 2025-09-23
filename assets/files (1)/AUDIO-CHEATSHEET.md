# WehttamSnaps Audio Routing Cheat Sheet

**Goal:** Separate audio streams for game, browser, Discord, Spotify (like Voicemeeter on Windows).

## 1. PipeWire Setup

- Ensure `pipewire`, `pipewire-pulse`, `qpwgraph`, `pavucontrol` are installed.
- Start/enable PipeWire:
  ```bash
  systemctl --user enable --now pipewire pipewire-pulse
  ```

## 2. Create Virtual Sinks

- Use qpwgraph GUI:
  - Open `qpwgraph`
  - Right-click → Add Node → PulseAudio Sink (name it e.g. `GameSink`, `BrowserSink`, etc.)
  - Route apps to sinks using pavucontrol.

## 3. Separate Audio Streams

- Open `pavucontrol` (PulseAudio volume control)
- Go to `Playback` tab, assign each app (game, browser, Discord, Spotify) to a different sink.
- In OBS/streaming software, select the virtual sink as the audio source for each track.

## 4. J.A.R.V.I.S. Sound Triggers (Example Script)

```bash
# Play startup sound on login
aplay ~/jarvis-sounds/jarvis-startup.mp3

# Play gaming mode sound when launching a game
aplay ~/jarvis-sounds/jarvis-gaming.mp3
```

**Tip:** Use Hyprland’s event hooks to trigger sounds (see [Hyprland docs](https://wiki.hyprland.org/Configuring/Customization/)).

## 5. Troubleshooting

- If audio isn’t routed, check `qpwgraph` connections.
- Restart `pipewire` and `qpwgraph` if changes don’t take effect.

**Documentation:**  
- [PipeWire](https://docs.pipewire.org/)  
- [qpwgraph](https://github.com/wwmm/qpwgraph)  
- [pavucontrol](https://freedesktop.org/software/pulseaudio/pavucontrol/)