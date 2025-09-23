// AGS Launcher Starter - WehttamSnaps J.A.R.V.I.S. Theme

const { App, Button, Label, Box, Grid } = ags.Widget;

const gameLauncher = Box({
  vertical: true,
  children: [
    Label({ label: '🎮 Game Launcher', style: 'font-weight:bold; color:#8A2BE2;' }),
    Button({ label: 'Steam', onClicked: () => ags.Utils.execAsync('steam') }),
    Button({ label: 'Lutris', onClicked: () => ags.Utils.execAsync('lutris') }),
    Button({ label: 'Heroic', onClicked: () => ags.Utils.execAsync('heroic') }),
    Button({ label: 'Spotify', onClicked: () => ags.Utils.execAsync('spotify') }),
    Button({ label: 'Twitch', onClicked: () => ags.Utils.execAsync('firefox https://twitch.tv') }),
  ],
});

const workLauncher = Box({
  vertical: true,
  children: [
    Label({ label: '🖥️ Work Apps', style: 'font-weight:bold; color:#00FFFF;' }),
    Button({ label: 'GIMP', onClicked: () => ags.Utils.execAsync('gimp') }),
    Button({ label: 'Inkscape', onClicked: () => ags.Utils.execAsync('inkscape') }),
    Button({ label: 'Krita', onClicked: () => ags.Utils.execAsync('krita') }),
    Button({ label: 'Discord', onClicked: () => ags.Utils.execAsync('discord') }),
  ],
});

App({
  title: 'WehttamSnaps AGS Launcher',
  width: 400,
  height: 600,
  content: Grid({
    children: [
      [gameLauncher, 0, 0, 1, 1],
      [workLauncher, 1, 0, 1, 1],
    ]
  }),
}).run();