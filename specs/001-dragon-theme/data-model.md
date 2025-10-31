# Phase 1: Data Model & Schema

**Feature**: Dragon oh-my-posh Theme
**Date**: 2025-10-31
**Status**: Complete - configuration-driven theme with no backend data model

## Overview

The Dragon theme is a configuration-only deliverable with no persistent data storage or complex data model. All configuration is stateless and file-based. This document describes the configuration structure and how data flows through the theme.

## Configuration Entity: DragonTheme

**Type**: JSON Configuration Object
**Location**: `themes/dragon.json` (user installations: `~/.config/oh-my-posh/themes/dragon.json`)
**Purpose**: Complete theme definition for oh-my-posh prompt rendering

### Schema Structure

```json
{
  "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
  "version": "1.0.0",
  "final": true,
  "console_title_template": "{{ .Shell }} ~ {{ .Folder }}",
  "console_title_true_color_template": "{{ .Shell }} ~ {{ .Folder }}",
  "accent_color": "#D4AF37",
  "colors": {
    "dragon_gold": "#D4AF37",
    "dragon_red": "#8B0000",
    "dragon_silver": "#C0C0C0",
    "dragon_dark": "#1a1a1a",
    "dragon_emerald": "#1B4D3E",
    "success": "#00AA00",
    "error": "#FF0000"
  },
  "segments": [
    { "segment": "directory", ... },
    { "segment": "git", ... },
    { "segment": "status", ... },
    { "segment": "execution_time", ... }
  ],
  "transient": false,
  "scan_folders": []
}
```

### Core Configuration Properties

| Property | Type | Example | Purpose |
|----------|------|---------|---------|
| `$schema` | string | URL to oh-my-posh schema | Validates configuration format |
| `version` | string | "1.0.0" | Theme version for tracking updates |
| `final` | boolean | true | Prevent oh-my-posh from modifying prompt |
| `accent_color` | string | "#D4AF37" | Primary dragon gold color |
| `colors` | object | {theme colors} | Named color definitions for reuse |
| `segments` | array | [segment definitions] | Prompt information elements |
| `transient` | boolean | false | Display transient prompt on Enter |
| `scan_folders` | array | [] | Folders to scan for context |

## Segment Definitions

### Segment 1: Directory

**Purpose**: Display current working directory
**Renderer**: Built-in oh-my-posh directory segment

**Configuration**:
```json
{
  "type": "path",
  "style": "diamond",
  "powerline_symbol": "◆",
  "foreground": "#1a1a1a",
  "background": "#D4AF37",
  "properties": {
    "folder_separator_icon": "/",
    "home_icon": "~",
    "truncation_length": 3,
    "max_width": 40,
    "truncate_from_left": false
  }
}
```

**Properties**:
- **folder_separator_icon**: Path separator displayed between directories
- **home_icon**: Symbol for home directory
- **truncation_length**: Show last N directories if path exceeds max_width
- **max_width**: Maximum characters before truncation (40 chars to fit standard 80-char width)
- **truncate_from_left**: Keep end of path if truncated (False = keep start)

**Validation Rules**:
- max_width >= 20 (minimum functional width)
- truncation_length >= 1 (at least one directory shown)
- foreground/background must be valid colors

### Segment 2: Git

**Purpose**: Display git repository information
**Renderer**: Built-in oh-my-posh git segment

**Configuration**:
```json
{
  "type": "git",
  "style": "powerline",
  "powerline_symbol": "⎇",
  "foreground": "#1a1a1a",
  "background": "#D4AF37",
  "properties": {
    "display_stash_count": true,
    "display_upstream_icon": true,
    "untracked_count_icon": "?",
    "ignore_submodules": false,
    "local_working_icon": "●",
    "local_staged_icon": "◆",
    "status_formats": {
      "ahead": "↑ %d",
      "behind": "↓ %d",
      "diverged": "↕ %d,%d"
    }
  }
}
```

**Properties**:
- **display_stash_count**: Show stashed changes count
- **display_upstream_icon**: Show tracking branch status
- **untracked_count_icon**: Symbol for untracked files (dragon scale: ◆ or ?: ?)
- **local_working_icon**: Symbol for modified files (bullet: ●)
- **local_staged_icon**: Symbol for staged files (scale: ◆)

**Validation Rules**:
- ignore_submodules: boolean
- Icons must be single character or valid Unicode symbol
- Status format strings must contain placeholder for count

