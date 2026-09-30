---
name: pantheon-docs-writer
description: "Write, edit, or review Pantheon documentation. Applies Pantheon style guide, inclusive language guidelines, Diátaxis structure, and Google Developer Style Guide. Use when creating new docs, editing existing ones, reviewing PRs for style, or deciding how to structure content."
---

# Pantheon Docs Writer

## When to Use

- Writing a new doc or guide from scratch
- Editing an existing doc for style, clarity, or accuracy
- Reviewing a PR for style guide compliance
- Deciding whether content belongs in a doc vs a guide
- Choosing the right Diátaxis content type for a topic
- Structuring a "Before You Begin" section or "More Resources" list
- Selecting the right MDX component (callout, tab, accordion, etc.)
- Writing or editing release notes
- Adding a new page to the site navigation
- Creating a redirect for a moved or removed URL

## Inputs to Gather (if not provided)

1. **Topic** — what does this doc cover?
2. **Audience** — who is the reader? (development, agency, sysadmin, business, marketing)
3. **CMS scope** — does it apply to WordPress, Drupal, both, or neither?
4. **Doc or guide?** — single-page reference vs multi-page walkthrough
5. **New content or edit?** — creating from scratch or revising existing

---

## Step 1: Classify with Diátaxis

Before writing a single word, classify the content. All Pantheon docs fall into one of four quadrants:

| Quadrant | Orientation | User goal | Pantheon form |
|---|---|---|---|
| **Tutorial** | Learning | "Let me try this" | Paginated guide with numbered steps |
| **How-to guide** | Task | "How do I accomplish X?" | Guide or doc with clear steps |
| **Explanation** | Understanding | "Why does this work this way?" | Doc, conceptual, no step-by-step |
| **Reference** | Information | "What are the exact values/options?" | Doc, table/list-heavy, dry and complete |

**Rule:** A single document should serve one quadrant. Don't mix a tutorial with a reference. If you're covering both concepts and steps, split them.

**Pantheon mapping:**
- Tutorials → multipage guides (`contenttype: [guide]`) in `src/source/content/guides/`
- How-to guides → single docs or guides depending on length/complexity
- Explanations → single docs (`contenttype: [doc]`) in `src/source/content/`
- Reference → single docs in `src/source/content/`

---

## Step 2: Choose Content Type and File Location

### Docs (`contenttype: [doc]`)
- Single Markdown file
- Location: `src/source/content/FILENAME.md`
- Use for: explanations, references, standalone how-tos

### Guides (`contenttype: [guide]`)
- Paginated, multiple files in a directory
- Location: `src/source/content/guides/GUIDE-NAME/FILENAME.md`
- First page of the guide: `innav: [true]`; all other pages: `innav: [false]`
- All pages share the same `title:` (the guide name), each gets a unique `subtitle:`
- Use for: tutorials, complex how-tos that walk through several logical phases

---

## Step 3: Frontmatter

Every file requires frontmatter at the very top, wrapped in `---`.

### Minimal required fields

```yaml
---
title: Title of the Doc or Guide
description: One sentence describing what this doc covers or accomplishes.
contenttype: [doc]
innav: [true]
categories: [category-slug]
cms: [--]
audience: [development]
product: [--]
integration: [--]
reviewed: "2024-06-01"
---
```

### Full frontmatter reference

| Field | Required | Type | Notes |
|---|---|---|---|
| `title` | yes | string | Title of doc or guide (shared across all guide pages) |
| `description` | yes | string | One sentence summary |
| `contenttype` | yes | array | `[doc]` or `[guide]` |
| `innav` | yes | array | `[true]` for first/only page; `[false]` for guide subsections |
| `categories` | yes | array | Content category slugs |
| `cms` | yes | array | `[wordpress]`, `[drupal]`, `[wordpress, drupal]`, or `[--]` |
| `audience` | yes | array | `[development]`, `[agency]`, `[business]`, `[sysadmin]`, `[marketing]` |
| `product` | yes | array | Specific Pantheon product or `[--]` |
| `integration` | yes | array | Third-party integration name or `[--]` |
| `reviewed` | yes | string | ISO date of last review: `"2024-06-01"` — always set to today when creating a new doc |
| `subtitle` | no | string | Guide pages only — unique title for this page |
| `tags` | no | array | Search tags |
| `contributors` | no | array | GitHub usernames |
| `showtoc` | no | boolean | `true` to show right-side table of contents |

