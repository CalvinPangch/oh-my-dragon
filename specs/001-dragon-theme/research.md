# Phase 0: Research & Design Decisions

**Feature**: Dragon oh-my-posh Theme
**Date**: 2025-10-31
**Status**: Complete - no blocking clarifications, all design decisions made

## Research Topics

### 1. Oh-my-posh Theme Architecture & Format

**Decision**: Use oh-my-posh JSON configuration format (standard theme format)

**Rationale**:
- oh-my-posh 3.x+ uses JSON for all theme configuration
- JSON is human-readable and widely understood by developers
- Official oh-my-posh documentation provides clear schema and examples
- JSON supports all required features: segments, colors, symbols, conditional rendering

**Alternatives Considered**:
- YAML: More readable but oh-my-posh doesn't officially support YAML themes
- TOML: Also readable but not used by oh-my-posh ecosystem
- Direct PowerShell/Bash scripting: Would require platform-specific implementations, reducing portability

**Implementation Details**:
- Theme will be a single `dragon.json` configuration file
- Must conform to oh-my-posh schema for segments, colors, and properties
- Will leverage built-in oh-my-posh segments: directory, git, status, execution_time, time
- Custom segment styling will define dragon aesthetic through colors and symbols

### 2. Dragon Aesthetic Design

**Decision**: Use metallic dragon colors (golds, reds, silvers) with scale/diamond visual patterns

