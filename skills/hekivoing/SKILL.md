---
name: hekivoing
description: Hekivo — >
  Meta-skill for Sage/Acorn projects — gerund workflow ecosystem, Lando commands,
  architectural preferences, plan system, design tool integration, skill routing,
  WordPress MCP Adapter, discover-abilities, execute-ability, mcp-query-patterns,
  query-first workflow, Acorn, Bedrock, Sage theme, roots ecosystem, when to use
  which skill — read this first in any Sage/Acorn project session
---

# Hekivoing — The Sage/Acorn Ecosystem Guide

This is the **Free-tier meta skill** for the Hekivo ecosystem — foundational orientation for Sage/Acorn projects with the Roots stack, Lando, and design tool integration.

Hekivo ships as three composable tiers: **Free** (this plugin, `hekivo-web`) for foundational skills; **Pro** (`hekivo-pro`) for full implementation toolkit and workflow automation; **Premium** (`hekivo-premium`) for review automation, performance profiling, and visual verification. Skills below are tagged with their tier — install the matching plugin to get them.

## HARD RULE — Language Policy

**All written artifacts MUST be in en-US.** This is mandatory and never negotiable.

| Context | Language | Examples |
|---|---|---|
| Code (variables, functions, classes) | **en-US always** | `ProposalValue`, not `PropostaValor` |
| Code comments | **en-US always** | `// Fetch highlighted projects` |
| File and directory names | **en-US always** | `proposal-value-adr.md`, not `proposta-valor-adr.md` |
| Documentation, plans, specs, ADRs | **en-US always** | "Eyebrow with lines", not "Eyebrow com linhas" |
| Design guides, component maps | **en-US always** | `HighlightProjects`, not `ProjetosDestaque` |
| Git commit messages | **en-US always** | `feat: add hero section` |
| Git branch names | **en-US always** | `feat/hero-section`, not `feat/secao-hero` |
| CHANGELOG, README | **en-US always** | |
| User-facing prompts and conversation | **User's language** | Follow the language the user writes in |

**Why:** Projects operate in collaborative, international environments. Mixed-language artifacts (half English class names, half Portuguese descriptions) are unprofessional and break searchability, consistency, and onboarding for new team members.

**Enforcement:** If you catch yourself writing a non-English term in any artifact, stop and translate it. Agents and skills that generate artifacts must produce en-US output regardless of the user's conversation language.

## Runner Selection (Lando)

All commands run inside Lando containers. **Never run `composer`, `php`, `node`, or `npm` on the host** — always use the `lando` wrappers defined in `.lando.yml`.

Quick reference (3 most-used):

```
lando flush            # Clear Acorn + Blade + OPcache — after every PHP change
lando theme-build      # Vite production build — after every CSS/JS change
lando acorn <cmd>      # Artisan-style commands (make:block, queue:work, route:list)
```

**Full Lando command reference:** see `@sage-lando` → "Canonical Lando Command Reference" section. All tables for theme tooling, Acorn, ACF Composer, WP-CLI, and cache management are there — do not duplicate across other skills.

## Workflow Skills (Gerunds)

Skills are **activities** — gerund naming communicates process, not command.

