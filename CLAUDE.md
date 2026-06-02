# CLAUDE.md

This file provides guidance to Claude Code when working in this repository.

## What this repo is

A Claude Code skill packaged as an installable plugin for writing, editing, and reviewing Pantheon documentation. This is **not** a documentation site — it is a skill definition repo. The skill instructs Claude how to write docs that conform to Pantheon's style guide, inclusive language guidelines, Diátaxis content structure, and platform conventions.

## Files

- **`skills/pantheon-docs-writer/SKILL.md`** — The skill definition. This is what Claude reads and executes when `/jazzsequence-skills:pantheon-docs-writer` is invoked. Written as imperative instructions for Claude to follow.
- **`.claude-plugin/marketplace.json`** — Marketplace manifest. Registers this repo as a Claude Code plugin source.
- **`.claude-plugin/plugin.json`** — Plugin manifest. Name, version, author.
- **`install.sh`** — Installer script. Registers the marketplace and installs the plugin via the Claude CLI.

## Maintaining this skill

When editing `skills/pantheon-docs-writer/SKILL.md`:

- Keep instructions imperative — written for Claude to execute, not for a human to read
- Verify style rules and component names against the live Pantheon docs repo (`pantheon-systems/documentation`) before updating
- The docs site uses Next.js and MDX, not Gatsby — do not reference Gatsby
- Navigation is driven by `src/components/omni-components/` TypeScript files, not frontmatter or YAML config
- Redirects are managed in `src/middleware.ts` in the `RedirectMap` object
- Release notes live in `src/source/releasenotes/` with their own frontmatter schema separate from regular docs
- The `innav` frontmatter field is declared in the type system but not actively consumed — do not present it as a navigation driver

When editing `README.md`:
- Installation is via `install.sh` — update that script if the plugin registration mechanism changes, then update the README to match

## Versioning

**Always bump the version in both `.claude-plugin/marketplace.json` and `.claude-plugin/plugin.json` when making changes to the skill.** The plugin system compares version numbers to determine if an update is available.

Use semantic versioning:
- `patch` (e.g. `1.0.0` → `1.0.1`) — wording corrections, minor additions, fixing stale information
- `minor` (e.g. `1.0.0` → `1.1.0`) — new skill sections, new content type guidance
- `major` (e.g. `1.0.0` → `2.0.0`) — breaking changes to the skill's structure or approach

After bumping the version and pushing:
```bash
claude plugin tag
git push origin refs/tags/jazzsequence-skills--v<version>
```
