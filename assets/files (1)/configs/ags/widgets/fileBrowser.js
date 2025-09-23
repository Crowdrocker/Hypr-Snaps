// AGS File Browser Widget - WehttamSnaps J.A.R.V.I.S.

const { Box, Button, Label, Entry } = ags.Widget

let currentDir = '~'

const dirEntry = Entry({
  placeholder: 'Enter directory (e.g. ~/Pictures)',
  text: currentDir,
  onChange: self => { currentDir = self.text; },
})

const openThunar = Button({
  label: ' Open Thunar',
  style: 'background:#00FFFF; color:#1a1b26; border-radius:8px; margin:4px;',
  onClicked: () => {
    if (currentDir)
      ags.Utils.execAsync(`thunar ${currentDir}`)
  },
})

export default Box({
  vertical: true,
  children: [
    Label({ label: '🗂️ File Browser', style: 'font-weight:bold; color:#FF69B4; font-size:16px;' }),
    dirEntry,
    openThunar,
  ]
})