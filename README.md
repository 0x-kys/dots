# 🖤 monolith

> Minimal, elegant, monochrome rice for Fedora + Hyprland

A dark, sophisticated setup focused on productivity and aesthetics.

## 🎨 Theme

- **Colors:** Pure monochrome (black, white, grays)
- **Font:** JetBrainsMono Nerd Font
- **Style:** Sharp edges, minimal spacing, no rounded corners
- **Philosophy:** Function over form, but make it beautiful

## 📦 Components

- **WM:** Hyprland (Wayland compositor)
- **Bar:** Waybar (custom monochrome theme)
- **Notifications:** Mako (dark minimal theme)
- **Launcher:** Vicinae (Raycast-like launcher)
- **Terminal:** Kitty
- **Shell:** Fish
- **Editor:** Neovim (Kanagawa Dragon theme)
- **Screenshots:** Flameshot

## 🚀 Installation

This dotfiles repo uses **GNU Stow** for symlink management.

### Install dependencies:
```bash
sudo dnf install stow
```

### Clone and deploy:
```bash
git clone <your-repo-url> ~/dev/rndm/dots
cd ~/dev/rndm/dots
git checkout monolith

# Install all packages
stow hyprland waybar mako nvim fish kitty

# Or install selectively
stow hyprland waybar
```

### Uninstall:
```bash
cd ~/dev/rndm/dots
stow -D hyprland waybar mako nvim fish kitty
```

## 📁 Structure

```
dots/
├── hyprland/     # Hyprland config
├── waybar/       # Waybar config + scripts
├── mako/         # Notification daemon
├── nvim/         # Neovim config
├── fish/         # Fish shell config
└── kitty/        # Kitty terminal config
```

Each directory contains a `.config/` subdirectory that mirrors `~/.config/`.

## ⚡ Features

### Waybar
- Custom monochrome theme
- System monitoring (CPU, RAM, GPU, Temp)
- MPRIS media controls
- DND toggle for notifications
- Network, audio, system tray

### Hyprland
- Minimal gaps (4px inner, 8px outer)
- Sharp, 0-radius borders
- Smooth, snappy animations
- No auto-sleep/screen blanking
- Custom keybinds for productivity

### Notifications
- Mako with monochrome theme
- DND mode toggle in Waybar
- Clean, minimal design

## 🎯 Keybinds

| Key | Action |
|-----|--------|
| `Super + Return` | Terminal |
| `Super + Space` | Launcher (Vicinae) |
| `Super + Q` | Close window |
| `Super + F` | Toggle float |
| `Super + L` | Lock screen (if configured) |
| `Print` | Screenshot (Flameshot GUI) |

## 🖼️ Screenshots

*Coming soon*

## 📝 Notes

- Configs are symlinked, so changes in `~/.config` reflect in the repo
- Remember to commit changes: `cd ~/dev/rndm/dots && git add . && git commit`
- Push to backup: `git push origin monolith`

---

**Rice name:** monolith  
**Created:** November 2025  
**System:** Fedora Workstation + Hyprland