---

## Step 4: Document Structure

### Standard section order

1. **Introductory paragraph** — one paragraph explaining what this doc covers and what the reader will accomplish. No heading.
2. **Before you begin** (`## Before you begin`) — prerequisites only. Use a bulleted list.
3. **Content sections** — `##` for major steps, `###` for subsections. Don't go deeper than `###` unless unavoidable.
4. **Troubleshooting** (`## Troubleshooting`) — if applicable. Error messages as `###` headers, verbatim.
5. **More resources** (`## More resources`) — 3–5 links. Last section. Always present.

### Before you begin

```markdown
## Before you begin

Be sure that you have:

- An existing WordPress site on Pantheon, or [create](https://dashboard.pantheon.io/sites/create) one.
- [Terminus](/terminus) installed on your local computer.
- A [local clone](/guides/git/git-config#clone-your-site-codebase) of your site's codebase.
```

If the guide uses shell variables, add the export callout here (see Variables section below).

### Troubleshooting

Error message headers are `###`, written verbatim as they appear in the UI/terminal. This makes them findable by search.

```markdown
### RedisException: Redis server went away
```

### More resources

```markdown
## More resources

- [Getting Started with Terminus](/terminus)
- [Git on Pantheon Guide](/guides/git)
```

---

## Step 5: Writing Style

### Voice and Person (Pantheon + Google)

- Use **second person** ("you", "your") — not "we", "the user", or "one"
- Use **active voice** — "Click **Save**" not "The button should be clicked"
- Use **present tense** — "Terminus returns a list" not "Terminus will return a list"
- Be direct: skip throat-clearing openers ("In this guide, we will cover...")
- Avoid be-verbs where possible ("the config file controls X" not "the config file is what controls X")

### Headings

- Use **sentence case** for all headings: capitalize only the first word, proper nouns, product names (Terminus, Multidev, WordPress), and acronyms. Applies to docs, guides, and release notes alike
  - ✅ `## Exclude specific pages from caching`
  - ❌ `## Exclude Specific Pages from Caching`
- Much existing content still uses title case. Don't mass-convert headings in files you're not otherwise editing, but do convert headings you add or touch
- The page `title:` in frontmatter renders as the H1 — don't repeat it in the body
- Start body content at `##`
- Don't skip levels (no jumping from `##` to `####`)
- Don't end headings with punctuation

### Emphasis

- **Bold** (`**text**`) — UI elements, navigation paths, and new terms on first introduction only. Not for general emphasis.
- _Italics_ (`*text*`) — emphasis within prose. Used sparingly.
- Never use bold for general emphasis — use italics.

### Code Formatting

- Inline code (`\`backticks\``) — file names, directory paths, variables, commands, and output within sentences
- Code blocks — multi-line commands, config files, code snippets
- Always specify the language in fenced code blocks: ` ```bash `, ` ```php `, ` ```yaml `
- Shell prompts: ` ```bash{promptUser: user} ` — adds the `$` prompt automatically without copying it
- Output lines: ` ```bash{outputLines: 2-6} ` — marks those lines as non-copyable output
- File excerpts: ` ```yaml:title=pantheon.yml `

### Links

- Use **relative paths** for internal links: `[Terminus Guide](/terminus)` not full URLs
- Use **descriptive link text** — never "click here" or bare URLs
- Do not specify target tab/window — leave that to the reader
- Do not repeat the URL as link text

### Lists

- Bulleted lists for non-sequential items
- Numbered lists for sequential steps — use `1.` for every item (the site auto-numbers them)
- Parallel grammatical structure within a list
- End list items with punctuation only if they're full sentences

### Tables

- Use `✓` for yes, `❌` for no
- Use `<Popover>` for column header tooltips if needed

### Images

- Always include descriptive alt text: `![Alt text](../images/...)`
- No screenshots with personal info (name, email, UUIDs)
- No markup (arrows, circles) added in screenshot tools — let the doc text do the directing
- Don't screenshot terminal output — describe it in text or use a code block

### Navigation and Location

