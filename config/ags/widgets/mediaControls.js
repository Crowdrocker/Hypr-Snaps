// AGS Media Controls Widget - WehttamSnaps J.A.R.V.I.S.

const { Box, Button, Label } = ags.Widget

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

const stop = Button({
  label: ' Stop',
  style: 'background:#0066CC; color:#fff; border-radius:8px; margin:4px;',
  onClicked: () => ags.Utils.execAsync('playerctl stop'),
})

export default Box({
  vertical: true,
  children: [
    Label({ label: '🎵 Media Controls', style: 'font-weight:bold; color:#8A2BE2; font-size:16px;' }),
    playPause,
    next,
    previous,
    stop,
  ]
})