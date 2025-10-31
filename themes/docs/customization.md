# Customization Guide: Dragon oh-my-posh Theme

This guide explains how to customize the Dragon theme without requiring technical expertise. All customization is done through JSON editing in `dragon.json`.

## Table of Contents

1. [Getting Started](#getting-started)
2. [Color Customization](#color-customization)
3. [Symbol Customization](#symbol-customization)
4. [Segment Configuration](#segment-configuration)
5. [Advanced Customization](#advanced-customization)
6. [Configuration Examples](#configuration-examples)
7. [Validation](#validation)

## Getting Started

### Prerequisites

- A text editor (VS Code, Sublime, Atom, Notepad, vim, etc.)
- The Dragon theme file: `dragon.json`
- Basic understanding of JSON format

### Step-by-Step Process

1. **Backup original**: `cp dragon.json dragon.json.backup`
2. **Open file**: Edit `~/.config/oh-my-posh/themes/dragon.json` (or appropriate path for your OS)
3. **Make changes**: Modify desired properties
4. **Save file**: Save changes in your editor
5. **Reload shell**: Close and reopen terminal, or run:
   - macOS/Linux: `source ~/.zshrc` or `source ~/.bashrc`
   - Windows: Close and reopen PowerShell

## Color Customization

### Color Palette Overview

The Dragon theme uses a named color system. All color values are hexadecimal codes in the format `#RRGGBB`.

**Default Dragon Colors**:

```json
"colors": {
  "dragon_gold": "#D4AF37",      // Primary accent - directory background
  "dragon_red": "#8B0000",        // Error/warning color
  "dragon_silver": "#C0C0C0",     // Secondary accent
  "dragon_dark": "#1a1a1a",       // Text color on light backgrounds
  "dragon_emerald": "#1B4D3E",    // Eye color detail
  "success": "#00AA00",           // Git clean/success status
  "error": "#FF0000"              // Command failure/error
}
```

### Common Color Customization

#### Change Primary Color (Background)

Find the `colors` section and modify `dragon_gold`:

```json
"colors": {
  "dragon_gold": "#FFD700"        // Brighter/lighter gold
}
```

**Recommended alternatives**:
- `#FFD700` - Bright gold (more luminous)
- `#B8860B` - Darker gold (more subdued)
- `#FFA500` - Orange-gold (warm)
- `#FFEB3B` - Yellow-gold (bright)

#### Change Error Color (Red)

Find the `colors` section and modify `dragon_red`:

```json
"colors": {
  "dragon_red": "#FF0000"         // Pure red
}
```

**Recommended alternatives**:
- `#FF0000` - Pure red (bright)
- `#DC143C` - Crimson (darker)
- `#FF6347` - Tomato (lighter)
- `#A52A2A` - Dark red (subdued)

#### Create Custom Color Scheme

For a completely custom theme, modify all colors:

```json
"colors": {
  "dragon_gold": "#4169E1",       // Royal blue
  "dragon_red": "#FF1493",        // Deep pink
  "dragon_silver": "#87CEEB",     // Sky blue
  "dragon_dark": "#1a1a1a",       // Keep dark for text contrast
  "dragon_emerald": "#20B2AA",    // Light sea green
  "success": "#00FF00",           // Bright green
  "error": "#FF0000"              // Bright red
}
```

#### Ensure Color Contrast

When customizing colors, ensure:
- **Foreground text** has sufficient contrast against **background**
- Recommended contrast ratio: 4.5:1 (WCAG AA standard)
- Test with actual prompt before finalizing

## Symbol Customization

### Change Success/Error Symbols

Find the `status` segment and modify properties:

```json
{
  "type": "status",
  "properties": {
    "success_icon": "✔",          // Change from ✓
    "error_icon": "✘"             // Change from ✗
  }
}
```

**Symbol alternatives**:

| Purpose | Current | Alternative 1 | Alternative 2 | ASCII |
|---------|---------|----------------|---------------|-------|
| Success | ✓ | ✔ | OK | OK |
| Error | ✗ | ✘ | FAIL | FAIL |
| Modified | ● | ◉ | * | * |
| Staged | ◆ | ▲ | * | * |
| Untracked | ? | ! | ? | ? |

### Change Git Status Symbols

Find the `git` segment properties:

```json
{
  "type": "git",
  "properties": {
    "local_working_icon": "●",    // Modified files
    "local_staged_icon": "◆",     // Staged files
    "untracked_count_icon": "?"   // Untracked files
  }
}
```

**Example: Using simpler symbols**:

```json
{
  "type": "git",
  "properties": {
    "local_working_icon": "M",
    "local_staged_icon": "S",
    "untracked_count_icon": "U"
  }
}
```

### Change Directory Symbol (Powerline)

Find the `path` segment:

```json
{
  "type": "path",
  "powerline_symbol": "►",        // Change from ◆
  "properties": {
    "folder_separator_icon": "/"  // Change path separator
  }
}
```

**Powerline symbol alternatives**:
- `►` - Triangle right
- `▶` - Filled triangle
- `❯` - Chevron
- `→` - Arrow
- `|` - Pipe

### Change Folder Separator

Edit the `folder_separator_icon` in path segment properties:

```json
{
  "type": "path",
  "properties": {
    "folder_separator_icon": "•"  // Bullet separator
  }
}
```

**Separator alternatives**:
- `/` - Forward slash (default)
- `•` - Bullet
- `→` - Arrow
- `∕` - Mathematical slash
- `|` - Pipe

## Segment Configuration

### Path Truncation (Directory Display)

Edit the `path` segment properties:

```json
{
  "type": "path",
  "properties": {
    "max_width": 40,              // Characters before truncation
    "truncation_length": 3,       // Directories shown when truncated
    "truncate_from_left": false   // false = keep end, true = keep beginning
  }
}
```

**Examples**:

```json
// Short paths: /home/user/project → ~/project
"max_width": 25,
"truncation_length": 2

// Long paths: /home/user/projects/deeply/nested/directory → ~/nested/directory
"max_width": 50,
"truncation_length": 2,
"truncate_from_left": false

// Truncate from left: /home/user/projects/a/b/c/d/e → .../a/b/c/d/e
"truncate_from_left": true
```

### Show/Hide Segments

To remove a segment, delete its entire block from the `segments` array.

**Remove execution time segment**:

```json
// BEFORE (4 segments)
"segments": [
  { "type": "path", ... },
  { "type": "git", ... },
  { "type": "status", ... },
  { "type": "executiontime", ... }  // DELETE THIS BLOCK
]

// AFTER (3 segments)
"segments": [
  { "type": "path", ... },
  { "type": "git", ... },
  { "type": "status", ... }
]
```

### Adjust Git Display Options

Fine-tune git segment behavior:

```json
{
  "type": "git",
  "properties": {
    "display_stash_count": true,        // Show stashed changes count
    "display_upstream_icon": true,      // Show tracking branch status
    "ignore_submodules": false,         // Include submodules in status
    "ahead_and_behind_count_enabled": true  // Show ahead/behind count
  }
}
```

### Customize Execution Time Display

Edit the `executiontime` segment:

```json
{
  "type": "executiontime",
  "properties": {
    "threshold": 1000,                  // Only show if > 1000ms (1 second)
    "style": "austin",                  // Display format
    "format": "{0:hh\\\\:mm\\\\:ss.fff}"  // HH:MM:SS.fff format
  }
}
```

**Alternative thresholds**:
- `500` - Show commands >0.5 seconds
- `2000` - Show commands >2 seconds
- `5000` - Show commands >5 seconds

**Alternative formats**:
- `{0:mm\\\\:ss}` - MM:SS
- `{0:ss}` - Seconds only
- `{0:mm\\\\:ss.ff}` - MM:SS.ff (two decimals)

## Advanced Customization

### Conditional Colors (Status Templates)

The Dragon theme uses `foreground_templates` for intelligent color switching:

```json
{
  "type": "git",
  "foreground_templates": [
    "{{ if or (.Working.Changed) (.Staging.Changed) }}#1a1a1a{{ else if .UpstreamGone }}#FF0000{{ else if gt .Behind 0 }}#FF0000{{ else }}#00AA00{{ end }}"
  ]
}
```

This means:
- Modified/staged files → dark text
- Diverged from remote → red
- Behind remote → red
- Clean → green

### Changing Status Template Colors

To change colors based on git state:

**Make errors more visible** (brighter red):

```json
"foreground_templates": [
  "{{ if or (.Working.Changed) (.Staging.Changed) }}#FF00FF{{ else if .UpstreamGone }}#FF0000{{ else if gt .Behind 0 }}#FF0000{{ else }}#00FF00{{ end }}"
]
```

### Add Time Segment

To show current time in the prompt:

1. Find the `segments` array
2. Add this block at the end (before closing bracket):

```json
{
  "type": "time",
  "style": "diamond",
  "foreground": "#1a1a1a",
  "background": "#C0C0C0",
  "properties": {
    "time_format": "15:04:05"
  }
}
```

**Alternative time formats**:
- `"15:04:05"` - 24-hour HH:MM:SS (default)
- `"3:04:05 PM"` - 12-hour with AM/PM
- `"15:04"` - 24-hour HH:MM only
- `"January 2"` - Date format

## Configuration Examples

### Example 1: Minimal Professional Theme

Minimal segments, neutral colors:

```json
{
  "colors": {
    "dragon_gold": "#808080",
    "dragon_dark": "#1a1a1a",
    "success": "#008000",
    "error": "#FF0000"
  },
  "segments": [
    {
      "type": "path",
      "background": "#808080",
      "properties": {
        "max_width": 50,
        "truncation_length": 2
      }
    },
    {
      "type": "git",
      "background": "#808080",
      "properties": {
        "display_stash_count": false,
        "display_upstream_icon": false
      }
    },
    {
      "type": "status"
    }
  ]
}
```

### Example 2: Vibrant Neon Theme

Bright, high-contrast colors:

```json
{
  "colors": {
    "dragon_gold": "#00FF00",
    "dragon_red": "#FF00FF",
    "success": "#00FFFF",
    "error": "#FF0000"
  }
}
```

### Example 3: Ocean Theme

Cool blue tones:

```json
{
  "colors": {
    "dragon_gold": "#0077BE",       // Ocean blue
    "dragon_red": "#FF006E",        // Magenta
    "dragon_silver": "#4DD0E1",     // Light cyan
    "success": "#00FF88",           // Green
    "error": "#FF4444"              // Red
  }
}
```

### Example 4: ASCII-Only Symbols

For terminals without Unicode:

```json
// In status segment:
"success_icon": "OK",
"error_icon": "FAIL",

// In git segment:
"local_working_icon": "M",
"local_staged_icon": "S",
"untracked_count_icon": "U",

// In path segment:
"folder_separator_icon": "/"
```

## Validation

### Before You Save

**Always validate JSON syntax!**

#### Using Online Tool
1. Copy your `dragon.json` content
2. Visit [jsonlint.com](https://www.jsonlint.com/)
3. Paste content and click "Validate"
4. Fix any reported errors

#### Using Command Line (if jq installed)

```bash
jq empty ~/path/to/dragon.json
echo $?  # Output 0 = valid, 1 = invalid
```

#### Using Python

```bash
python3 -m json.tool ~/path/to/dragon.json > /dev/null && echo "Valid JSON"
```

### After You Save

1. **Reload shell**: `source ~/.zshrc` or close/reopen terminal
2. **Check for errors**: Any JSON errors should show in terminal output
3. **Visual inspection**: Verify colors and symbols display correctly
4. **Test scenarios**:
   - Regular directory → colors render
   - Git repository → branch displays correctly
   - Failed command → error symbol shows with correct color
   - Long command → execution time displays if >1 second

### Rollback If Needed

If customization causes problems:

```bash
# Restore backup
cp ~/.config/oh-my-posh/themes/dragon.json.backup ~/.config/oh-my-posh/themes/dragon.json

# Reload
source ~/.zshrc
```

## Need More Help?

- **Color Picker**: [colorhexa.com](https://www.colorhexa.com/) - Find colors by name
- **Symbol Reference**: Search "Unicode symbols" for alternatives
- **JSON Validator**: [jsonlint.com](https://www.jsonlint.com/) - Validate before saving
- **oh-my-posh Documentation**: [ohmyposh.dev](https://ohmyposh.dev) - Official reference
- **Theme Examples**: Check `examples/` directory for pre-built variants

## Next Steps

- [Installation Guide](installation.md) - Setup instructions
- [Back to README](../README.md) - Feature overview
- [View Examples](examples/) - Pre-configured variants
