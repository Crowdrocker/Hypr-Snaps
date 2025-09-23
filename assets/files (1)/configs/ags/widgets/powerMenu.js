// AGS Power Menu Widget - WehttamSnaps J.A.R.V.I.S.

const { Box, Button, Label } = ags.Widget

const shutdown = Button({
  label: '⏻ Shutdown',
  style: 'background:#8A2BE2; color:#fff; border-radius:8px; margin:4px;',
  onClicked: () => ags.Utils.execAsync('systemctl poweroff'),
})

const reboot = Button({
  label: ' Reboot',
  style: 'background:#00FFFF; color:#1a1b26; border-radius:8px; margin:4px;',
  onClicked: () => ags.Utils.execAsync('systemctl reboot'),
})

const sleep = Button({
  label: ' Sleep',
  style: 'background:#0066CC; color:#fff; border-radius:8px; margin:4px;',
  onClicked: () => ags.Utils.execAsync('systemctl suspend'),
})

const lock = Button({
  label: ' Lock',
  style: 'background:#FF69B4; color:#fff; border-radius:8px; margin:4px;',
  onClicked: () => ags.Utils.execAsync('loginctl lock-session'),
})

const jarvisLabel = Label({
  label: '🤖 J.A.R.V.I.S. Power Menu',
  style: 'font-weight:bold; font-size:16px; color:#8A2BE2; margin-bottom:8px;',
})

export default Box({
  vertical: true,
  children: [
    jarvisLabel,
    shutdown,
    reboot,
    sleep,
    lock,
  ]
})