# 🐉 Dragon Oh My Posh Theme

## Design Concept

A fierce and mystical dragon-themed prompt that brings the power and majesty of dragons to your terminal!

## Color Palette 🎨

The theme uses a dragon-inspired color scheme:

- **🔴 Dark Red (#8B0000)**: Dragon blood - core status and divider accents
- **🟠 Flame Orange (#FF6E3A)**: Dragon fire - primary accent highlights
- **🟡 Gold (#FFD700)**: Dragon treasure - highlights and important info
- **🍑 Ember Peach (#FF8266)**: Dragon scales - path background
- **💜 Arcane Violet (#8A2BE2)**: Dragon magic - git background
- **🟢 Verdant Scale (#66FF66)**: Dragon vitality - runtime segments

## Visual Elements

### Main Prompt Structure

```
🐉╭─[👤 user@hostname][📁 /current/path][🔱 main 🔥 2][🐍 python 3.11][⏰ 12:34 PM]─╮
╰─🔥
```

### Symbols Used

- **🐉** - Dragon head (main icon)
- **🔥** - Fire (success indicator)
- **💀** - Skull (error indicator)
- **🏰** - Castle (home directory)
- **✨** - Sparkles (staged git changes)
- **🐲** - Dragon (battery discharging)
- **⚡** - Lightning (battery charging)
- **💎** - Gem (battery full)

## Features

### Left Prompt

1. **Dragon Icon** - Your terminal guardian
2. **User Session** - Shows username and hostname (SSH indicator included)
3. **Path Segment** - Current directory with castle emoji for home
4. **Git Status** - Branch name with fire emoji for working changes, sparkles for staged
5. **Python Environment** - Active Python version and virtual env
6. **Node Version** - Node.js version when in a Node project
7. **Time Display** - Current time in your preferred format

### Right Prompt (rprompt)

- **Execution Time** - Shows command duration (⏱️) if over 500ms
- **Battery Status** - Dragon/lightning/gem icons based on charging state

### Special Features

- **Transient Prompt**: Minimizes to `🐉 🔥` after command execution (cleaner history)
- **Secondary Prompt**: Shows `╰─🔥` for multi-line commands
- **Git Tooltips**: Type `git` or `g` to see quick git status
- **Error Handling**: 🔥 for success, 💀 for errors

## Installation

1. Install Oh My Posh (if not already installed):
   ```bash
   # Windows (PowerShell)
   winget install JanDeDobbeleer.OhMyPosh
   
   # macOS/Linux
   brew install jandedobbeleer/oh-my-posh/oh-my-posh
   ```

2. Place the `dragon-theme.omp.json` file in your Oh My Posh themes directory

3. Apply the theme:
   ```bash
   # PowerShell
   oh-my-posh init pwsh --config ~/dragon-theme.omp.json | Invoke-Expression
   
   # Bash
   eval "$(oh-my-posh init bash --config ~/dragon-theme.omp.json)"
   
   # Zsh
   eval "$(oh-my-posh init zsh --config ~/dragon-theme.omp.json)"
   ```

4. To make it permanent, add the above command to your shell profile:
   - PowerShell: `$PROFILE`
   - Bash: `~/.bashrc`
   - Zsh: `~/.zshrc`

## Customization Tips

### Change Dragon Color
Edit the first text segment's foreground color:
```json
"foreground": "#FF6E3A"  // Change to your preferred color
```

### Modify Path Style
In the path segment properties:
```json
"style": "full"  // Options: full, folder, short, mixed
```

### Adjust Git Icons
In the git segment template, replace emojis:
```json
"template": " {{ .HEAD }} 🔥 {{ .Working.String }}"
```

## Requirements

- A [Nerd Font](https://www.nerdfonts.com/) installed for proper icon display
- Oh My Posh v3 or higher
- A terminal that supports true color

## Design Philosophy

This theme embodies the essence of a dragon:
- **Powerful**: Bold colors that command attention
- **Mystical**: Purple and gold accents suggesting magic and treasure
- **Fierce**: Fire emojis and dramatic color transitions
- **Legendary**: Every prompt feels like an epic adventure

## Preview

The theme creates a dramatic, multi-colored prompt that wraps around your current directory and git information, with the dragon emoji standing guard at the beginning. The fire emoji acts as your command cursor on success, while a skull appears when commands fail - keeping with the deadly dragon aesthetic.

---

**Created for warriors of the command line** 🐉⚔️
