# Quickstart Guide: Dragon oh-my-posh Theme

**Feature**: Dragon oh-my-posh Theme
**Status**: Implementation Ready
**Target**: Developers new to the Dragon theme

## Table of Contents

1. [Installation](#installation)
2. [Activation](#activation)
3. [Verification](#verification)
4. [Basic Customization](#basic-customization)
5. [Troubleshooting](#troubleshooting)

---

## Installation

### Prerequisites

- **oh-my-posh**: Version 3.0.0 or later installed on your system
- **Terminal**: Any modern terminal emulator (Windows Terminal, iTerm2, GNOME Terminal, etc.)
- **Permissions**: Ability to write to `~/.config/oh-my-posh/` or equivalent directory

### Check oh-my-posh Installation

```bash
oh-my-posh --version
```

If you don't have oh-my-posh installed, visit [oh-my-posh.dev](https://ohmyposh.dev) for installation instructions for your OS.

### Step 1: Download the Dragon Theme

**Option A: Clone the Repository**

```bash
git clone https://github.com/[username]/oh-my-dragon.git
cd oh-my-dragon
```

**Option B: Copy Files Manually**

Copy the `themes/dragon.json` file to your oh-my-posh themes directory.

### Step 2: Place Theme File

Choose the appropriate command for your OS/shell combination:

#### Windows (PowerShell)

```powershell
# Create themes directory if it doesn't exist
mkdir -Force $ENV:APPDATA\oh-my-posh\themes

# Copy theme file
Copy-Item -Path "themes\dragon.json" -Destination "$ENV:APPDATA\oh-my-posh\themes\dragon.json"
```

#### macOS (Zsh/Bash)

```bash
# Create themes directory if it doesn't exist
mkdir -p ~/.config/oh-my-posh/themes

# Copy theme file
cp themes/dragon.json ~/.config/oh-my-posh/themes/dragon.json
```

#### Linux (Bash/Zsh)

```bash
# Create themes directory if it doesn't exist
mkdir -p ~/.config/oh-my-posh/themes

# Copy theme file
cp themes/dragon.json ~/.config/oh-my-posh/themes/dragon.json
```

---

## Activation

### Update oh-my-posh Configuration

Edit your shell configuration file to use the Dragon theme.

#### Windows (PowerShell)

Open `$PROFILE` in your editor:

```powershell
# Open PowerShell profile in your default editor
notepad $PROFILE
```

Add this line (create the file if it doesn't exist):

```powershell
oh-my-posh init pwsh --config $ENV:APPDATA\oh-my-posh\themes\dragon.json | Out-String | Invoke-Expression
```

#### macOS (Zsh)

Edit `~/.zshrc`:

```bash
# Add to ~/.zshrc
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/themes/dragon.json)"
```

#### Linux (Bash)

Edit `~/.bashrc`:

```bash
# Add to ~/.bashrc
eval "$(oh-my-posh init bash --config ~/.config/oh-my-posh/themes/dragon.json)"
```

### Reload Shell Configuration

```bash
# Source your configuration file to apply changes
source ~/.zshrc    # For Zsh
source ~/.bashrc   # For Bash

# For PowerShell, close and reopen the terminal, or run:
. $PROFILE
```

---

## Verification

### Visual Check

Open a new terminal window. You should see:

1. **Dragon gold background** (#D4AF37) with dark text
2. **Current directory** displayed with path
3. **If in a git repository**: Branch information with scale symbols (◆)
4. **Dragon aesthetic**: Gold and red dragon-themed styling

### Sample Output

**Default Directory**:
```
❯ ~/projects/oh-my-dragon
```

**Git Repository**:
```
❯ ~/projects/oh-my-dragon ⎇ main ◆
```

**After Failed Command**:
```
❯ command not found
✗
```

**Long-Running Command**:
```
❯ npm run build
⏱ 2.34s
```

### Troubleshooting Installation

**Theme not appearing?**
- Verify theme file is in correct directory: `~/.config/oh-my-posh/themes/dragon.json`
- Check oh-my-posh configuration references correct path
- Restart terminal completely (close all instances)

**Characters showing as boxes or strange symbols?**
- Your terminal may lack Unicode support
- Update terminal emulator to latest version
- Install a Nerd Font (Cascadia Code, Fira Code, etc.) for best character support

**Colors look wrong?**
- Check terminal color settings
- Try switching to "true color" mode (24-bit color) in terminal settings
- Ensure terminal theme is set to dark background

---

## Basic Customization

### Change Primary Color

Edit `~/.config/oh-my-posh/themes/dragon.json` and find the `colors` section:

```json
"colors": {
  "dragon_gold": "#D4AF37",     // Change this to your preferred color
  "dragon_red": "#8B0000",
  ...
}
```

Popular alternatives:
- **Bright Gold**: `#FFD700` (more luminous dragon gold)
- **Deep Purple**: `#4B0082` (mystical dragon)
- **Teal**: `#008080` (cool dragon aesthetic)

### Show/Hide Segments

Remove unwanted segments from the `"segments"` array in dragon.json:

**Keep only directory and status:**
```json
"segments": [
  { "type": "path", ... },
  { "type": "status", ... }
]
```

**Add execution time:**
```json
"segments": [
  { "type": "path", ... },
  { "type": "git", ... },
  { "type": "status", ... },
  { "type": "executiontime", ... }
]
```

### Customize Symbols

Find symbols in segment `properties` and change them:

```json
"local_working_icon": "●",    // Change to: ○, ◆, ★, etc.
"success_icon": "✓",           // Change to: ✔, OK, etc.
"error_icon": "✗"              // Change to: ✘, FAIL, etc.
```

### Truncate Long Paths

In the `path` segment properties:

```json
"properties": {
  "max_width": 40,              // Reduce to 20 for shorter paths
  "truncation_length": 3,       // Show fewer directories when truncated
  "folder_separator_icon": "/"  // Change to: •, →, etc.
}
```

---

## Using Example Configurations

We provide example configurations for common use cases:

### Minimal Theme (minimal.json)

Bare essentials - directory and status only:

```bash
# Copy minimal variant
cp themes/examples/minimal.json ~/.config/oh-my-posh/themes/dragon-minimal.json

# Update your shell config to use it
oh-my-posh init zsh --config ~/.config/oh-my-posh/themes/dragon-minimal.json
```

### Extended Theme (extended.json)

Full details - all segments with comprehensive git information:

```bash
cp themes/examples/extended.json ~/.config/oh-my-posh/themes/dragon-extended.json
oh-my-posh init zsh --config ~/.config/oh-my-posh/themes/dragon-extended.json
```

### Custom Colors (custom-colors.json)

Same as default but with alternative color scheme:

```bash
cp themes/examples/custom-colors.json ~/.config/oh-my-posh/themes/dragon-custom.json
# Edit colors, then activate
oh-my-posh init zsh --config ~/.config/oh-my-posh/themes/dragon-custom.json
```

---

## Common Customizations

### Add Current Time to Prompt

Edit dragon.json and add time segment to `segments` array:

```json
{
  "type": "time",
  "style": "diamond",
  "foreground": "#1a1a1a",
  "background": "#D4AF37",
  "properties": {
    "time_format": "15:04:05"
  }
}
```

### Change Directory Truncation

Shorter paths for smaller terminals:

```json
"path": {
  ...
  "properties": {
    "max_width": 25,
    "truncation_length": 2
  }
}
```

### Disable Git Segment

Remove or comment out the git segment if you work in non-git projects:

```json
// Remove this entire block:
// { "type": "git", ... }
```

### Status Codes Instead of Symbols

For terminals with limited symbol support:

```json
"status": {
  "properties": {
    "success_icon": "OK",
    "error_icon": "FAIL"
  }
}
```

---

## Next Steps

- **Documentation**: See `docs/customization.md` for advanced configuration
- **Examples**: Review `themes/examples/` for more configuration examples
- **Troubleshooting**: Check `docs/installation.md` for detailed platform-specific guidance
- **Contribute**: Share your custom dragon variants with the community!

---

## Support

If you encounter issues:

1. Check terminal compatibility (ensure it supports Unicode and colors)
2. Verify oh-my-posh version (3.0.0+)
3. Review the troubleshooting section above
4. Check `docs/installation.md` for detailed OS-specific guidance
5. Consult oh-my-posh documentation at [ohmyposh.dev](https://ohmyposh.dev)

---

**Enjoy your dragon-themed terminal!** 🐉
