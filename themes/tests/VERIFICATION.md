# Dragon Theme Verification Guide

This document outlines how to verify the Dragon oh-my-posh theme functions correctly across all platforms.

## Automated Validation

### Run JSON Validation Script
```bash
cd /path/to/oh-my-dragon/themes
bash tests/theme-validation.sh
```

Expected output:
```
✓ All JSON files are valid
✓ All required fields present in dragon.json
✓ Color palette is valid
✓ All segments properly configured
```

### Manual JSON Validation

Using Python (built-in):
```bash
python3 -m json.tool themes/dragon.json > /dev/null && echo "Valid JSON" || echo "Invalid JSON"
```

Using jq (if installed):
```bash
jq empty themes/dragon.json && echo "Valid JSON" || echo "Invalid JSON"
```

## Platform-Specific Testing

### Prerequisites
- oh-my-posh version 3.0.0 or later: `oh-my-posh --version`
- Terminal emulator with Unicode support
- Optional: Nerd Font for best symbol rendering

### Windows PowerShell

**Step 1: Install dragon.json**
```powershell
# Verify oh-my-posh installation
oh-my-posh --version

# Create themes directory
mkdir -Force $ENV:APPDATA\oh-my-posh\themes

# Copy dragon theme
Copy-Item -Path "dragon.json" -Destination "$ENV:APPDATA\oh-my-posh\themes\dragon.json"

# Verify
Test-Path "$ENV:APPDATA\oh-my-posh\themes\dragon.json"
```

**Step 2: Activate Theme**
```powershell
# Open PowerShell profile
notepad $PROFILE

# Add this line to the file:
oh-my-posh init pwsh --config $ENV:APPDATA\oh-my-posh\themes\dragon.json | Out-String | Invoke-Expression

# Reload profile
. $PROFILE
```

