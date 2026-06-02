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
