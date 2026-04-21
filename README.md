# Hekivo — Free

AI workflow skills for WordPress/Sage/Acorn development.
Works with Claude Code, GitHub Copilot Agent, and Cursor.

## What's included

Foundational skills to get you started with Sage/Acorn:

- **hekivoing** — meta-skill: ecosystem guide and skill routing
- **onboarding** — orient yourself in any Sage/Acorn project
- **sage-lando** — Lando + Acorn + Bedrock command reference
- **install-plugin** — install WordPress plugins via Bedrock/Composer
- **wp-cli-ops** — WP-CLI operations, database management, deploy checklist

## Installation

### Claude Code

```bash
/plugin marketplace add hekivo/hekivo-web
/plugin install hekivo-web@hekivo-web
```

### GitHub Copilot / VS Code

Add to `.vscode/settings.json`:

```json
{
  "github.copilot.chat.codeGeneration.instructions": [
    { "url": "https://raw.githubusercontent.com/hekivo/hekivo-web/main/CLAUDE.md" }
  ]
}
```

### Cursor

Add to `.cursor/rules`:

```
@https://raw.githubusercontent.com/hekivo/hekivo-web/main/CLAUDE.md
```

## Upgrade

[Hekivo Pro](https://hekivo.com/pro) — 31 skills, 8 specialist agents,
full workflow automation for Sage/Acorn projects.

[Hekivo Premium](https://hekivo.com/premium) — everything in Pro plus
review automation, performance profiling, refactoring, and visual verification.

## License

MIT