**Step 3: Visual Verification**
- [ ] Prompt shows gold background (#D4AF37) with dark text
- [ ] Directory path displays correctly with truncation
- [ ] Git status shows (if in git repo): branch name with ⎇ symbol
- [ ] Modified files show ● symbol (bullet)
- [ ] Staged files show ◆ symbol (diamond)
- [ ] Success status shows ✓ in green (#00AA00)
- [ ] Failure status shows ✗ in red (#FF0000)

### macOS (Zsh)

**Step 1: Install dragon.json**
```bash
# Verify oh-my-posh installation
oh-my-posh --version

# Create themes directory
mkdir -p ~/.config/oh-my-posh/themes

# Copy dragon theme
cp dragon.json ~/.config/oh-my-posh/themes/dragon.json

# Verify
ls -la ~/.config/oh-my-posh/themes/dragon.json
```

**Step 2: Activate Theme**
```bash
# Open zsh configuration
nano ~/.zshrc
# or vim ~/.zshrc
# or code ~/.zshrc

# Add this line at the end:
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/themes/dragon.json)"

# Reload configuration
source ~/.zshrc
```

**Step 3: Visual Verification**
- [ ] Prompt shows gold background (#D4AF37) with dark text
- [ ] Directory path displays correctly with truncation
- [ ] Git status shows (if in git repo): branch name with ⎇ symbol
- [ ] Modified files show ● symbol (bullet)
- [ ] Staged files show ◆ symbol (diamond)
- [ ] Success status shows ✓ in green (#00AA00)
- [ ] Failure status shows ✗ in red (#FF0000)
- [ ] Unicode symbols render correctly (not as boxes)

### Linux (Bash)

**Step 1: Install dragon.json**
```bash
# Verify oh-my-posh installation
oh-my-posh --version

# Create themes directory
mkdir -p ~/.config/oh-my-posh/themes

# Copy dragon theme
cp dragon.json ~/.config/oh-my-posh/themes/dragon.json

# Verify
ls -la ~/.config/oh-my-posh/themes/dragon.json
```

**Step 2: Activate Theme**
```bash
# Open bash configuration
nano ~/.bashrc
# or vim ~/.bashrc
# or code ~/.bashrc

# Add this line at the end:
eval "$(oh-my-posh init bash --config ~/.config/oh-my-posh/themes/dragon.json)"

# Reload configuration
source ~/.bashrc
```

**Step 3: Visual Verification**
- [ ] Prompt shows gold background (#D4AF37) with dark text
- [ ] Directory path displays correctly with truncation
- [ ] Git status shows (if in git repo): branch name with ⎇ symbol
- [ ] Modified files show ● symbol (bullet)
- [ ] Staged files show ◆ symbol (diamond)
- [ ] Success status shows ✓ in green (#00AA00)
- [ ] Failure status shows ✗ in red (#FF0000)
- [ ] Unicode symbols render correctly (not as boxes)

## Configuration Variant Testing

### Test minimal.json variant

1. **Replace configuration**: Copy `docs/examples/minimal.json` to `dragon.json`
2. **Verify behaviors**:
   - [ ] Execution time segment NOT displayed (threshold=1000ms)
   - [ ] Stash count NOT displayed
   - [ ] Upstream icon NOT displayed
   - [ ] Path, git, and status segments only

### Test extended.json variant

1. **Replace configuration**: Copy `docs/examples/extended.json` to `dragon.json`
2. **Verify behaviors**:
   - [ ] Time segment displays (HH:MM:SS format)
   - [ ] Path shows more directories (max_width=60, truncation_length=1)
   - [ ] All git information displayed (stash, upstream)
   - [ ] Execution time displays for commands >1s

### Test custom-colors.json variant

1. **Replace configuration**: Copy `docs/examples/custom-colors.json` to `dragon.json`
2. **Verify colors changed**:
   - [ ] Background is bright yellow (#FFD700) instead of gold
   - [ ] Git error state shows magenta (#FF1493)
   - [ ] Success indicator shows bright green (#00FF00)
   - [ ] Silver accent shows hot pink (#FF69B4)

## Edge Case Testing

### Long Directory Paths

1. Navigate deep in directory: `cd /tmp/test/very/long/path/with/many/directories`
2. **Verify**: Path truncates correctly, shows `...nested/directory` format
3. **With extended.json**: Shows more of path before truncating

### Special Characters in Git

1. Create branch with special characters: `git checkout -b feature/my-feature`
2. Add file with special characters: `touch "file with spaces.txt"`
3. **Verify**: Branch name and file names display correctly

### Unicode/Symbol Fallback Testing

If symbols appear as boxes:
1. Install Nerd Font: Download from [nerdfonts.com](https://www.nerdfonts.com/)
2. Configure terminal to use Nerd Font
3. Reload shell configuration
4. Symbols should render correctly

**Alternative**: Edit `dragon.json` and replace symbols with ASCII:
```json
"success_icon": "OK",      // Replace ✓
"error_icon": "FAIL",      // Replace ✗
"local_working_icon": "M", // Replace ●
"local_staged_icon": "S"   // Replace ◆
```

### Terminal Background Color Testing

Dragon theme is optimized for dark backgrounds. If using light background:
1. Colors may not contrast properly
2. Solutions:
   - Switch to dark terminal theme
   - Adjust colors in `customization.md`
   - Use alternate color scheme (e.g., custom-colors.json)

## Performance Testing

### Prompt Responsiveness

1. Enter large git repository (100+ files changed)
2. **Verify**: Prompt renders within 1-2 seconds
3. If slow: Check git status with `git status --porcelain`

### Command Execution Time Display

1. Run slow command: `sleep 2`
2. **Verify**: Execution time shows "00:00:02.xxx"
3. Run quick command (<1s): `echo "test"`
4. **Verify**: No execution time displayed (below 1s threshold)

## Troubleshooting Checklist

### Theme Not Appearing

- [ ] Verify dragon.json in correct location
  - Windows: `$ENV:APPDATA\oh-my-posh\themes\dragon.json`
  - macOS/Linux: `~/.config/oh-my-posh/themes/dragon.json`
- [ ] Check shell configuration file was edited correctly
  - Windows PowerShell: `$PROFILE` (verify line present with `Get-Content $PROFILE`)
  - macOS/Linux: `~/.zshrc` or `~/.bashrc` (verify line present)
- [ ] Reload shell completely (close and reopen terminal)
- [ ] Verify oh-my-posh installation: `oh-my-posh --version`

### Colors Look Wrong

- [ ] Check terminal color support: `echo $TERM` (should be xterm-256color or truecolor)
- [ ] Verify dark terminal background is set
- [ ] Check terminal's true color support in settings
- [ ] Try alternative color variant (custom-colors.json)

### Symbols Show as Boxes

- [ ] Install Nerd Font
- [ ] Configure terminal to use Nerd Font
- [ ] Reload shell configuration
- [ ] If no Nerd Font available: Use ASCII fallback symbols

### Slow Performance

- [ ] Check git status: `git status --porcelain`
- [ ] Consider using minimal.json variant
- [ ] Disable unused git display options in customization

## Success Criteria

All of the following should be true for successful verification:

✅ **JSON Validation**
- dragon.json parses without errors
- All configuration files have valid JSON

✅ **Visual Appearance**
- Gold background (#D4AF37) with dark text displays
- Directory path shows correctly
- Git information displays in repositories
- Command status indicators (✓/✗) work

✅ **Platform Compatibility**
- Works on Windows PowerShell
- Works on macOS Zsh
- Works on Linux Bash

✅ **Configuration Variants**
- minimal.json loads and displays correctly
- extended.json loads and displays correctly
- custom-colors.json loads and displays correctly

✅ **Documentation**
- All links in markdown files are valid
- Installation instructions follow current standards
- Customization guide examples are accurate

## Reporting Issues

If verification fails:

1. **Collect information**:
   - Platform and shell (Windows PowerShell, macOS Zsh, Linux Bash)
   - oh-my-posh version: `oh-my-posh --version`
   - Terminal emulator name and version
   - Font in use
   - JSON validation output: `python3 -m json.tool dragon.json`

2. **Check troubleshooting section** above

3. **Review logs**:
   - Windows: `$PROFILE` contents
   - Unix: `~/.zshrc` or `~/.bashrc` contents

4. **Verify against schema**: Check `specs/001-dragon-theme/contracts/theme-schema.json`
