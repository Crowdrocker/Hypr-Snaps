// ~/.config/ags/widgets/gaming-launcher.js
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

const GameButton = (name, icon, command) => Widget.Button({
    className: 'game-button',
    child: Widget.Box({
        children: [
            Widget.Icon({ icon: icon, size: 32 }),
                      Widget.Label({ label: name })
        ]
    }),
    onClicked: () => {
        Utils.exec(`bash -c "${command}"`);
        Utils.exec('pw-play ~/.config/hypr/sounds/jarvis-gaming.mp3');
    }
});

export default () => Widget.Box({
    className: 'gaming-launcher',
    vertical: true,
    children: [
        Widget.Label({ label: '🎮 J.A.R.V.I.S. Gaming Center' }),
                                GameButton('Steam', 'steam', 'steam'),
                                GameButton('Lutris', 'lutris', 'lutris'),
                                GameButton('Heroic', 'heroic', 'heroic'),
                                GameButton('Spotify', 'spotify', 'spotify-launcher')
    ]
});