Always orient the user before giving instructions. Don't say "Click the Backup tab" — first tell them where they are:

```markdown
1. [Go to the Site Dashboard](/guides/account-mgmt/workspace-sites-teams/sites#site-dashboard).
1. Click the **Backup** tab.
```

Standard navigation links:
- Site Dashboard: `[Go to the Site Dashboard](/guides/account-mgmt/workspace-sites-teams/sites#site-dashboard)`
- My Dashboard: `[Go to My Dashboard](/guides/account-mgmt/workspace-sites-teams/workspaces#switch-between-workspaces)`
- Professional Workspace: `[Go to the workspace](/guides/account-mgmt/workspace-sites-teams/workspaces#switch-between-workspaces)`

---

## Step 6: MDX Components

### Callouts / Alerts

```html
<!-- Info note -->
<Alert title="Note" type="info">

Use notes for important information the reader shouldn't miss.

</Alert>

<!-- Warning -->
<Alert title="Warning" type="danger">

Use warnings for critical info, especially things that can cause data loss.

</Alert>

<!-- Variable export -->
<Alert title="Exports" type="export">

This process uses [Terminus](/terminus) extensively. Set the variables `$site` and `$env`:

```bash{promptUser: user}
export site=yoursitename
export env=dev
```

</Alert>
```

### Accordion (Panel)

Use for extraneous but useful info — troubleshooting details, pro tips, optional steps.

```html
<Accordion title="Panel Title" id="unique-id" icon="wrench">

### Panel content header

Additional context or advanced instructions.

</Accordion>
```

### Tabs (CMS-specific content)

```html
<TabList>

<Tab title="WordPress" id="wp-example" active={true}>

WordPress-specific instructions here.

</Tab>

<Tab title="Drupal" id="d7-example">

Drupal-specific instructions here.

</Tab>

</TabList>
```

### Partials (Reusable Content)

Before writing content that might already exist:
1. Search `src/source/partials/` for existing partials on the topic
2. If reusable content exists, include it: `<Partial file="partial-name.md" />`
3. If creating new reusable content, put it in `src/source/partials/` and include via `<Partial>`

Partial files don't need frontmatter.

### Popovers (Tooltips)

```markdown
Given two sites with slugs <Popover title="Slugs" content="URL-friendly descriptions for a site." /> `first-site` and `second-site`:
```

### Product Cards

```html
<ProductGroup>

  <Product title="Product Name" link="/product-path">

  Short description of this product.

  </Product>

</ProductGroup>
```

### Definitions

Use `<dfn>` for new terms — they're indexed to the Glossary automatically:

```html
<dfn id="unique-slug">Term</dfn>
```

---

## Step 7: Variables Pattern

When a guide requires the reader to substitute values (site names, env names, etc.), define them upfront with an export callout in "Before you begin":

```html
<Alert title="Exports" type="export">

Before we begin, set the variables `$site` and `$env` in your terminal:

```bash{promptUser: user}
export site=yoursitename
export env=dev
```

</Alert>
```

Then reference them consistently: `$site`, `$env`, `$uuid`, etc. (lowercase for variables, uppercase for constants).

---

## Step 8: Inclusive Language

Apply these rules throughout. Refer to `/inclusive-language` for full guidance.

### Ableist language — avoid
| Avoid | Use instead |
|---|---|
| sanity check | validation, verification |
| crazy, insane | unexpected, surprising, baffling |
| blind to, turn a blind eye | unaware of, ignore |
| crippled, lame, crippling | broken, hindering, slow |
| OCD | meticulous, detail-oriented |

### Violent language — avoid
- No violent metaphors: STONITH, kill, murder in technical contexts
- "One throat to choke" → "single point of accountability"

### Gendered language — avoid
- Use "they" as the default third-person pronoun
- "You all" not "you guys" when addressing groups
- Don't describe tools as easy enough for "mom/grandma/wife"

### Racial language — Pantheon standards
- `allowlist` / `blocklist` (not whitelist / blacklist)
- `main` (not master) for default branch names
- `primary` / `replica` / `secondary` (not master / slave)
- `legacy` or `exempt from` (not "grandfathered in")

### Avoid
- Idioms and jargon that assume North American context ("circle back", "put a pin in it")
- Acronyms without spelling them out on first use
- "Victim of", "suffers from", "afflicted by" when referring to people

