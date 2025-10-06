# Steam Launch Options for WehttamSnaps

## Standard Setup (Most Games)
```
gamemoderun mangohud %command%
```

## For Competitive Games (Maximum Performance)
```
gamemoderun VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.x86_64.json %command%
```

## Game-Specific Options

### Call of Duty HQ
```
gamemoderun mangohud PROTON_USE_WINED3D=1 %command%
```

### Cyberpunk 2077
```
gamemoderun mangohud DXVK_ASYNC=1 %command%
```

### Fallout 4
```
gamemoderun mangohud PROTON_USE_WINED3D=0 %command%
```

### FarCry 5
```
gamemoderun mangohud %command%
```

### Ghost Recon Breakpoint
```
gamemoderun mangohud PROTON_USE_WINED3D11=1 %command%
```

### Marvel's Avengers
```
gamemoderun mangohud DXVK_ASYNC=1 %command%
```

### Need for Speed Payback
```
gamemoderun mangohud %command%
```

### Rise of the Tomb Raider / Shadow of the Tomb Raider
```
gamemoderun mangohud PROTON_USE_WINED3D=0 %command%
```

### The First Descendant
```
gamemoderun mangohud VKD3D_CONFIG=dxr11 %command%
```

### The Division / The Division 2
```
gamemoderun mangohud DXVK_ASYNC=1 %command%
```

### Warframe
```
gamemoderun mangohud %command%
```

### Watch Dogs Series (1, 2, Legion)
```
gamemoderun mangohud DXVK_ASYNC=1 %command%
```

## Environment Variables Explained

- `gamemoderun`: Activates GameMode for CPU priority
- `mangohud`: Shows FPS/performance overlay
- `DXVK_ASYNC`: Enables asynchronous shader compilation (reduces stuttering)
- `PROTON_USE_WINED3D`: Forces OpenGL instead of Vulkan (some older games)
- `VKD3D_CONFIG=dxr11`: DirectX 12 compatibility
- `VK_ICD_FILENAMES`: Forces AMD Vulkan driver

## Testing Process

1. Start with standard setup
2. If stuttering occurs, add `DXVK_ASYNC=1`
3. If graphical issues occur, try `PROTON_USE_WINED3D=1`
4. Check ProtonDB for game-specific tweaks

## Useful Commands

Check Vulkan support:
```bash
vulkaninfo | grep "deviceName"
```

List Proton versions:
```bash
ls ~/.steam/steam/compatibilitytools.d/
```

Clear shader cache:
```bash
rm -rf ~/.steam/steam/shadercache/
```
