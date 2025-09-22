// ~/.config/ags/widgets/work-launcher.js
const WorkButton = (name, icon, command) => Widget.Button({
    className: 'work-button',
    child: Widget.Box({
        children: [
            Widget.Icon({ icon: icon, size: 32 }),
                      Widget.Label({ label: name })
        ]
    }),
    onClicked: () => {
        Utils.exec(`bash -c "${command}"`);
        Utils.exec('pw-play ~/.config/hypr/sounds/jarvis-work.mp3');
    }
});

export default () => Widget.Box({
    className: 'work-launcher',
    vertical: true,
    children: [
        Widget.Label({ label: '📸 WehttamSnaps Work Center' }),
                                WorkButton('GIMP', 'gimp', 'gimp'),
                                WorkButton('Darktable', 'darktable', 'darktable'),
                                WorkButton('Inkscape', 'inkscape', 'inkscape'),
                                WorkButton('Krita', 'krita', 'krita'),
                                WorkButton('Discord', 'discord', 'discord'),
                                WorkButton('OBS', 'obs', 'obs')
    ]
});
