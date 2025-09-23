// AGS Quick Editor Widget - WehttamSnaps J.A.R.V.I.S.

const { Box, Button, Label, Entry } = ags.Widget

let filePath = '';

const pathEntry = Entry({
  placeholder: 'Config file path (e.g. ~/.config/hypr/hyprland.conf)',
  onChange: self => { filePath = self.text; },
})

const openEditor = Button({
  label: ' Edit File',
  style: 'background:#8A2BE2; color:#fff; border-radius:8px; margin:4px;',
  onClicked: () => {
    if (filePath)
      ags.Utils.execAsync(`xdg-open ${filePath}`)
  },
})

export default Box({
  vertical: true,
  children: [
    Label({ label: '⚡ Quick Config Editor', style: 'font-weight:bold; color:#FF69B4; font-size:16px;' }),
    pathEntry,
    openEditor,
  ]
})