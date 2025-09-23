// AGS System Monitor Widget - WehttamSnaps

const { Box, Label } = ags.Widget

function monitor(label, cmd, color) {
  return Label({
    label: `${label}: ...`,
    style: `color: ${color}; font-size:14px; margin:2px;`,
    connections: [[ags.Service.System, async self => {
      const value = await ags.Utils.execAsync(cmd)
      self.label = `${label}: ${value.trim()}`
    }]],
  })
}

export default Box({
  vertical: true,
  children: [
    Label({ label: '🖥️ System Monitor', style: 'font-weight:bold; color:#00FFFF; font-size:16px;' }),
    monitor('CPU', 'grep \'cpu \' /proc/stat | awk \'{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}\'', '#8A2BE2'),
    monitor('RAM', 'free -h | awk \'/Mem:/ {print $3 "/" $2}\'', '#00FFFF'),
    monitor('Temp', 'sensors | grep \'Package id 0\' | awk \'{print $4}\'', '#FF69B4'),
    monitor('Disk', 'df -h / | awk \'/\\// {print $3 "/" $2}\'', '#0066CC'),
  ]
})