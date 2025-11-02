# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**oh-my-dragon** is an oh-my-posh terminal theme featuring dragon-inspired aesthetics with brilliant gold (#FFD700), flame orange (#FF6E3A), and deep crimson (#8B0000) colors. The theme provides cross-platform support for Windows (PowerShell), macOS (Zsh), and Linux (Bash).

## Architecture

### Core Structure
```
themes/
├── dragon.omp.json          # Main theme configuration (oh-my-posh JSON schema)
├── docs/                    # Installation and customization guides
│   ├── installation.md
│   ├── customization.md
│   └── examples/           # Theme variants (minimal, extended, custom-colors)
└── tests/
    └── theme-validation.sh  # Validation script for JSON syntax and schema

specs/001-dragon-theme/      # Feature specification and planning
├── spec.md                  # Full feature specification
├── plan.md                  # Implementation plan
├── tasks.md                 # Task breakdown
├── data-model.md            # Theme data structure
└── contracts/
    └── theme-schema.json    # JSON schema for validation
```

### Theme Configuration Format

The `dragon.omp.json` file follows the oh-my-posh schema v2 format with these key components:

1. **Color Palette**: Defines dragon-themed colors (dragon_gold, dragon_red, flame_orange, etc.)
2. **Blocks**: Left prompt, right prompt (rprompt), transient prompt, secondary prompt
3. **Segments**: Modular prompt components (path, git, status, executiontime, python, node, etc.)
4. **Properties**: Segment-specific configurations (max_width, truncation_length, icons, templates)

## Common Commands

### Theme Validation
```bash
# Validate theme JSON syntax and structure
bash themes/tests/theme-validation.sh

# Validate specific theme file
bash themes/tests/theme-validation.sh path/to/theme.json
```

The validation script checks:
- JSON syntax validity (via jq or python3)
- Required fields ($schema, version, blocks)
- Color palette completeness
- Essential segments (path, git, status)
- Optional segments (executiontime)
- Schema compliance (if ajv-cli installed)

### Theme Testing
```bash
# Test theme locally before installation
oh-my-posh print primary --config themes/dragon.omp.json

# Test specific segments
oh-my-posh print primary --config themes/dragon.omp.json --segment path
oh-my-posh print primary --config themes/dragon.omp.json --segment git
```

### Installation
```bash
# macOS/Linux
mkdir -p ~/.config/oh-my-posh/themes
cp themes/dragon.omp.json ~/.config/oh-my-posh/themes/dragon.json

# Apply theme
eval "$(oh-my-posh init bash --config ~/.config/oh-my-posh/themes/dragon.json)"
```

## Development Guidelines

### Theme Modifications

When modifying the theme configuration:

1. **Color Changes**: Update the `colors` object at the root level, not inline hex codes
2. **Segment Changes**: Modify segments within their respective blocks (left, right, transient)
3. **Template Syntax**: Use oh-my-posh template syntax: `{{ .Property }}` for dynamic values
4. **Icon Usage**: Prefer Unicode emojis over Nerd Font icons for cross-platform compatibility

### Validation Requirements

Before committing theme changes:
1. Run `bash themes/tests/theme-validation.sh` to ensure JSON validity
2. Test theme rendering with `oh-my-posh print primary --config themes/dragon.omp.json`
3. Verify all segments display correctly (path, git, status, etc.)
4. Check color consistency across all segments

### JSON Schema Compliance

The theme must adhere to oh-my-posh schema v2:
- `$schema`: Must reference official oh-my-posh schema
- `version`: Schema version (currently 2)
- `blocks`: Array of prompt blocks (alignment: left/right)
- `segments`: Array within each block defining prompt components

Critical segment types:
- `path`: Directory display with truncation support
- `git`: Git repository status with branch/changes indicators
- `status`: Command execution status (success/error icons)
- `executiontime`: Command duration display (optional)

### Color Palette Standards

Dragon theme color definitions (maintain consistency):
```json
{
  "dragon_gold": "#FFD700",      // Primary accent
  "dragon_red": "#8B0000",       // Status/dividers
  "flame_orange": "#FF6E3A",     // Accent highlights
  "ember_peach": "#FF8266",      // Path background
  "arcane_violet": "#8A2BE2",    // Git background
  "verdant_scale": "#66FF66",    // Runtime backgrounds
  "dragon_dark": "#1A1A1A"       // Dark text
}
```

## Dependencies

- **oh-my-posh**: v3.0.0 or later (required)
- **jq**: For JSON validation (optional but recommended)
- **python3**: Fallback JSON validation if jq unavailable
- **ajv-cli**: For schema validation (optional)

## Cross-Platform Considerations

- **File Extensions**: Use `.omp.json` for oh-my-posh theme files (not `.json`)
- **Path Separators**: oh-my-posh handles path separators automatically (no manual conversion)
- **Shell Integration**: Theme works identically across bash, zsh, and PowerShell
- **Unicode Support**: Terminal must support Unicode for emoji display

## Related Documentation

- Main README: Project overview and installation instructions
- `themes/README.md`: Theme-specific documentation and quick start
- `themes/docs/installation.md`: Platform-specific installation details
- `themes/docs/customization.md`: Configuration reference and examples
- `specs/001-dragon-theme/spec.md`: Complete feature specification

## Notes for AI Assistants

- The project uses **no build system** - it's pure JSON configuration files
- **No npm/pip dependencies** required - oh-my-posh is the only runtime dependency
- Theme validation is **bash-based** using `jq` or Python's `json.tool`
- When modifying themes, always preserve the dragon aesthetic (gold, red, orange color scheme)
- Test changes with `oh-my-posh print` before committing - rendering issues may not be caught by JSON validation alone