| Skill                      | Command                   | Purpose                                                              | Tier    |
| -------------------------- | ------------------------- | -------------------------------------------------------------------- | ------- |
| **Onboarding**             | `/onboarding`             | Project analysis, design tool detection, active plan detection       | Free    |
| **Install Plugin**         | `/install-plugin`         | Install WordPress plugins in Bedrock via Composer                    | Free    |
| **WP-CLI Ops**             | `/wp-cli-ops`             | WP-CLI operations via Lando                                          | Free    |
| **Sage Lando**             | `/sage-lando`             | Lando commands, tooling reference, cache management                  | Free    |
| **Architecture Discovery** | `/architecture-discovery` | Deep architecture discovery with approval gates and spec review loop | Pro     |
| **Plan Generator**         | `/plan-generator`         | Converts approved architecture into executable plan files            | Pro     |
| **Architecting**           | `/architecting`           | Compatibility wrapper for architecture-discovery + plan-generator    | Pro     |
| **Modeling**               | `/modeling`               | Content architecture analysis (static vs dynamic)                    | Pro     |
| **Designing**              | `/designing`              | Design tool integration (Paper/Stitch/Figma/Pencil/offline assets) — routes by URL or file | Pro     |
| **Design System**          | `/sage-design-system`     | Establish visual foundation: tokens → UI components → layout components → kitchensink | Pro     |
| **Block Scaffolding**      | `/block-scaffolding`      | Scaffold new ACF block with custom element, 4-layer CSS contract, selective CSS+JS enqueue, block README | Pro     |
| **Migrating**              | `/migrating`              | Safe destructive data migrations: snapshot → dry-run → approval → apply → verify → idempotency | Pro     |
| **Building**               | `/building`               | Plan-driven implementation with auto-verification                    | Pro     |
| **Block Refactoring**      | `/block-refactoring`      | Evolve existing block: design drift, CSS coverage, variation expansion, v1→v2 migration | Premium |
| **Verifying**              | `/verifying`              | Visual comparison with design reference                              | Premium |
| **Reviewing**              | `/reviewing`              | Convention audit + design alignment check                            | Premium |
| **Debugging**              | `/debugging`              | Sage-aware troubleshooting with cache knowledge                      | Premium |

### Recommended workflow for new features

```
/sage-design-system      →  (tokens, UI atoms, layout components, kitchensink validated)
/architecture-discovery  →  (generates approved architecture spec)
/plan-generator          →  (generates plan + assets)
/building      →  (implements from plan; auto-invokes /block-scaffolding per ACF block)
/reviewing     →  (convention audit + design alignment)
```

For simple tasks, you can invoke individual skills directly.

## Architectural Preferences

| Scenario                    | Preferred Approach                                   | Avoid                                            |
| --------------------------- | ---------------------------------------------------- | ------------------------------------------------ |
| Routes                      | Acorn Routes                                         | `register_rest_route()`                          |
| Background tasks (simple)   | Action Scheduler                                     | Raw cron                                         |
| Background tasks (robust)   | Queue + Job                                          | Looping scripts                                  |
| Authentication              | JWT Auth + custom middleware                         | Cookie-only auth for APIs                        |
| Global configuration        | ACF Options Pages                                    | `wp_options` directly                            |
| Business logic              | Service class or Provider                            | Fat controllers/closures                         |
| Interactive UI              | Livewire                                             | Heavy custom JS (unless performance requires it) |
| Data in templates/views     | REST + JS                                            | Inline PHP queries                               |
| Data in routes              | Livewire                                             | REST + JS                                        |
| Forms                       | Livewire form + HTML Forms (`log1x/sage-html-forms`) | Contact Form 7 / Gravity                         |
| UI components (static)      | Blade Component                                      | Shortcodes                                       |
| UI components (interactive) | Livewire Component                                   | jQuery plugins                                   |
| Custom fields/blocks        | ACF Composer                                         | ACF GUI / `acf_add_local_field_group()`          |
| Content types               | Poet (`config/poet.php`)                             | `register_post_type()` directly                  |
| Menus                       | Navi                                                 | `wp_nav_menu()` directly                         |

## Plan System

Plans live in `docs/plans/` as directories with structured content:

```
docs/plans/YYYY-MM-DD-<topic>/
  plan.md              # Frontmatter with status, strategy, design-tool
  architecture.md      # Architecture Decision Record
  content-model.md     # Content modeling output
  assets/              # Design reference images (screenshots, exports)
    section-hero.png
    section-about.png
  components/          # Sub-plans per component
    01-hero.md
    02-about.md
  logs/                # Activity tracking (auto-populated by hooks)
    activity.log
```

**Plan frontmatter:**

```yaml
---
title: "Feature Name"
date: YYYY-MM-DD
status: in-progress | completed | abandoned
strategy: interactive | autonomous | mixed
design-tool: paper | stitch | figma | pencil | offline | none
components:
  - name: Hero
    status: pending
  - name: About
    status: completed
---
```

## Design Tool Integration

Hekivo routes to a design tool based on the URL the user provides:

