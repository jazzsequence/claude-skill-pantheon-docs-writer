# Release notes

> Use for anything in `src/source/releasenotes/`. Release notes have their own structure and frontmatter.
> Part of the `pantheon-docs-writer` skill. Return to `../SKILL.md` for the workflow.

## Writing release notes

Release notes live in `src/source/releasenotes/` and follow a different structure from docs and guides. The mechanics below were checked against `pantheon-systems/documentation` main@9b15056 (2026-10-09). Re-check them if `src/server/processor/mdx.tsx`, `src/app/release-notes/rss.xml/route.tsx`, or `.github/workflows/validate-release-notes.yml` changed.

### What belongs in a release note

**Include:**
- New features, releases, and enhancements
- Known issues and workarounds
- Required user action to avoid service disruption
- Visual and UI changes
- Future roadmap items that can be disclosed ahead of time

**Do not include:**
- Marketing or promotional content
- Organizational, financial, or branding updates that aren't technical
- Legal or compliance changes with no user-facing impact

### File naming

```
YYYY-MM-DD-short-slug.md
```

**The filename alone sets the URL.** `src/server/processor/mdx.tsx` splits the filename on `-`, takes the first two parts as year and month, and the rest after the date as the slug: `2026-06-15-terminus-4-4-0.md` becomes `/release-notes/2026/06/terminus-4-4-0`. `published_date` and `published_at` don't change it, so renaming a published note changes its URL and needs a redirect.

Pick the filename date for a new announcement from the date the announcement goes out. Nothing in the repo states a rule for this; ask the release manager if you don't know it.

### Frontmatter

Release notes use a distinct schema. Do not use `contenttype`, `innav`, `audience`, or other regular doc frontmatter fields.

```yaml
---
title: "Short, specific title describing what changed"
published_date: "YYYY-MM-DD"
published_at: "YYYY-MM-DDTHH:MM:SSZ"
categories: [category-slug, category-slug]
description: "One sentence summary shown in listings and RSS."
---
```

| Field | Required | Notes |
|---|---|---|
| `title` | yes | Specific and descriptive. Use quotes if it contains special characters. |
| `published_date` | yes | ISO date: `"YYYY-MM-DD"` |
| `published_at` | yes for new notes | Full ISO timestamp in UTC, set to the actual publish time. Format: `"2026-06-15T14:00:00Z"`. The RSS feed uses it as the item's `pubDate`. |
| `categories` | yes | One or more slugs from the list below. No check enforces this; every existing note has one. |
| `description` | recommended | One sentence for the RSS item. Without it the feed shows "A summary of changes to the Pantheon Platform". Only 60 of 833 existing notes have one. |

### Dates, URL, and RSS: how they interact

| Field | What it does | Source |
|---|---|---|
| Filename date | Sets the URL path (`/release-notes/YYYY/MM/slug`). | `mdx.tsx` lines 107-113 |
| `published_date` | Shown on the listing and note pages. A note without it drops out of the RSS feed. | `release-note-listing/index.tsx`, `rss.xml/route.tsx` |
| `published_at` | The RSS item's `pubDate`, converted to UTC. Without it, the feed invents a time from a hash of the title. | `rss.xml/route.tsx` |
| Feed item order | Follows the filename, newest first. Not `published_at`. | `getAllReleaseNotes` in `page-utils.ts` |

What CI checks (`validate-release-notes.yml`, runs on PRs that touch `src/source/releasenotes/*.md`): one release note per PR, `published_at` present, and its value doesn't end in `T00:00:00Z`. Nothing checks that the filename date, `published_date`, and `published_at` agree, and in main, 16 notes have a filename date that differs from `published_date`. The code doesn't filter on date, so a future-dated note appears at the next build (inferred from the code, not run).

Check all three dates before handoff:

- A midnight `published_at` (`T00:00:00Z`) fails CI. Do not replace it with the real publish time yourself. Inform the user to update this in the PR before merging.
- A `published_date` that differs from the filename date isn't an error in the code. Report it and ask which date the announcement carries. Don't change a date to make the three match unless you were asked to.
- A `published_at` whose date part differs from `published_date` can happen when UTC crosses midnight (2 existing notes). Check the timezone before you call it a mistake.