**Rationale**:
- Metallic colors (golds #D4AF37, reds #8B0000, silvers #C0C0C0) evoke dragon power and mystique
- Dragon scales suggest strength and layered complexity
- These colors work well in both dark and light terminal themes
- Visual patterns (diamond, triangles) reference dragon scales without requiring special fonts

**Color Palette**:
- **Primary Gold**: #D4AF37 (imperial gold, dragon scales)
- **Dragon Red**: #8B0000 (deep crimson, dragon fire)
- **Silver/Platinum**: #C0C0C0 (metallic contrast)
- **Dark Dragon**: #1a1a1a (dark background for contrast)
- **Accent Emerald**: #1B4D3E (dragon eye mystique)

**Symbols**:
- **Dragon Symbol**: 🐉 (U+1F409) for theme indicator
- **Scale Pattern**: ◆ (U+25C6) for visual structure
- **Fire Symbol**: ⚡ (U+26A1) for execution/active status
- **Git Indicator**: ⎇ (U+2387) for branch information
- **Success**: ✓ (U+2713) for success status
- **Error**: ✗ (U+2717) for failure status

**Alternatives Considered**:
- Pure purple/blue: Less "dragon-like", more generic
- Bright neon colors: Hard to read, less professional
- Complex Unicode symbols: Some terminals don't support, reduces compatibility

### 3. Segment Architecture

**Decision**: Implement 4 core segments with optional extensions

**Rationale**:
- Core segments address P1 requirements (directory, git, execution status/time)
- Optional segments allow for P2/P3 customization without mandatory complexity
- Matches oh-my-posh best practices for theme design

**Core Segments** (mandatory):
1. **Directory Segment**: Current working directory with truncation for long paths
   - Shows full path or home-abbreviated path
   - Truncates if >40 characters
   - Uses dragon-themed styling

2. **Git Segment**: Repository status when in git directory
   - Branch name with scale symbol prefix
   - Status indicators: modified (●), staged (◆), untracked (?)
   - Color coding: clean (green), dirty (gold), error (red)

3. **Status Segment**: Last command execution result
   - Shows ✓ for success (green + gold)
   - Shows ✗ for failure (red)
   - Optional execution time

4. **Time/Command Duration**: Execution time for long-running commands
   - Shows only if command took >1 second
   - Format: "1.23s" or "12.5s"
   - Styled with dragon accent color

**Alternatives Considered**:
- Single monolithic segment: Harder to customize, less flexibility
- Too many segments: Reduces clarity, makes prompt cluttered
- Different segment ordering: Current order (path → git → status → time) follows left-to-right information flow

### 4. Configuration & Customization

**Decision**: Configuration-driven customization via JSON editing (no code changes required)

**Rationale**:
- Users can customize without technical background
- JSON is self-documenting with clear key-value pairs
- Aligns with oh-my-posh's approach to user configuration
- Enables users to create variants while respecting dragon aesthetic

**Customizable Elements**:
- Color overrides (while maintaining theme identity)
- Symbol selection (alternative symbols for same semantic meaning)
- Segment visibility toggle
- Path truncation length
- Git status symbols

**Alternatives Considered**:
- Code-based customization: Requires programming knowledge, breaks theme portability
- GUI configuration tool: Out of scope, would add complexity
- Hardcoded single theme: No flexibility, doesn't meet P2 requirements

### 5. Installation & Distribution

**Decision**: File-based distribution in repository themes/ directory with setup instructions

**Rationale**:
- Simple copy-paste or installation script approach
- No external package manager dependency
- Works across all OS/shell combinations
- Aligns with how oh-my-posh community shares themes
- Supports both automatic (script) and manual (copy) installation

**Distribution Method**:
- Primary file: `themes/dragon.json`
- Installation script: Copy to user's oh-my-posh themes directory
- Platform-specific instructions for Windows, macOS, Linux
- Clear fallback instructions if script fails

**Installation Targets**:
- **Windows PowerShell**: `$PROFILE/../oh-my-posh/themes/dragon.json`
- **macOS Zsh**: `~/.config/oh-my-posh/themes/dragon.json`
- **Linux Bash**: `~/.config/oh-my-posh/themes/dragon.json`

**Alternatives Considered**:
- NPM package: Requires Node.js, adds unnecessary dependency
- Package manager (Homebrew, apt): Theme is too small to justify inclusion
- Online registry: Would require central infrastructure
- Git submodule: Over-engineered for single file

### 6. Cross-Platform Compatibility

**Decision**: Test and support 3 primary OS/shell combinations with fallback glyphs

**Rationale**:
- Covers 95%+ of developer environments
- PowerShell (Windows) + Zsh (macOS) + Bash (Linux) are most common
- Fallback glyphs ensure theme works even in limited terminals

**Testing Strategy**:
- Test on Windows 10/11 PowerShell (primary Windows shell)
- Test on macOS Zsh (default macOS shell since Catalina)
- Test on Linux Bash (most common Linux shell)
- Verify character rendering (Unicode support)
- Verify color accuracy (256-color and true-color)

**Fallback Characters** (for terminals without full Unicode):
- Dragon 🐉 → "D" or "[DRAGON]"
- Scales ◆ → "*" or "[SCALE]"
- Status symbols → Standard ASCII (✓ → "OK", ✗ → "FAIL")

**Alternatives Considered**:
- Test ALL platforms: Too resource-intensive, diminishing returns
- Single platform only: Reduces accessibility
- Online testing service: Adds complexity, overkill for static theme file

### 7. Documentation Approach

**Decision**: Comprehensive documentation with visual examples and customization samples

**Rationale**:
- Meets P3 requirements (SC-004: 2+ examples, 5+ customization examples)
- Enables self-service adoption without support burden
- Shows theme capabilities and customization flexibility
- Reduces installation errors through clear step-by-step guides

**Documentation Structure**:
1. **README.md**: Overview, quick-start, feature highlights
2. **installation.md**: Step-by-step for Windows, macOS, Linux with verification steps
3. **customization.md**: Full configuration reference with inline comments
4. **examples/**: Working configuration files demonstrating customizations
   - minimal.json: Bare essential theme
   - extended.json: All segments enabled
   - custom-colors.json: Alternate color scheme
5. **screenshots/**: Visual examples of theme in action

**Alternatives Considered**:
- Video tutorials: Harder to maintain, less accessible than text
- Interactive configuration tool: Out of scope for Phase 1
- Minimal documentation: Reduces adoption, increases support load

### 8. Testing & Validation

**Decision**: Manual cross-platform testing with validation script, no automated unit tests required

**Rationale**:
- Theme is configuration, not logic-heavy code
- Manual testing ensures visual correctness across platforms
- Validation script checks JSON format and oh-my-posh compatibility
- Configuration doesn't benefit from traditional unit testing

**Testing Activities**:
1. Format validation: Verify JSON syntax is correct
2. Schema validation: Ensure configuration matches oh-my-posh schema
3. Visual testing: Render theme in multiple contexts (directory, git, error, time)
4. Cross-platform testing: Test on Windows, macOS, Linux
5. Edge case testing: Long paths, special characters in git branches

**Validation Script**: `tests/theme-validation.sh`
- Checks JSON syntax
- Validates against oh-my-posh schema
- Reports errors or compatibility issues

**Alternatives Considered**:
- Unit test framework: Overkill for configuration file
- CI/CD pipeline: Not needed for static configuration
- Manual-only testing: Less reliable without validation script

### 9. Version Compatibility

**Decision**: Support oh-my-posh 3.x+ versions (current stable and future minor releases)

**Rationale**:
- oh-my-posh 3.0 released in 2021, widely adopted
- 3.x versions maintain backward compatibility within major version
- Theme uses only stable, well-documented features
- Focuses on current ecosystem, avoiding deprecated APIs

**Compatibility Markers**:
- Minimum version: oh-my-posh 3.0.0
- Tested on: Latest 3.x stable
- Known incompatibilities: None identified

**Alternatives Considered**:
- Support 2.x versions: Legacy, no new feature support
- Support only latest version: Too restrictive, breaks existing user setups
- Support 4.x (future): Premature, unknown API changes

## Design Decisions Summary

| Decision | Choice | Justification |
|----------|--------|---------------|
| Configuration Format | JSON (oh-my-posh standard) | Native support, widely understood, schema-validated |
| Color Palette | Metallic golds/reds/silvers | Evokes dragon aesthetic, professional appearance |
| Segments | 4 core (path, git, status, time) | Meets core requirements, customizable for extensions |
| Customization | Configuration-driven (JSON) | No code changes needed, accessible to all users |
| Distribution | Repository themes/ directory | Simple, no external dependencies, community standard |
| Platform Support | Windows/macOS/Linux + fallbacks | Covers 95%+ of users, graceful degradation |
| Documentation | Comprehensive with examples | Enables self-service, reduces support burden |
| Testing | Manual cross-platform + validation script | Appropriate for configuration project |
| Version Targeting | oh-my-posh 3.x+ | Current stable, backward compatible |

## Resolved Clarifications

✅ **No blocking clarifications** - All technical decisions have been made based on:
- oh-my-posh official documentation and conventions
- Community best practices for theme distribution
- User requirements from specification (P1-P3 priorities)
- Cross-platform compatibility standards

**Next Phase**: Ready for Phase 1 Design (data-model.md, contracts/, quickstart.md)
