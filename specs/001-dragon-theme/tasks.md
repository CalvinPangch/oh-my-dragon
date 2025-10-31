# Tasks: Dragon oh-my-posh Theme

**Input**: Design documents from `/specs/001-dragon-theme/`
**Prerequisites**: plan.md ✅, spec.md ✅, research.md ✅, data-model.md ✅, contracts/theme-schema.json ✅

**Tests**: Configuration validation and visual verification (no unit tests - configuration-only project)

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

All paths are relative to repository root. Configuration theme project uses single `themes/` directory structure:

```
themes/
├── dragon.json                      (main theme)
├── README.md
├── docs/
│   ├── installation.md
│   ├── customization.md
│   └── examples/
│       ├── minimal.json
│       ├── extended.json
│       └── custom-colors.json
└── tests/
    └── theme-validation.sh
```

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and directory structure

- [ ] T001 Create themes directory structure per plan.md (themes/, themes/docs/, themes/docs/examples/, themes/tests/)
- [ ] T002 [P] Create themes/README.md with overview and quick-start instructions
- [ ] T003 [P] Create themes/tests/theme-validation.sh validation script (JSON syntax and schema validation)

**Checkpoint**: Project structure ready for theme implementation

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core theme configuration that ALL user stories depend on

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T004 Create base themes/dragon.json with core segments (directory, git, status, execution_time) per data-model.md
- [ ] T005 [P] Define color palette in dragon.json: dragon_gold (#D4AF37), dragon_red (#8B0000), dragon_silver (#C0C0C0), dragon_dark (#1a1a1a), dragon_emerald (#1B4D3E), success (#00AA00), error (#FF0000)
- [ ] T006 [P] Configure directory segment in dragon.json with properties: folder_separator_icon (/), home_icon (~), truncation_length (3), max_width (40), truncate_from_left (false)
- [ ] T007 [P] Configure git segment in dragon.json with properties: display_stash_count (true), display_upstream_icon (true), local_working_icon (●), local_staged_icon (◆), untracked_count_icon (?)
- [ ] T008 [P] Configure status segment in dragon.json with success_icon (✓), error_icon (✗), foreground_templates for color coding
- [ ] T009 [P] Configure execution_time segment in dragon.json with threshold (1000ms), format (HH:mm:ss.fff)
- [ ] T010 Validate themes/dragon.json against contracts/theme-schema.json using theme-validation.sh
- [ ] T011 Test themes/dragon.json loads in oh-my-posh (local manual verification)

**Checkpoint**: Foundation complete - dragon.json is valid and ready for variant creation

---

## Phase 3: User Story 1 - Dragon-Themed Terminal Prompt (Priority: P1) 🎯 MVP

**Goal**: Deliver a visually appealing dragon-themed oh-my-posh prompt with gold/red metallic colors and dragon aesthetic

**Independent Test**: Load dragon.json in oh-my-posh and verify all 4 segments render with correct colors and symbols

### Tests for User Story 1

> **NOTE: Validation tests written FIRST via theme-validation.sh**

- [ ] T012 [P] [US1] Run theme-validation.sh to verify dragon.json JSON syntax is valid
- [ ] T012b [P] [US1] Run theme-validation.sh to verify dragon.json matches theme-schema.json
- [ ] T012c [US1] Manual visual test: Load dragon.json in Windows PowerShell and verify gold background and dark text
- [ ] T012d [US1] Manual visual test: Load dragon.json in macOS Zsh and verify colors and Unicode symbols render correctly
- [ ] T012e [US1] Manual visual test: Load dragon.json in Linux Bash and verify colors and Unicode symbols render correctly

### Implementation for User Story 1

- [ ] T013 [US1] Create themes/dragon.json main theme file with all 4 core segments (completed in Phase 2, T004-T009)
- [ ] T014 [US1] Add $schema reference pointing to oh-my-posh schema in dragon.json
- [ ] T015 [US1] Set version to "1.0.0" and final: true in dragon.json
- [ ] T016 [US1] Add console_title_template and console_title_true_color_template in dragon.json
- [ ] T017 [US1] Verify dragon.json displays directory path with dragon gold background (#D4AF37)
- [ ] T018 [US1] Verify git segment displays branch name with powerline style (⎇ symbol)
- [ ] T019 [US1] Verify status segment shows ✓ for success (green) and ✗ for error (red)
- [ ] T020 [US1] Verify execution_time segment displays for commands >1 second with dragon red background
- [ ] T021 [US1] Test path truncation: long paths >40 characters truncate to last 3 directories
- [ ] T022 [US1] Test git status indicators: ● for modified files, ◆ for staged files, ? for untracked
- [ ] T023 [US1] Validate all Unicode symbols have ASCII fallbacks (dragon 🐉→D, scales ◆→*, success ✓→OK, error ✗→FAIL)

**Checkpoint**: User Story 1 complete - Dragon theme renders correctly on Windows, macOS, Linux with all segments functional

---

## Phase 4: User Story 2 - Customization and Adaptation (Priority: P2)

**Goal**: Enable users to customize colors, symbols, and segment visibility without editing core theme file

**Independent Test**: Load custom configuration variants and verify each renders correctly with customized values

### Tests for User Story 2

- [ ] T024 [P] [US2] Validate themes/docs/examples/minimal.json against theme-schema.json using theme-validation.sh
- [ ] T025 [P] [US2] Validate themes/docs/examples/extended.json against theme-schema.json using theme-validation.sh
- [ ] T026 [P] [US2] Validate themes/docs/examples/custom-colors.json against theme-schema.json using theme-validation.sh
- [ ] T027 [US2] Manual test: Load minimal.json variant and verify only directory, git, status segments display
- [ ] T028 [US2] Manual test: Load extended.json variant and verify all segments plus time display
- [ ] T029 [US2] Manual test: Load custom-colors.json and verify colors differ from default but maintain dragon theme

### Implementation for User Story 2

- [ ] T030 [P] [US2] Create themes/docs/examples/minimal.json with directory + git + status segments only (no execution_time)
- [ ] T031 [P] [US2] Create themes/docs/examples/extended.json with all 4 segments + time segment showing current time
- [ ] T032 [P] [US2] Create themes/docs/examples/custom-colors.json with alternative colors (#FFD700 gold, #FF1493 accent) maintaining dragon aesthetic
- [ ] T033 [US2] Add color customization properties to minimal.json, extended.json, custom-colors.json with inline comments
- [ ] T034 [US2] Add symbol customization properties (success_icon, error_icon alternatives) with inline comments
- [ ] T035 [US2] Add path truncation customization (max_width, truncation_length) with inline comments
- [ ] T036 [US2] Add git status symbol customization (local_working_icon, local_staged_icon) with inline comments
- [ ] T037 [US2] Verify all 3 variants are valid JSON and match schema
- [ ] T038 [US2] Test customization workflow: Copy dragon.json → Edit colors → Reload shell → Verify custom colors applied

**Checkpoint**: User Story 2 complete - Users can create and use configuration variants with customized appearance

---

## Phase 5: User Story 3 - Installation and Setup (Priority: P2)

**Goal**: Provide clear, step-by-step installation instructions for all platforms (Windows, macOS, Linux)

**Independent Test**: Follow each platform's installation instructions and verify theme loads correctly

### Tests for User Story 3

- [ ] T039 [P] [US3] Manual test: Windows PowerShell installation - Copy dragon.json to $ENV:APPDATA\oh-my-posh\themes\ and verify theme loads
- [ ] T040 [P] [US3] Manual test: macOS Zsh installation - Copy dragon.json to ~/.config/oh-my-posh/themes/ and verify theme loads
- [ ] T041 [P] [US3] Manual test: Linux Bash installation - Copy dragon.json to ~/.config/oh-my-posh/themes/ and verify theme loads
- [ ] T042 [US3] Verify shell configuration activation: Windows PowerShell $PROFILE modification works
- [ ] T043 [US3] Verify shell configuration activation: macOS ~/.zshrc modification works
- [ ] T044 [US3] Verify shell configuration activation: Linux ~/.bashrc modification works

### Implementation for User Story 3

- [ ] T045 [P] [US3] Create themes/docs/installation.md with prerequisites section (oh-my-posh 3.0.0+, modern terminal, Unicode support)
- [ ] T046 [P] [US3] Add Windows PowerShell installation section: mkdir, Copy-Item, profile configuration, reload instructions
- [ ] T047 [P] [US3] Add macOS Zsh installation section: mkdir, cp, ~/.zshrc modification, source command
- [ ] T048 [P] [US3] Add Linux Bash installation section: mkdir, cp, ~/.bashrc modification, source command
- [ ] T049 [P] [US3] Add installation verification section with sample output: directory display, git repository, status symbols
- [ ] T050 [US3] Add troubleshooting section: theme not appearing, Unicode characters as boxes, colors look wrong, version compatibility
- [ ] T051 [US3] Add fallback glyph table documenting ASCII alternatives for limited terminals
- [ ] T052 [US3] Verify installation.md instructions are accurate and platform-specific

**Checkpoint**: User Story 3 complete - Users have clear installation instructions for all platforms

---

## Phase 6: User Story 4 - Multi-OS and Shell Support (Priority: P3)

**Goal**: Ensure theme works across Windows (PowerShell), macOS (Zsh), Linux (Bash) with graceful fallbacks

**Independent Test**: Install and test on each platform; verify colors, symbols, and functionality work consistently

### Tests for User Story 4

- [ ] T053 [P] [US4] Test Windows PowerShell: Verify all 4 segments display with correct colors and Unicode
- [ ] T054 [P] [US4] Test macOS Zsh: Verify all 4 segments display with correct colors and Unicode
- [ ] T055 [P] [US4] Test Linux Bash: Verify all 4 segments display with correct colors and Unicode
- [ ] T056 [US4] Test limited terminal fallback: Verify ASCII symbols display when Unicode unavailable (● → *, ◆ → *, ✓ → OK, ✗ → FAIL)
- [ ] T057 [US4] Test terminal color support: Verify theme renders with 256-color and true-color terminals
- [ ] T058 [US4] Cross-platform consistency: Long paths, git branches with special characters, command failures all behave consistently

### Implementation for User Story 4

- [ ] T059 [P] [US4] Verify dragon.json uses only standard oh-my-posh segments (no platform-specific features)
- [ ] T060 [P] [US4] Verify dragon.json colors use hex format (#RRGGBB) compatible with all oh-my-posh versions
- [ ] T061 [P] [US4] Verify dragon.json symbols use common Unicode characters with broad terminal support
- [ ] T062 [US4] Document platform differences in docs/installation.md (PowerShell paths vs Unix paths)
- [ ] T063 [US4] Document terminal font requirements: Recommend Nerd Font (Cascadia Code, Fira Code) for best rendering
- [ ] T064 [US4] Create fallback symbol mapping in documentation for terminals without Unicode support
- [ ] T065 [US4] Test edge cases: Very long paths (>100 chars), git branches with spaces/special chars, git submodules
- [ ] T066 [US4] Verify version compatibility: Test with oh-my-posh 3.0.0, 3.x latest, document minimum version requirement

**Checkpoint**: User Story 4 complete - Theme works reliably across all supported platforms and terminal types

---

## Phase 7: User Story 5 - Comprehensive Documentation and Examples (Priority: P3)

**Goal**: Provide extensive documentation, visual examples, and customization guides to reduce adoption friction

**Independent Test**: Follow documentation to install, customize, and understand all theme features without external help

### Tests for User Story 5

- [ ] T067 [P] [US5] Verify themes/README.md quick-start instructions work end-to-end
- [ ] T068 [P] [US5] Verify themes/docs/customization.md customization examples work as documented
- [ ] T069 [US5] Verify themes/docs/examples/ (minimal.json, extended.json, custom-colors.json) match documentation
- [ ] T070 [US5] Verify color customization example produces expected result
- [ ] T071 [US5] Verify symbol customization example produces expected result
- [ ] T072 [US5] Verify path truncation customization example produces expected result

### Implementation for User Story 5

- [ ] T073 [P] [US5] Create themes/README.md with feature highlights, quick-start, table of contents linking to detailed docs
- [ ] T074 [P] [US5] Add feature highlights to README: dragon gold colors, customization, cross-platform support, minimal setup
- [ ] T075 [P] [US5] Create themes/docs/customization.md with full configuration reference and inline comments
- [ ] T076 [P] [US5] Add color palette section to customization.md with hex codes and suggested alternatives
- [ ] T077 [P] [US5] Add symbol customization section with 5+ customization examples (bullets, checks, etc.)
- [ ] T078 [P] [US5] Add path truncation customization section with examples for different max_width values
- [ ] T079 [P] [US5] Add git status customization section with examples for different icon sets
- [ ] T080 [P] [US5] Create themes/docs/examples/ directory and populate with 3 variant files (minimal, extended, custom-colors)
- [ ] T081 [P] [US5] Add inline comments to all configuration files (dragon.json, minimal.json, extended.json, custom-colors.json) explaining each property
- [ ] T082 [US5] Create themes/docs/screenshots/ directory (optional) for visual examples of theme in action
- [ ] T083 [US5] Document 5+ customization recipes in customization.md: minimal theme, extended theme, custom colors, ASCII symbols, etc.
- [ ] T084 [US5] Add "Next Steps" section to README linking to installation.md, customization.md, examples/
- [ ] T085 [US5] Add "Support" section with troubleshooting tips and links to oh-my-posh documentation
- [ ] T086 [US5] Verify all documentation links work and reference correct files

**Checkpoint**: User Story 5 complete - Comprehensive documentation enables self-service adoption

---

## Phase N: Polish & Cross-Cutting Concerns

**Purpose**: Final validation, documentation completeness, and quality checks

- [ ] T087 [P] Run complete theme-validation.sh on dragon.json and all variant files
- [ ] T088 [P] Run complete theme-validation.sh on themes/docs/examples/ (minimal.json, extended.json, custom-colors.json)
- [ ] T089 [P] Verify all markdown files (README.md, installation.md, customization.md) are properly formatted and link correctly
- [ ] T090 Final cross-platform smoke test: Install on one Windows, one macOS, one Linux system and verify theme works
- [ ] T091 Update CLAUDE.md project context (completed during planning phase)
- [ ] T092 Create git commit with all theme files and documentation
- [ ] T093 Verify repository structure matches plan.md (themes/ directory at root with correct subdirectories)
- [ ] T094 Final documentation review: Ensure quickstart.md and all guides are accurate and complete

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion (T001-T003) - BLOCKS all user stories
- **User Stories (Phase 3-7)**: All depend on Foundational phase completion (T004-T011)
  - User stories can proceed in parallel if staffed
  - Or sequentially in priority order (P1 US1 → P2 US2,US3 → P3 US4,US5)
- **Polish (Phase N)**: Depends on all desired user stories being complete

### Phase 2 (Foundational) Critical Path

This phase MUST be completed before any user story work:

```
T004 (base dragon.json)
├─ T005, T006, T007, T008, T009 (parallel segment and color config)
└─ T010 (schema validation)
    └─ T011 (oh-my-posh load test)
```

### User Story Dependencies

- **US1 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **US2 (P2)**: Can start after Foundational (Phase 2) - Builds variants of US1 theme, independently testable
- **US3 (P2)**: Can start after Foundational (Phase 2) - Documents installation of US1 theme, independently testable
- **US4 (P3)**: Can start after Foundational (Phase 2) - Tests US1 theme across platforms, independently verifiable
- **US5 (P3)**: Can start after Foundational (Phase 2) - Documents US1 theme usage, independently verifiable

### Within Each Phase

- Parallel opportunities marked with [P] - different files, no dependencies
- Sequential dependencies documented (e.g., T010 depends on T004-T009)
- Each user story independently completable and testable

### Parallel Opportunities

**Phase 1 Setup**:
- T002, T003 can run in parallel (different files)

**Phase 2 Foundational**:
- T005, T006, T007, T008, T009 can run in parallel (different segments in same file, but can be edited independently)
- T010 depends on T004-T009 completion

**Phase 3+ User Stories**:
- All test tasks marked [P] can run in parallel within story
- Once Foundational (Phase 2) completes, all 5 user stories can start in parallel
- Different developers can work on different user stories independently

**Example Parallel Execution**:
```
Foundational (Phase 2) - Complete together
│
├─ Developer A: User Story 1 (Theme Implementation)
├─ Developer B: User Story 2 (Configuration Variants)
├─ Developer C: User Story 3 (Installation Guide)
├─ Developer D: User Story 4 (Cross-Platform Testing)
└─ Developer E: User Story 5 (Documentation)

All user stories complete independently and can be validated/merged sequentially
```

---

## Implementation Strategy

### MVP First (User Story 1 Only) - Recommended

1. **Complete Phase 1**: Setup (T001-T003) - ~15 minutes
2. **Complete Phase 2**: Foundational (T004-T011) - ~1-2 hours
3. **Complete Phase 3**: User Story 1 (T012-T023) - ~2-3 hours
4. **STOP and VALIDATE**: Test User Story 1 independently on all 3 platforms
5. **Deploy/Demo**: Share dragon.json with users for feedback
6. **Then add**: US2 (variants), US3 (docs), US4 (platforms), US5 (guide)

**Timeline**: ~4 hours to MVP (US1), then 2-3 hours per additional story

### Incremental Delivery Strategy

This approach provides value at each checkpoint:

1. **Phase 1 + Phase 2** → Foundation ready (theme file is valid)
2. **+ Phase 3 (US1)** → MVP delivered (dragon theme works on primary OS)
3. **+ Phase 4 (US2)** → Customization available (users can modify theme)
4. **+ Phase 5 (US3)** → Installation docs (users can install independently)
5. **+ Phase 6 (US4)** → Cross-platform support (works on all OSes)
6. **+ Phase 7 (US5)** → Complete documentation (self-service adoption)
7. **+ Phase N** → Production ready (fully validated and documented)

### Parallel Team Strategy (5 Developers)

With team capacity:

1. **Team lead**: Phase 1 (Setup) + Phase 2 (Foundational) - ~2 hours
2. **Once foundational ready** (T011 complete):
   - **Developer A**: Phase 3 US1 (Dragon theme implementation) - 2-3 hours
   - **Developer B**: Phase 4 US2 (Config variants) - 2-3 hours
   - **Developer C**: Phase 5 US3 (Installation docs) - 2-3 hours
   - **Developer D**: Phase 6 US4 (Cross-platform testing) - 2-3 hours
   - **Developer E**: Phase 7 US5 (Comprehensive guide) - 2-3 hours
3. **Integration**: Merge all user stories (should integrate cleanly - separate files)
4. **Final validation**: Phase N (Polish & Testing) - 1 hour

**Total with parallel team**: ~5-6 hours (vs 12-15 hours sequential)

---

## Notes

- **[P] tasks** = different files, no dependencies - can run in parallel
- **[Story] label** = maps task to specific user story for traceability
- **Each user story** = independently completable, testable, and deliverable
- **Configuration focus** = All changes are JSON file modifications (no code compilation)
- **No unit testing** required (configuration-only project) - use validation.sh and manual testing
- **Commit after each phase** or after each user story completes
- **Stop at any checkpoint** to validate story independently before moving to next
- **Parallel recommendations** = Phase 1 Setup can use parallelization, Phase 2 must be sequential for base theme, Phase 3+ user stories can fully parallelize

---

## Task Checklist Summary

| Phase | Tasks | Focus | Dependencies |
|-------|-------|-------|--------------|
| 1: Setup | T001-T003 | Directory structure, base scripts | None - start immediately |
| 2: Foundational | T004-T011 | dragon.json creation & validation | Requires Phase 1 complete |
| 3: US1 (P1 MVP) | T012-T023 | Theme implementation & testing | Requires Phase 2 complete |
| 4: US2 (P2) | T024-T038 | Customization variants | Requires Phase 2 complete |
| 5: US3 (P2) | T039-T052 | Installation documentation | Requires Phase 2 complete |
| 6: US4 (P3) | T053-T066 | Cross-platform testing | Requires Phase 2 complete |
| 7: US5 (P3) | T067-T086 | Comprehensive documentation | Requires Phase 2 complete |
| N: Polish | T087-T094 | Final validation & commits | Requires user stories complete |

**Total Tasks**: 94 discrete, trackable work items enabling independent implementation and verification
