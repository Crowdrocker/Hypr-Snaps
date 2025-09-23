// AGS Game Launcher Widget - WehttamSnaps J.A.R.V.I.S.

const { Box, Button, Label } = ags.Widget

const games = [
  { label: 'Steam', cmd: 'steam', color: '#8A2BE2' },
  { label: 'Lutris', cmd: 'lutris', color: '#00FFFF' },
  { label: 'Heroic', cmd: 'heroic', color: '#FF69B4' },
  { label: 'Cyberpunk Mods', cmd: 'nexusmods-app', color: '#0066CC' },
]

const gameButtons = games.map(game =>
  Button({
    label: game.label,
    style: `background:${game.color}; color:#fff; border-radius:8px; margin:4px;`,
    onClicked: () => ags.Utils.execAsync(game.cmd),
  })
)

export default Box({
  vertical: true,
  children: [
    Label({ label: '🎮 Game Launcher', style: 'font-weight:bold; color:#8A2BE2; font-size:16px;' }),
    ...gameButtons,
  ]
})