---

## Step 9: Review Checklist

Before delivering or committing any doc:

**Structure**
- [ ] Diátaxis quadrant identified and content serves only that quadrant
- [ ] Correct content type (`doc` vs `guide`) and file location
- [ ] Frontmatter complete with all required fields, including `reviewed` set to today's date
- [ ] Introductory paragraph present (no heading)
- [ ] "Before you begin" section if steps follow
- [ ] "More resources" section at the end

**Release notes only**
- [ ] Filename follows `YYYY-MM-DD-slug.md` and slug will produce the correct URL
- [ ] `published_at` set to an accurate ISO timestamp
- [ ] `description` present and written as a complete sentence
- [ ] Headings use sentence case (not title case)
- [ ] `action-required` category added if customer action is needed
- [ ] Links to relevant docs included

**Style**
- [ ] Sentence case on all headings
- [ ] Bold used only for UI elements and navigation
- [ ] Italics for emphasis (not bold)
- [ ] Second person throughout ("you", not "we" or "the user")
- [ ] Active voice
- [ ] Present tense
- [ ] Relative links for internal references
- [ ] Descriptive link text (no "click here")
- [ ] Code in backticks or fenced blocks with language identifier
- [ ] User oriented before giving instructions

**Inclusive language**
- [ ] No ableist, violent, gendered, or racial language
- [ ] Allowlist/blocklist (not whitelist/blacklist)
- [ ] They as default pronoun
- [ ] No idioms that exclude global readers

**Components**
- [ ] Correct callout type (info vs danger vs export)
- [ ] Partials checked for reusable content before writing new
- [ ] Tables use ✓ and ❌ (not ✔/✘)
- [ ] Images have alt text, no personal info, no added markup

**Mechanics**
- [ ] No trailing spaces
- [ ] Blank line at end of file
- [ ] Blank lines between YAML frontmatter and content, and between headings and content
- [ ] Redirect table in PR if moving or removing any URLs

---

## Step 10: Writing Release Notes

Release notes live in `src/source/releasenotes/` and follow a completely different structure from docs and guides.

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

**The filename determines the URL.** `2026-06-15-terminus-4-4-0.md` becomes `/release-notes/2026/06/terminus-4-4-0`. Use the date the change goes live or is announced — not the date you're writing the file.

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
| `published_at` | yes | Full ISO timestamp — reflects the actual publish time; drives RSS ordering. Format: `"2026-06-15T14:00:00Z"` |
| `categories` | yes | One or more slugs from the list below |
| `description` | yes | One sentence shown in listing pages and RSS feeds |

### Categories

Choose from the slugs in `src/source/releasenotescategories/releaseNoteCategories.json`:

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
| `content-publisher` | Content Publisher updates |
| `general` | Catch-all for changes that don't fit elsewhere |

Use multiple categories when appropriate: `[wordpress, action-required]`.

### Writing guidelines

#### 1. Headings use sentence case

Release notes use **sentence case** for all headings — capitalize only the first word and proper nouns. This is the same rule as regular docs.

- ✅ `## Explore new features in Pantheon's latest Drupal updates`
- ❌ `## Explore New Features in Pantheon's Latest Drupal Updates`

#### 2. Lead with what changed and why it matters

The opening paragraph should summarize the core change and its benefit to the user. Don't bury the point.

- ✅ "Turbo Boost is now available to elevate your site's speed with optimized server resources."
- ❌ "We've made a few changes in the latest release."

#### 3. Headings should capture the key message

Don't just name the thing — say what it does or why it matters.

- ✅ "Introducing Turbo Boost for enhanced site performance"
- ❌ "Turbo Boost is launched"

#### 4. Use bullets for lists of changes or benefits

Break substantial information into bullet points and short paragraphs. Don't pack multiple distinct benefits into a single run-on sentence.

#### 5. Link to docs for deeper context

End with or include a link to the relevant documentation:

- ✅ "Ready to learn more? See [Turbo Boost documentation](/turbo-boost)."
- ❌ "For more info, check out our documentation."

#### 6. Include visuals for UI changes

For UI changes and step-by-step instructions, include screenshots. Images go in `src/source/images/release-notes/`.

### Body structure patterns