**Color States**:
- Clean repository: Green (#00AA00) + gold background
- Working changes: Gold (#D4AF37) + dark background
- Errors/conflicts: Red (#8B0000) + dark background

### Segment 3: Status (Command Execution)

**Purpose**: Display command execution result
**Renderer**: Built-in oh-my-posh status segment

**Configuration**:
```json
{
  "type": "status",
  "style": "diamond",
  "foreground_templates": [
    "{{ if eq .Code 0 }}#00AA00{{ else }}#FF0000{{ end }}"
  ],
  "properties": {
    "status_separator_icon": "|",
    "success_icon": "✓",
    "error_icon": "✗"
  }
}
```

**Properties**:
- **success_icon**: Symbol shown when command succeeds
- **error_icon**: Symbol shown when command fails
- **foreground_templates**: Color based on exit code (0=success, non-zero=error)

**Validation Rules**:
- Icons must clearly distinguish success from failure
- Colors must have sufficient contrast for visibility

### Segment 4: Execution Time

**Purpose**: Display how long command took to execute
**Renderer**: Built-in oh-my-posh execution_time segment

**Configuration**:
```json
{
  "type": "executiontime",
  "style": "diamond",
  "foreground": "#1a1a1a",
  "background": "#8B0000",
  "properties": {
    "style": "austin",
    "threshold": 1000,
    "format": "{0:hh\\:mm\\:ss.fff}"
  }
}
```

**Properties**:
- **style**: Display format (austin = "HH:mm:ss.fff")
- **threshold**: Only show if command took > N milliseconds (1000ms = 1 second)
- **format**: Time format string following .NET conventions

**Validation Rules**:
- threshold >= 100ms (don't show trivial execution times)
- threshold <= 300000ms (don't hide important slow commands)

## Color Palette Specification

### Primary Colors

| Name | Hex Code | RGB | Usage |
|------|----------|-----|-------|
| Dragon Gold | #D4AF37 | 212, 175, 55 | Primary accent, scales, highlights |
| Dragon Red | #8B0000 | 139, 0, 0 | Errors, warnings, execution time |
| Dragon Silver | #C0C0C0 | 192, 192, 192 | Secondary accent, contrast |
| Dragon Dark | #1a1a1a | 26, 26, 26 | Text on light backgrounds |
| Dragon Emerald | #1B4D3E | 27, 77, 62 | Eye color, mystique accent |

### Utility Colors

| Name | Hex Code | Usage |
|------|----------|-------|
| Success Green | #00AA00 | Git clean status, successful commands |
| Error Red | #FF0000 | Failed commands, conflict status |
| Neutral Gray | #808080 | Disabled elements, secondary info |

## Configuration Variants

### Variant 1: Minimal (minimal.json)

Reduced segments, essential information only:
- Directory
- Git branch (name only, no status details)
- Status (success/error only)

**Use Case**: Users with small terminal windows or preference for minimal prompts

### Variant 2: Extended (extended.json)

Full segments with all details:
- Directory (with full path, no truncation)
- Git (all status indicators, stash count, upstream status)
- Status (with error codes)
- Execution time
- Additional: Time segment showing current time

**Use Case**: Power users, debugging, detailed context

### Variant 3: Custom Colors (custom-colors.json)

Same segment structure as default but with custom color palette:
- Alternative primary color (e.g., #FFD700 for brighter gold)
- Alternative accent (e.g., #FF1493 for magenta)
- Maintains dragon aesthetic while matching user preferences

**Use Case**: Users with specific terminal color schemes or accessibility needs

## Runtime Data Flow

### Prompt Rendering Flow

```
1. Shell invokes oh-my-posh with configuration
2. oh-my-posh loads dragon.json theme
3. For each segment in order:
   a. Gather context (directory, git status, command exit code, execution time)
   b. Apply styling (colors, symbols, formatting)
   c. Render segment using style template
4. Concatenate all segments
5. Render to terminal with color codes
```

### Context Data Captured Per Segment

| Segment | Data Captured | Source |
|---------|--------------|--------|
| Directory | Current working directory path | Environment variable $PWD |
| Git | Branch name, file status, remote tracking | `.git` directory metadata |
| Status | Command exit code, execution result | Shell environment $? |
| Execution Time | Duration of last command | oh-my-posh built-in timing |

## State & Transitions

**Theme State**: No stateful transitions. Theme is stateless - always renders based on current environment state.

**Configuration State**:
- User selects one configuration file (e.g., dragon.json)
- oh-my-posh loads it on every prompt render
- No caching or in-memory state persistence
- Config can be modified and changes take effect on next prompt

## Fallback & Degradation

### Limited Terminal Support

When terminal lacks Unicode support or colors:

| Element | Full Support | Fallback |
|---------|--------------|----------|
| Dragon symbol 🐉 | Rendered | "D" or "[DRG]" |
| Scales ◆ | Rendered | "*" |
| Success ✓ | Rendered | "OK" |
| Error ✗ | Rendered | "FAIL" |
| Colors | 16M colors (true color) | 256 colors or 16 colors |

**Fallback Strategy**:
- Define ASCII-safe versions of all Unicode symbols
- Use monochrome alternatives if color not available
- Maintain readability and information hierarchy

## Validation & Constraints

### Configuration Validation Rules

1. **JSON Format**: Must be valid JSON (checked by validation script)
2. **Schema Compliance**: Must match oh-my-posh schema
3. **Color Validity**: All hex colors must be valid (#RRGGBB format)
4. **Symbol Validity**: All symbols must be single character or valid Unicode
5. **Property Ranges**: Numeric properties must be within valid ranges
6. **Required Fields**: All required oh-my-posh fields present

### Installation Validation Rules

1. **File Location**: Theme file in correct oh-my-posh themes directory
2. **File Permissions**: File readable by oh-my-posh process
3. **oh-my-posh Version**: Compatible version installed (3.x+)
4. **Shell Configuration**: oh-my-posh referenced in shell config file

## Change Management

### Adding New Segments

To add segments beyond core 4:
1. Ensure oh-my-posh segment type is available in version 3.x+
2. Define colors that fit dragon aesthetic
3. Add segment definition to configuration
4. Update documentation with purpose and customization options
5. Include example in variant configuration files

### Updating Colors

If colors need adjustment:
1. Maintain contrast and readability
2. Keep dragon aesthetic (golds, reds, metallics)
3. Test in light and dark terminal themes
4. Update color palette table in documentation

### Modifying Symbols

If changing Unicode symbols:
1. Ensure new symbols have ASCII fallbacks
2. Test rendering across platforms
3. Update symbol definition table
4. Provide migration path for users with custom configs

## Summary

The Dragon theme data model is minimal and stateless, consisting entirely of configuration:
- **Single configuration file** (dragon.json): All theme styling and structure
- **No backend data**: Theme doesn't store or retrieve user data
- **No state management**: Theme is stateless, renders current environment state
- **Configuration-driven**: All customization through JSON editing
- **Variant templates**: Multiple example configurations for different use cases

This lightweight approach aligns with oh-my-posh's philosophy and ensures cross-platform compatibility, easy installation, and simple customization.
