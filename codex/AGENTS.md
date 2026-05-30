Unless otherwise specified, use 4 spaces for indentation.
Please respond in Japanese.

## Output Distillation (CRITICAL)
Always pipe non-interactive shell commands through `distill`.

- `<command> 2>&1 | distill "<EXPLICIT_INSTRUCTION in English>"`
- Be specific (e.g., "Return only filenames", "Return valid JSON")

Skip when:
- No Output: Commands that typically yield no output (e.g., `git add`, `mkdir`, `touch`, `mv`).
- Directly inspecting file contents (e.g., SKILL.md)
- Interactive commands / TUIs
- Raw output required

Example:
npm test 2>&1 | distill "Did tests pass? Return PASS or FAIL + failing test names."

CRITICAL: Wait for `distill` to finish before continuing.