**Simple announcement:**
```markdown
Brief description of what changed and why it matters.

[Learn more in the documentation](/path/to/doc).
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
[Product Name X.Y.Z](link-to-github-release) is now available. One sentence on what's new.

## Key improvements in this release

- **Feature name** — what it does ([#PR](link))
- **Fix name** — what it fixes ([#PR](link))

## How to upgrade

Steps or link to upgrade documentation.
```

### Release note style rules

- Present tense: "Terminus 4.3.0 is now available" — not "has been released"
- Lead with customer benefit, not internal implementation details
- Titles should be specific: "PHP 7.2, 7.3, and 8.0 are now End of Sale" — not "PHP version update"
- Always use `action-required` category when customers must do something to avoid disruption
- The body is standard Markdown — no MDX components

---

## Step 11: Adding Pages to Navigation

Site navigation is defined in `src/components/omni-components/`. Each section of the nav has its own TypeScript file. Navigation is not driven by frontmatter — you must explicitly add new pages to the appropriate omni-component file.

### Finding the right nav section

| File | Nav section |
|---|---|
| `get-started.ts` | Get Started |
| `workflows.ts` | Workflows / Develop |
| `go-live.ts` | Go Live |
| `web-infrastructure.ts` | Web Infrastructure / Platform |
| `account-management.ts` | Account Management |
| `terminus.ts` | Terminus |
| `security.ts` | Security |
| `support.ts` | Support |

### Adding a simple link

Use `simpleLink(path, title)` to add a standalone page:

```typescript
simpleLink("/your-doc-slug", "Your Doc Title"),
```

### Adding a guide directory

Use `getGuideDirectory(relativePath, overrideTitle?)` to add an entire multi-page guide. The path is relative to `source/content/`:

```typescript
getGuideDirectory("guides/your-guide-name", "Your Guide Title"),
```

This reads the guide's directory and auto-generates nav entries from the files present. Guide sub-page nav titles come from the `navtitle` frontmatter field if present, otherwise from `subtitle`.

### Adding a link with nested children

```typescript
simpleLink("/parent-path", "Parent Title", [
  simpleLink("/parent-path/child-one", "Child One"),
  simpleLink("/parent-path/child-two", "Child Two"),
]),
```

---

## Step 12: Creating Redirects

Redirects are required whenever:
- A doc or guide is moved to a new URL
- A doc or guide is deleted (redirect to the nearest related content)
- A URL is restructured

### How to add a redirect

Redirects live in `src/middleware.ts` in the `RedirectMap` object near the top of the file. Add entries as `"/old-path": "/new-path"`:

```typescript
const RedirectMap: Record<string, string> = {
  // ... existing entries ...
  "/old/path/to/doc": "/new/path/to/doc",
};
```

Rules:
- Paths are relative — `/old-path`, not `https://docs.pantheon.io/old-path`
- No trailing slashes on the old path (the file comment is explicit: "Do not add trailing slashes to the old URLs")
- All redirects are 301 permanent
- Add a separate entry for every old URL, including guide sub-pages — not just the parent

### In your PR

When a PR contains redirects:
- Add the **Redirect** label to the PR
- Include a summary table in the PR body so reviewers can verify coverage:

```markdown
| From | To |
|---|---|
| `/old-path` | `/new-path` |
| `/old-path/sub-page` | `/new-path/sub-page` |
```

---

## Step 13: Contribution and PR Workflow

When creating a new doc or editing an existing one:

1. **Branch naming**: `{issue-number}-{short-description}` (e.g., `10234-add-redis-guide`)
2. **Commit format**: follow the conventional commits pattern (`docs: add Redis configuration guide`)
3. **PR description**: explain what changed and why
4. **Redirect label**: add the **Redirect** label to any PR that touches `src/middleware.ts`

---

## Quick Reference: Terminology

Use Pantheon's canonical terms:
- **Site Dashboard** — the per-site admin page
- **My Dashboard** — a user's personal workspace
- **Professional Workspace** — (formerly Organization) workspace for a team/org
- **Supporting Workspace** — (formerly Supporting Organization) a workspace added to a site's team
- **Multidev** — Pantheon's feature-branch environments
- **Terminus** — Pantheon's CLI (always capitalized)
