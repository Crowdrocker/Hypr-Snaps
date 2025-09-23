// AGS Spotify Widget - WehttamSnaps J.A.R.V.I.S.

const { Box, Button, Label } = ags.Widget

const trackLabel = Label({
  label: 'Track: ...',
  style: 'color:#00FFFF; font-size:14px; margin:2px;',
  connections: [[ags.Service.System, async self => {
    const track = await ags.Utils.execAsync('playerctl metadata title')
    const artist = await ags.Utils.execAsync('playerctl metadata artist')
    self.label = `Track: ${track.trim()} — ${artist.trim()}`
  }]],
})

const playPause = Button({
  label: ' Play/Pause',
  style: 'background:#8A2BE2; color:#fff; border-radius:8px; margin:4px;',
  onClicked: () => ags.Utils.execAsync('playerctl play-pause'),
})

const next = Button({
  label: ' Next',
  style: 'background:#00FFFF; color:#1a1b26; border-radius:8px; margin:4px;',
  onClicked: () => ags.Utils.execAsync('playerctl next'),
})

const previous = Button({
  label: ' Previous',
  style: 'background:#FF69B4; color:#fff; border-radius:8px; margin:4px;',
  onClicked: () => ags.Utils.execAsync('playerctl previous'),
})

export default Box({
  vertical: true,
  children: [
    Label({ label: '🎧 Spotify', style: 'font-weight:bold; color:#8A2BE2; font-size:16px;' }),
    trackLabel,
    playPause,
    next,
    previous,
  ]
})