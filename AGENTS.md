# Repository Guidelines

## Project Structure & Module Organization
- Primary configuration lives in `themes/dragon.json`; keep edits scoped and update linked docs when segments, colors, or symbols change.
- Requirements and schema are captured in `specs/001-dragon-theme/` (see `contracts/theme-schema.json`); review them before altering structure or metadata.
- Public guides sit in `themes/docs/`, while automation and checklists live in `themes/tests/`; store new examples or scripts alongside their peers.

## Build, Test, and Development Commands
- `bash themes/tests/theme-validation.sh` — canonical validation sweep; requires `jq` and uses `ajv-cli` automatically when present.
- `python3 -m json.tool themes/dragon.json` — rapid syntax check during iteration, especially before committing partial work.
- `bash themes/tests/theme-validation.sh themes/docs/examples/<variant>.json` — reuse the validator for sample variants before publishing them.

## Coding Style & Naming Conventions
- Indent JSON with two spaces, maintain the existing property ordering (metadata → properties → colors → segments), and keep trailing newlines.
- Name custom keys in lower_snake_case (`dragon_gold`, `success_icon`) and retain Unicode escapes (`\u25c6`, `\u2713`) for portability.
- Write shell helpers in POSIX-friendly Bash with `set -e` and centralized color constants; keep Markdown concise with ATX headings and fenced, language-tagged command blocks.

## Testing Guidelines
- Run the validation script after any edit to `themes/dragon.json`, docs examples, or the schema to guarantee a clean handoff.
- Capture the validator summary in commit or PR notes and document any manual `oh-my-posh init <shell> --config <path>` smoke tests you perform.
- When updating docs, follow their checklists, click through relative links, and verify palette values still match the spec.

## Commit & Pull Request Guidelines
- Use imperative commit subjects (`Fix oh-my-posh schema version`) and append related issue numbers in parentheses when applicable (`(#12)`).
- Note impacted areas and validation commands in commit bodies to aid reviewers.
- PRs should summarize visual changes, attach before/after evidence, confirm validator success, and link the corresponding spec requirement when closing work items.
