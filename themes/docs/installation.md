# Installation Guide: Dragon oh-my-posh Theme

This guide provides platform-specific instructions for installing the Dragon oh-my-posh theme on Windows, macOS, and Linux.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Installation by Platform](#installation-by-platform)
3. [Activation Instructions](#activation-instructions)
4. [Verification](#verification)
5. [Troubleshooting](#troubleshooting)

## Prerequisites

Before installing the Dragon theme, ensure you have:

- **oh-my-posh**: Version 3.0.0 or later installed on your system
- **Terminal**: A modern terminal emulator with Unicode support
- **Font** (optional but recommended): A Nerd Font for best symbol rendering
  - Cascadia Code
  - Fira Code
  - JetBrains Mono
  - Or any Nerd Font from [nerdfonts.com](https://www.nerdfonts.com/)

### Check oh-my-posh Installation

```bash
oh-my-posh --version
```

If you don't have oh-my-posh installed, visit [ohmyposh.dev](https://ohmyposh.dev) for installation instructions for your operating system.

## Installation by Platform

### Windows (PowerShell)

#### Step 1: Create oh-my-posh Themes Directory

```powershell
# Create the themes directory if it doesn't exist
mkdir -Force $ENV:APPDATA\oh-my-posh\themes
```

#### Step 2: Copy Dragon Theme File

**Option A: Using PowerShell (Recommended)**

Navigate to the directory containing `dragon.json`, then run:

```powershell
Copy-Item -Path "dragon.json" -Destination "$ENV:APPDATA\oh-my-posh\themes\dragon.json"
```

**Option B: Manual Copy**

1. Open File Explorer
2. Navigate to `%APPDATA%\oh-my-posh\themes\`
3. Copy `dragon.json` into this directory

#### Step 3: Verify File Placement

```powershell
Test-Path "$ENV:APPDATA\oh-my-posh\themes\dragon.json"
```

Should output: `True`

### macOS (Zsh)

#### Step 1: Create oh-my-posh Themes Directory

```bash
mkdir -p ~/.config/oh-my-posh/themes
```

#### Step 2: Copy Dragon Theme File

Navigate to the directory containing `dragon.json`, then run:

```bash
cp dragon.json ~/.config/oh-my-posh/themes/dragon.json
```

#### Step 3: Verify File Placement

```bash
ls -la ~/.config/oh-my-posh/themes/dragon.json
```

Should show the file exists with proper permissions.

### Linux (Bash)

#### Step 1: Create oh-my-posh Themes Directory

```bash
mkdir -p ~/.config/oh-my-posh/themes
```

#### Step 2: Copy Dragon Theme File

Navigate to the directory containing `dragon.json`, then run:

```bash
cp dragon.json ~/.config/oh-my-posh/themes/dragon.json
```

#### Step 3: Verify File Placement

```bash
ls -la ~/.config/oh-my-posh/themes/dragon.json
```

Should show the file exists with proper permissions.

## Activation Instructions

### Windows (PowerShell)

#### Step 1: Locate PowerShell Profile

```powershell
# Check if profile exists
Test-Path $PROFILE

# If it doesn't exist, create it
New-Item -ItemType File -Path $PROFILE -Force
```

#### Step 2: Edit PowerShell Profile

Open your PowerShell profile in your editor:

```powershell
# Using notepad (Windows)
notepad $PROFILE

# Or using your preferred editor
# code $PROFILE  (if using VS Code)
```

#### Step 3: Add oh-my-posh Initialization

Add this line to your PowerShell profile:

```powershell
oh-my-posh init pwsh --config $ENV:APPDATA\oh-my-posh\themes\dragon.json | Out-String | Invoke-Expression
```

#### Step 4: Reload Profile

Close and reopen PowerShell, or run:

```powershell
. $PROFILE
```

### macOS (Zsh)

#### Step 1: Edit Zsh Configuration

Open `~/.zshrc` in your text editor:

```bash
nano ~/.zshrc
# or
vim ~/.zshrc
# or
code ~/.zshrc  # if using VS Code
```

#### Step 2: Add oh-my-posh Initialization

Add this line to your `~/.zshrc`:

```bash
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/themes/dragon.json)"
```

Make sure this line is placed near the end of the file, after any other shell configuration.

#### Step 3: Reload Zsh Configuration

```bash
source ~/.zshrc
```

### Linux (Bash)

#### Step 1: Edit Bash Configuration

Open `~/.bashrc` in your text editor:

```bash
nano ~/.bashrc
# or
vim ~/.bashrc
# or
code ~/.bashrc  # if using VS Code
```

#### Step 2: Add oh-my-posh Initialization

Add this line to your `~/.bashrc`:

```bash
eval "$(oh-my-posh init bash --config ~/.config/oh-my-posh/themes/dragon.json)"
```

Make sure this line is placed near the end of the file, after any other shell configuration.

#### Step 3: Reload Bash Configuration

```bash
source ~/.bashrc
```

## Verification

### Visual Check

Open a new terminal window or tab. You should see:

1. **Dragon gold background** (#D4AF37) with dark text for the directory path
2. **Current directory** displayed with proper formatting
3. **Git information** (if in a git repository): Branch name with scale symbol (◆)
4. **Command status**: ✓ for successful commands (green), ✗ for failed commands (red)

### Sample Output

**In a regular directory:**
```
❯ ~/projects/oh-my-dragon
```

**In a git repository:**
```
❯ ~/projects/oh-my-dragon ⎇ main ◆
```

**After a successful command:**
```
❯ ls
[output...]
✓
```

**After a failed command:**
```
❯ command-that-fails
error: command not found
✗
```

**Long-running command (>1 second):**
```
❯ npm run build
[building...]
00:00:05.234
```

## Troubleshooting

### Theme Not Appearing

**Problem**: Terminal still shows default prompt after following installation steps

**Solutions**:

1. **Verify file location**:
   - Windows: `echo $ENV:APPDATA\oh-my-posh\themes\dragon.json`
   - macOS/Linux: `echo ~/.config/oh-my-posh/themes/dragon.json`

2. **Check shell configuration file**:
   - Ensure oh-my-posh initialization line is in the correct configuration file
   - Windows PowerShell: `$PROFILE`
   - macOS/Linux: `~/.zshrc` or `~/.bashrc`

3. **Verify oh-my-posh installation**:
   ```bash
   oh-my-posh --version
   ```
   Should show version 3.0.0 or higher

4. **Restart terminal completely**:
   - Close ALL terminal instances
   - Open a fresh terminal window
   - The new window should load the configuration

5. **Test oh-my-posh directly**:
   ```bash
   oh-my-posh init pwsh --config ~/.config/oh-my-posh/themes/dragon.json
   # or
   oh-my-posh init zsh --config ~/.config/oh-my-posh/themes/dragon.json
   ```

### Unicode Characters Showing as Boxes

**Problem**: Symbols appear as empty boxes or question marks

**Solutions**:

1. **Update terminal emulator** to the latest version:
   - Windows Terminal
   - iTerm2 (macOS)
   - GNOME Terminal (Linux)
   - Or your preferred terminal

2. **Install a Nerd Font**:
   - Download from [nerdfonts.com](https://www.nerdfonts.com/)
   - Install the font on your system
   - Set your terminal to use the Nerd Font:
     - **Windows Terminal**: Settings → Appearance → Font Face
     - **iTerm2**: Preferences → Profiles → Text → Font
     - **GNOME Terminal**: Preferences → Text Appearance

3. **Use ASCII fallback symbols**:
   If you can't use Nerd Fonts, edit `dragon.json` and change:
   - `●` (bullet) → `*`
   - `◆` (diamond) → `*`
   - `✓` (checkmark) → `OK`
   - `✗` (cross) → `FAIL`
   - `⎇` (git symbol) → `git`
   - `?` (untracked) → `?`

### Colors Look Wrong

**Problem**: Colors are not displaying correctly or look different than expected

**Solutions**:

1. **Check terminal color settings**:
   - Ensure your terminal is set to use "true color" or "24-bit color"
   - Windows Terminal: Settings → Appearance → Color scheme
   - iTerm2: Preferences → Profiles → Colors

2. **Verify terminal theme**:
   - Dragon theme is optimized for dark terminal backgrounds
   - If using a light background, colors may not contrast well
   - Consider switching to a dark terminal theme

3. **Check oh-my-posh version compatibility**:
   - Dragon theme requires oh-my-posh 3.0.0 or later
   - Upgrade oh-my-posh if using an older version:
     ```bash
     oh-my-posh upgrade
     ```

### Theme Works on One Platform but Not Another

**Problem**: Theme loads on Windows but not on macOS, or similar cross-platform issues

**Solutions**:

1. **Verify oh-my-posh installation** on all platforms:
   ```bash
   oh-my-posh --version
   ```

2. **Check shell configuration** for typos:
   - Ensure initialization line is exactly correct
   - Double-check file paths are appropriate for your platform

3. **Compare working and non-working shells**:
   - Run `echo $SHELL` to verify which shell is active
   - Ensure you edited the correct configuration file

4. **Test with sample oh-my-posh themes**:
   ```bash
   oh-my-posh init pwsh --config jandedobbeleer.omp.json
   ```
   If this works, the issue is likely with `dragon.json`

### Error: "oh-my-posh: command not found"

**Problem**: Terminal can't find oh-my-posh command

**Solutions**:

1. **Install oh-my-posh**:
   Visit [ohmyposh.dev](https://ohmyposh.dev) and follow installation instructions for your OS

2. **Add oh-my-posh to PATH**:
   - Ensure oh-my-posh binary is in your system PATH
   - Verify installation location:
     ```bash
     which oh-my-posh
     ```

3. **Restart terminal** after installation to reload PATH

## Next Steps

- [Customize the theme](customization.md) - Change colors, symbols, and segments
- [View configuration examples](examples/) - See pre-built variants
- [Back to README](../README.md) - Feature overview and quick start

## Support

For additional help:
- **oh-my-posh documentation**: https://ohmyposh.dev
- **Terminal troubleshooting**: Refer to your terminal's documentation
- **Font issues**: Check [nerdfonts.com](https://www.nerdfonts.com/) for font installation help
