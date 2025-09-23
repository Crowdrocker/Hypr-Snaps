// AGS WebApps Launcher Widget - WehttamSnaps J.A.R.V.I.S.

const { Box, Button, Label } = ags.Widget

const webapps = [
  { label: 'YouTube', url: 'https://youtube.com', color: '#8A2BE2' },
  { label: 'Twitch', url: 'https://twitch.tv', color: '#00FFFF' },
  { label: 'Instagram', url: 'https://instagram.com', color: '#FF69B4' },
  { label: 'AI Chat', url: 'https://chat.openai.com', color: '#0066CC' },
]

const webButtons = webapps.map(app =>
  Button({
    label: app.label,
    style: `background:${app.color}; color:#fff; border-radius:8px; margin:4px;`,
    onClicked: () => ags.Utils.execAsync(`xdg-open ${app.url}`),
  })
)

export default Box({
  vertical: true,
  children: [
    Label({ label: '🌐 WebApps', style: 'font-weight:bold; color:#00FFFF; font-size:16px;' }),
    ...webButtons,
  ]
})