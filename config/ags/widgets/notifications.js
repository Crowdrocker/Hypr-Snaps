// AGS Notifications Widget - WehttamSnaps J.A.R.V.I.S.

const { Box, Label } = ags.Widget

// This is a placeholder for AGS notifications integration.
// AGS can listen to dbus notifications, but here we show a simple notification box.

let notifications = []; // Replace with AGS notification service integration for real use

function renderNotifications() {
  return notifications.map(msg =>
    Label({
      label: `🔔 ${msg}`,
      style: 'color:#00FFFF; background:#1a1b26; border-radius:6px; margin:2px; padding:2px;',
    })
  )
}

export default Box({
  vertical: true,
  children: [
    Label({ label: '🔔 Notifications', style: 'font-weight:bold; color:#8A2BE2; font-size:16px;' }),
    ...renderNotifications(),
  ]
})

// For real notifications, see AGS docs: https://github.com/Aylur/ags/wiki/Notifications