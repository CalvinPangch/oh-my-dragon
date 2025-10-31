# Dragon oh-my-posh Theme 🐉

A visually appealing, customizable oh-my-posh terminal prompt theme featuring dragon-inspired aesthetics with brilliant gold, flame orange, and deep crimson colors.

## Features

✨ **Dragon Aesthetic**: Brighter gold (#FFD700), flame orange (#FF6E3A), and crimson red (#8B0000) colors evoking dragon power and mystique
🎨 **Fully Customizable**: Change colors, symbols, and segments without editing code
⚡ **Cross-Platform**: Works on Windows (PowerShell), macOS (Zsh), and Linux (Bash)
🔧 **Easy Installation**: Simple copy-paste or script-based installation
📊 **Smart Prompt Segments**:
   - Current directory with smart truncation
   - Git repository status with branch and file indicators
   - Command execution status (success/failure)
   - Command execution time for long-running tasks

## Quick Start

### Prerequisites
- **oh-my-posh**: Version 3.0.0 or later ([install here](https://ohmyposh.dev))
- **Terminal**: Any modern terminal emulator with Unicode support
- **Font**: Optional but recommended - Nerd Font (Cascadia Code, Fira Code, etc.)

### Installation (Choose One)

#### Option 1: Manual Copy (All Platforms)

```bash
# Create oh-my-posh themes directory
mkdir -p ~/.config/oh-my-posh/themes

# Copy dragon theme
cp dragon.json ~/.config/oh-my-posh/themes/dragon.json
```

#### Option 2: Windows PowerShell

```powershell
mkdir -Force $ENV:APPDATA\oh-my-posh\themes
Copy-Item -Path "dragon.json" -Destination "$ENV:APPDATA\oh-my-posh\themes\dragon.json"
```

### Activation

#### macOS/Linux (Zsh/Bash)
Add to `~/.zshrc` or `~/.bashrc`:
```bash
eval "$(oh-my-posh init bash --config ~/.config/oh-my-posh/themes/dragon.json)"
```

#### Windows (PowerShell)
Add to your PowerShell profile (`$PROFILE`):
```powershell
oh-my-posh init pwsh --config $ENV:APPDATA\oh-my-posh\themes\dragon.json | Out-String | Invoke-Expression
```

Then reload: `source ~/.zshrc` or close/reopen PowerShell terminal

### Verification

Open a new terminal. You should see:
- Directory path with **dragon gold background** (#FFD700)
- **✓** symbol on successful commands (green)
- **✗** symbol on failed commands (red)
- Git branch information when in a repository

## Documentation

- **[Installation Guide](docs/installation.md)**: Detailed platform-specific setup instructions
- **[Customization Guide](docs/customization.md)**: Full configuration reference and customization options
- **[Quick Start](../specs/001-dragon-theme/quickstart.md)**: Quick setup and basic customization

## Configuration Variants

### Minimal Theme
Essential information only - directory, git, and status:
```bash
cp docs/examples/minimal.json ~/.config/oh-my-posh/themes/dragon-minimal.json
```

### Extended Theme
Full details - includes execution time:
```bash
cp docs/examples/extended.json ~/.config/oh-my-posh/themes/dragon-extended.json
```

### Custom Colors
Alternative color scheme while maintaining dragon aesthetic:
```bash
cp docs/examples/custom-colors.json ~/.config/oh-my-posh/themes/dragon-custom.json
```

## Color Palette

| Color | Hex Code | Usage |
|-------|----------|-------|
| Dragon Gold | #FFD700 | Primary accent, python segment background |
| Dragon Red | #8B0000 | Session/status backgrounds and dividers |
| Flame Orange | #FF6E3A | Primary accent glyphs and fire motifs |
| Ember Peach | #FF8266 | Path background for readability |
| Arcane Violet | #8A2BE2 | Git segment background |
| Verdant Scale | #66FF66 | Runtime (Node) background |
| Dragon Dark | #1A1A1A | Text on light backgrounds |

## Customization Examples

### Change Primary Color
Edit `dragon.json` color section:
```json
"dragon_gold": "#FFD700"  // Brighter gold
```

### Change Success/Error Symbols
Edit segment properties:
```json
"success_icon": "✔",      // Change from ✓
"error_icon": "✘"         // Change from ✗
```

### Customize Git Symbols
```json
"local_working_icon": "●",   // Modified files
"local_staged_icon": "◆",    // Staged files
"untracked_count_icon": "?"  // Untracked files
```

### Show/Hide Segments
Remove unwanted segments from the `segments` array in `dragon.json`

### Truncate Long Paths
Adjust in directory segment properties:
```json
"max_width": 40,           // Max characters before truncation
"truncation_length": 3     // Show last 3 directories when truncated
```

## Troubleshooting

### Theme not appearing?
- Verify theme file is in correct directory: `~/.config/oh-my-posh/themes/dragon.json`
- Check oh-my-posh configuration references correct path
- Restart terminal completely (close all instances)

### Unicode characters showing as boxes?
- Update terminal to latest version
- Install a Nerd Font (Cascadia Code, Fira Code, etc.)
- Try ASCII fallback symbols: ● → *, ◆ → *, ✓ → OK, ✗ → FAIL

### Colors look wrong?
- Check terminal color settings (prefer "true color"/24-bit mode)
- Ensure terminal theme is set to dark background
- Try a different terminal emulator

## File Structure

```
themes/
├── dragon.json                 # Main theme configuration
├── README.md                   # This file
├── docs/
│   ├── installation.md         # Platform-specific installation
│   ├── customization.md        # Configuration reference
│   └── examples/
│       ├── minimal.json        # Minimal variant
│       ├── extended.json       # Extended variant
│       └── custom-colors.json  # Custom color variant
└── tests/
    └── theme-validation.sh     # Validation script
```

## Next Steps

1. **Just installed?** Check [Quick Start](../specs/001-dragon-theme/quickstart.md)
2. **Want to customize?** See [Customization Guide](docs/customization.md)
3. **Need help installing?** See [Installation Guide](docs/installation.md)
4. **Looking for examples?** Check `docs/examples/` for configuration variants

## Support & Feedback

- **oh-my-posh documentation**: https://ohmyposh.dev
- **Issues or suggestions?**: Check the repository for issue tracker
- **Want to share your customization?** Contributing theme variants welcome!

---

**Enjoy your dragon-themed terminal!** 🐉✨

*Dragon oh-my-posh Theme (schema version 2) - Compatible with oh-my-posh 3.x+*