| Tool                  | URL pattern                  | MCP                        | Usage                                                                                                           |
| --------------------- | ---------------------------- | -------------------------- | --------------------------------------------------------------------------------------------------------------- |
| **Paper** (preferred) | `paper.design/*`             | `mcp__paper__*`            | `get_basic_info` → `get_tree_summary` → `get_node_info` → `get_screenshot` + `get_computed_styles` + `get_jsx`  |
| **Stitch** (Google)   | `stitch.withgoogle.com/*`    | `mcp__stitch__*`           | `list_screens` → `get_screen` → extract per section                                                             |
| **Figma**             | `figma.com/*`                | `mcp__figma__*`            | List files → get frames → extract layers/text                                                                   |
| **Pencil**            | `*.pen` / `design/` folder   | `mcp__pencil__*`           | `open_document` → `get_variables` / `batch_get(resolveVariables: true)` → `get_screenshot`                     |
| **Playwright MCP**    | n/a                          | `mcp__plugin_playwright_playwright__*` | Capture implementation screenshots for verification                               |
| **Chrome**            | n/a                          | `mcp__Claude_in_Chrome__*` | Alternative screenshot capture                                                                                  |

Routing is by URL, not by which MCP happens to be configured. If the user sends a `paper.design` link and the paper MCP is not installed, `/designing` stops with a setup instruction rather than silently falling back.

When using Paper as source, `/designing` persists three artifacts per section in `assets/`: `.png` (screenshot), `.styles.json` (computed styles, consumed by `/verifying` for style spot-check), and `.reference.jsx` (structural reference — never copied as code, since Sage uses Blade not React).

When no design MCP is available, skills work with local assets in `docs/plans/<plan>/assets/`.

See [`references/mcp-query-patterns.md`](references/mcp-query-patterns.md) for query-before-generate patterns (populated by Onda 5).

## Playwright MCP vs Playwright Test npm

These are two completely different tools with similar names:

| | Playwright MCP | Playwright Test npm |
|---|---|---|
| **What it is** | MCP server for browser automation via Claude | npm package for E2E testing |
| **MCP namespace** | `mcp__plugin_playwright_playwright__*` | n/a |
| **Primary use** | Capture implementation screenshots for visual comparison against design | Run automated E2E test suite |
| **Installation** | `claude mcp add playwright -- npx -y @anthropic/playwright-mcp` | `npm install --save-dev @playwright/test` |
| **Target URL** | `https://{project}.lndo.site` (Lando local) | Configurable in `playwright.config.ts` |
| **Browser binary** | Managed by the MCP server | Must be installed via `npx playwright install` |
| **Replacement for** | Neither — orthogonal tools. MCP is for visual verification; npm is for regression tests | |

**Never substitute one for the other.** When `/verifying` requires a screenshot, use the Playwright MCP. When running `npm run test:e2e`, that is the Playwright Test suite.

## Reference Skills (Agent-Facing)

These skills provide deep technical reference for agents and workflow skills. All are **Pro-tier** unless noted:

| Domain                                 | Skill                             | Tier    |
| -------------------------------------- | --------------------------------- | ------- |
| Project setup, Lando, ACF, Blade, Vite | `sage-lando` (with `references/`) | Free    |
| WP-CLI                                 | `wp-cli-ops`                      | Free    |
| Routes & Controllers                   | `acorn-routes`                    | Pro     |
| Livewire                               | `acorn-livewire`                  | Pro     |
| Eloquent ORM                           | `acorn-eloquent`                  | Pro     |
| Middleware & Auth                      | `acorn-middleware`                | Pro     |
| Queues & Jobs                          | `acorn-queues`                    | Pro     |
| Logging & Errors                       | `acorn-logging`                   | Pro     |
| CLI Commands                           | `acorn-commands`                  | Pro     |
| Redis                                  | `acorn-redis`                     | Pro     |
| Native Blocks                          | `wp-block-native`                 | Pro     |
| Capabilities                           | `wp-capabilities`                 | Pro     |
| Hooks Lifecycle                        | `wp-hooks-lifecycle`              | Pro     |
| PHPStan                                | `wp-phpstan`                      | Pro     |
| REST API                               | `wp-rest-api`                     | Pro     |
| Security                               | `wp-security`                     | Pro     |
| Performance                            | `wp-performance`                  | Premium |

