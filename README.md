# Pantheon Docs Writer — Claude Code Skill

A Claude Code skill for writing, editing, and reviewing [Pantheon documentation](https://docs.pantheon.io).

Invoke it with `/jazzsequence-skills:pantheon-docs-writer`.

## What it does

- Classifies content using the [Diátaxis](https://diataxis.fr/) framework (tutorial, how-to, explanation, reference)
- Applies Pantheon's style guide and MDX component conventions
- Enforces inclusive language guidelines
- Applies Google Developer Style Guide principles where Pantheon's guide doesn't specify
- Guides frontmatter for both docs/guides and release notes
- Covers navigation (omni-components), redirects (middleware.ts), and the PR contribution workflow

## How it's organized

`skills/pantheon-docs-writer/SKILL.md` is a short router: the workflow, the Diátaxis step, and the rules that apply to every page. The detail lives in `skills/pantheon-docs-writer/references/`, and Claude loads only the files a task needs.

Beyond the style guide's formatting rules, the skill covers the problems that came up most in a review of 25 docs: be verbs, hyperbole, and product claims with no source. It asks for the inputs it needs before drafting, delivers open questions with the draft, and has a Docs mode for pages written in Google Docs and published with Content Publisher. Docs mode covers reviewing a Doc (reply format, numbered product questions, terminology conflicts), working safely in a shared Doc, and writing a glossary. `tests/` holds fixtures from the review so you can check a change against them.

## Installation

```bash
curl -fsSL https://raw.githubusercontent.com/jazzsequence/claude-skill-pantheon-docs-writer/main/install.sh | bash
```

Or manually:

```bash
claude plugin marketplace add jazzsequence/claude-skill-pantheon-docs-writer
claude plugin install jazzsequence-skills@pantheon-docs-writer
```

## Usage

Start a Claude Code session in any project and invoke:

```
/jazzsequence-skills:pantheon-docs-writer
```

Then describe what you need — a new doc, a guide, a release note, a style review, or help deciding content structure.

## Updating

```bash
claude plugin update jazzsequence-skills@pantheon-docs-writer
```

## License

MIT
