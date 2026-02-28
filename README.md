# Dotfiles

This repository contains my configuration files managed via GNU Stow.

## Structure

- `git/` - git configurations
- `zsh/` - ZSH configurations
- `ssh/` - SSH configurations (keys excluded)
- `nvim/` - Neovim configurations
- `tmux/` - Tmux configurations
- `ghostty/` - Ghostty terminal configurations
- `karabiner/` - Karabiner configurations
- `yabai/` - Yabai window manager configurations
- `skhd/` - skhd configurations
- `sketchybar/` - Sketchybar configurations
- `linearmouse/` - LinearMouse configurations
- `rift/` - Rift configurations
- `aerospace/` - Aerospace configurations
- `opencode/` - Opencode configurations
- `hushlogin/` - .hushlogin file

## Installation

### Quick Install
```bash
git clone <repository_url> ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

### Manual Install
```bash
git clone <repository_url> ~/dotfiles
cd ~/dotfiles
stow git zsh ssh nvim tmux ghostty karabiner yabai skhd sketchybar linearmouse rift aerospace opencode hushlogin
```

## Adding New Dotfiles

1. Copy the file to the appropriate subdirectory
2. Run `stow <directory_name>`
3. Commit the changes to git

## Removing Dotfiles

```bash
stow -D <directory_name>
```
