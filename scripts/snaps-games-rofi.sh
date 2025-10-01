| Game                  | Launch Options                                                                 | Notes |
|-----------------------|-------------------------------------------------------------------------------|-------|
| Call of Duty HQ      | `gamemoderun %command% -dx12 +fps_max 60 -refresh 60`                        | Proton Experimental; cap FPS for heat. |
| Cyberpunk 2077       | `gamemoderun PROTON_USE_WINED3D=1 %command% -- -dx11 -no-vsync +r_dynamic 0`  | Proton-GE; DX11 for stability, disable VSync. |
| Fallout 4            | `gamemoderun %command% -dx11 -use_d3d11`                                     | Proton-GE; Mod-friendly. |
| Far Cry 5            | `gamemoderun %command% +r.GraphicsQuality 2 -dx11`                           | Medium settings for i5-4430. |
| Ghost Recon Breakpoint | `gamemoderun %command% -dx11 -fullscreen`                                  | Proton Experimental. |
| Marvel's Avengers    | `gamemoderun %command% -dx11 +fps_max 60`                                    | Cap for stability. |
| Need for Speed Payback | `gamemoderun %command% -dx11 -no-vsync`                                    | Vulkan via Proton. |
| Rise of the Tomb Raider | `gamemoderun %command% -dx11 +r_VSync 0`                                  | High FPS. |
| Shadow of the Tomb Raider | `gamemoderun %command% -dx12 +r_VSync 0`                                 | Proton-GE for RT (limited on AMD). |
| The First Descendant | `gamemoderun %command% -dx11 -fullscreen`                                    | Proton Experimental; UE5 optimizations. |
| Tom Clancy's The Division | `gamemoderun %command% -dx11 -useDX11 +fps_max 60`                        | Stable on Mesa. |
| Tom Clancy's The Division 2 | `gamemoderun %command% -dx11 +EnableVSync 0`                             | Proton-GE. |
| Warframe             | `gamemoderun %command% -dx11 -vulkan`                                        | Native Vulkan best. |
| Watch_Dogs           | `gamemoderun %command% -dx11`                                                 | Proton. |
| Watch_Dogs 2         | `gamemoderun %command% -dx11 +r_AdaptiveSync 1`                              | Freesync if monitor supports. |
| Watch_Dogs Legion    | `gamemoderun %command% -dx12 -no-vsync`                                      | Proton-GE. |
