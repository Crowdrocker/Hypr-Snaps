// AGS Custom J.A.R.V.I.S. Notifications Widget - WehttamSnaps

const { Box, Label } = ags.Widget

// Example: static notifications (replace with AGS/dunst integration for real-time)
const jarvisMessages = [
  "Good morning, Sir. All systems operational.",
  "Gaming mode activated. Systems at maximum performance.",
  "Streaming systems online. All feeds operational.",
  "Warning: System temperature critical.",
  "Sir, you have a notification.",
]

function renderJarvisNotifs() {
  return jarvisMessages.map(msg =>
    Label({
      label: `🤖 J.A.R.V.I.S.: ${msg}`,
      style: 'color:#8A2BE2; background:#1a1b26; border-radius:6px; margin:2px; padding:2px;',
    })
  )
}

export default Box({
  vertical: true,
  children: [
    Label({ label: '🤖 J.A.R.V.I.S. Notifications', style: 'font-weight:bold; color:#00FFFF; font-size:16px;' }),
    ...renderJarvisNotifs(),
  ]
})

// For real live notifications, integrate with AGS notifications service or dbus, see AGS docs:
// https://github.com/Aylur/ags/wiki/Notifications