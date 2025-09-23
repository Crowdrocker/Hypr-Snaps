// AGS Work Launcher Widget - WehttamSnaps

const { Box, Button, Label } = ags.Widget

const apps = [
  { label: 'GIMP', cmd: 'gimp', color: '#00FFFF' },
  { label: 'Krita', cmd: 'krita', color: '#8A2BE2' },
  { label: 'Inkscape', cmd: 'inkscape', color: '#FF69B4' },
  { label: 'Discord', cmd: 'discord', color: '#0066CC' },
]

const appButtons = apps.map(app =>
  Button({
    label: app.label,
    style: `background:${app.color}; color:#fff; border-radius:8px; margin:4px;`,
    onClicked: () => ags.Utils.execAsync(app.cmd),
  })
)

export default Box({
  vertical: true,
  children: [
    Label({ label: '🖼️ Work Launcher', style: 'font-weight:bold; color:#00FFFF; font-size:16px;' }),
    ...appButtons,
  ]
})