**New announcement or correction?** A new announcement gets a new file, with `published_at` set to the real publish time. A correction to a note that already published keeps its filename, `published_date`, and `published_at`. Nothing in the schema records a revision, and the existing convention is a line in the body, such as `Update: the removal was planned for May 13 previously.` Don't move an old announcement's dates forward: changing `published_at` changes its feed `pubDate`, and the note then carries a date it didn't publish on.

### Categories

Choose from the slugs in `src/source/releasenotescategories/releaseNoteCategories.json` (22 in main@9b15056; re-read the file, since this table can lag):

| Slug | When to use |
|---|---|
| `new-feature` | New capabilities or improvements |
| `action-required` | Customer must act to avoid disruption |
| `infrastructure` | Platform/infrastructure changes |
| `security` | Security fixes or updates |
| `wordpress` | WordPress-specific changes |
| `drupal` | Drupal-specific changes |
| `plugins` | Pantheon-maintained WordPress plugin updates |
| `modules` | Pantheon-maintained Drupal module updates |
| `tools-apis` | Terminus, APIs, CLI tools |
| `user-interface` | Dashboard/UI changes |
| `performance` | Performance improvements |
| `deprecated` | Features being phased out |
| `policy` | Policy changes |
| `billing` | Billing and finance |
| `account-management` | Account/permissions changes |
| `migration` | Migration-related updates |
| `documentation` | Significant doc additions or changes |
| `nextjs` | Next.js support changes |
| `events` | Events |
| `front-end-sites` | Front-end sites |
| `content-publisher` | Content Publisher updates |
| `general` | Catch-all for changes that don't fit elsewhere |

Use multiple categories when appropriate: `[wordpress, action-required]`.

### Writing guidelines

#### 1. Headings use sentence case

Release notes use sentence case for all headings — capitalize only the first word and proper nouns. This is the same rule as regular docs.

- ✅ `## Explore new features in Pantheon's latest Drupal updates`
- ❌ `## Explore New Features in Pantheon's Latest Drupal Updates`

#### 2. Lead with what changed and why it matters

The opening paragraph should summarize the core change and its benefit to the user. Don't bury the point.

- ✅ "Site health reports now appear on the Site Dashboard for every site."
- ❌ "We've made a few changes in the latest release."

#### 3. Headings should capture the key message

Don't just name the thing — say what it does or why it matters.

- ✅ "Site health reports now appear on the Site Dashboard"
- ❌ "Site health launch"

#### 4. Use bullets for lists of changes or benefits

Break substantial information into bullet points and short paragraphs. Don't pack multiple distinct benefits into a single run-on sentence.

#### 5. Link to docs for deeper context

End with or include a link to the relevant documentation:

- ✅ "See [site health reports](/site-health)."
- ❌ "For more info, check out our documentation."

#### 6. Include visuals for UI changes

For UI changes and step-by-step instructions, include screenshots. Images go in `src/source/images/release-notes/`.

### Body structure patterns

**Simple announcement:**
```markdown
Brief description of what changed and why it matters.

See [descriptive link text](/path/to/doc).
```

**Action required:**
```markdown
Brief description of what changed.

## Action required

What the customer must do, by when, and what happens if they don't act.

[Upgrade instructions](/path/to/doc).
```

**Version release (Terminus, plugin, module):**
```markdown
[Product Name X.Y.Z](link-to-github-release) adds one capability. One sentence on what's new.

## Key improvements in this release

- Feature name: what it does ([#PR](link))
- Fix name: what it fixes ([#PR](link))

## How to upgrade

Steps or link to upgrade documentation.
```

### Release note style rules

- Present tense: "Terminus 4.3.0 now supports X", not "has been released". Many existing notes say "is now available". That's a be verb, and the style guide (`style-guide.md`, "Voice, Style, and Flow") has no release-note exemption. Treat the conflict as open: write the active form, and ask the docs team if a reviewer objects.
- Lead with customer benefit, not internal implementation details
- Titles should be specific: "PHP 7.2, 7.3, and 8.0 reach End of Sale" (state the real event), not "PHP version update"
- Always use `action-required` category when customers must do something to avoid disruption
- The body is Markdown. A few existing notes use `<Alert>`, `<Partial>`, or `<Wistia>` (17 of 833), so components work, but use one only when a plain paragraph can't carry the message.