## Hooks & Automation

The Hekivo ecosystem includes zero-token automation hooks. Only `session-start` ships with the Free tier; all others require **Pro**:

| Hook            | Trigger              | Action                                                | Tier    |
| --------------- | -------------------- | ----------------------------------------------------- | ------- |
| `session-start` | Session start        | Inline design tool detection and inject hekivoing     | Free    |
| `post-edit`     | Write/Edit tool      | `lando flush` for PHP, `lando theme-build` for assets | Pro     |
| `post-compact`  | Context compression  | Inject active plan reminder + asset count             | Pro     |
| `pre-commit`    | `git commit` in Bash | Visual verification reminder                          | Pro     |
| `post-subagent` | Subagent completion  | Log activity to plan directory                        | Pro     |
| `post-stop`     | Session end          | Log session end to plan directory                     | Pro     |

## Integration with Base Superpowers

The Hekivo ecosystem extends [obra/superpowers](https://github.com/obra/superpowers). Workflow skills orchestrate base skills. The workflows below require **Pro** or **Premium** — install the appropriate overlay plugin to unlock them:

| Base Skill                       | Used By                                                   | Requires |
| -------------------------------- | --------------------------------------------------------- | -------- |
| `brainstorming`                  | `/architecture-discovery` (design-first discovery engine) | Pro      |
| `writing-plans`                  | `/plan-generator` (plan expansion model)                  | Pro      |
| `executing-plans`                | `/building` (plan execution)                              | Pro      |
| `subagent-driven-development`    | `/building` (parallel component implementation)           | Pro      |
| `dispatching-parallel-agents`    | `/building` (independent component parallelism)           | Pro      |
| `finishing-a-development-branch` | `/reviewing` (merge/PR workflow)                          | Premium  |
| `systematic-debugging`           | `/debugging` (core engine)                                | Premium  |
| `verification-before-completion` | `/verifying` (completion gate)                            | Premium  |

## Commit Message Hygiene

Sage projects commonly use [commitlint](https://commitlint.js.org/) with Conventional Commits. Before running `git commit`, pre-validate the message against the project's config to avoid the hook-fail / retry cycle.

### Pre-commit checklist (run mentally before invoking `git commit`)

1. **Header ≤ 72 chars**: `{type}({scope}): {short summary}` — count the whole line including prefix.
2. **Body separated by blank line**: blank line between header and body is required.
3. **Footer separated by blank line**: blank line between body and any `BREAKING CHANGE:` / `Refs:` / `Co-Authored-By:` trailers.
4. **Scope is a noun** in the current codebase vocabulary (`blocks`, `ci`, `docs`, `hooks`, `skills`, `manifest`, `release`, `lang`). Don't invent scopes.
5. **Type from the allowed list**: `feat`, `fix`, `docs`, `chore`, `refactor`, `perf`, `test`, `ci`, `build`, `style`, `revert`.
6. **Imperative mood**: "add" not "added" or "adds".

### Detect the project's commitlint config

Before the first commit, check:

```bash
cat .commitlintrc.js .commitlintrc.json .commitlintrc package.json 2>/dev/null | grep -A5 'commitlint'
```

Common custom rules to watch for:
- `header-max-length` (default 72, sometimes 100)
- `body-max-line-length` (usually 100)
- `footer-leading-blank` (warning → error)
- `subject-case` (lower-case vs allow-capital)

Adjust the message to fit the project's specific rules before the commit.

### If commit fails due to commitlint

- **NEVER** retry with `--no-verify`; fix the message and commit again
- Do not `--amend` the previous commit; create a new commit (the hook failure means the commit didn't happen)

## Philosophy

- Acorn brings Laravel into WordPress — use Laravel patterns, not WordPress procedural code
- Service Providers are the backbone: register bindings, boot hooks
- Blade Components over shortcodes, always
- ACF Composer for all custom fields/blocks — never use the ACF GUI to create fields
- Livewire for interactive UI unless payload size compromises performance
- YAGNI — don't over-engineer. Start with a Service, extract to a Provider only when needed
- Plans with assets prevent design drift after context compression
- Always verify visually before committing
