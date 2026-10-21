# Docs mode: Google Docs and Content Publisher

> Use when the page lives in a Google Doc published through Pantheon's Content Publisher, not in the docs repo as `.md`/`.mdx`. Examples: P1 documentation. The repo-only guidance in the other references (frontmatter, MDX components, `src/` paths, redirects in `middleware.ts`) doesn't apply here.
> Part of the `pantheon-docs-writer` skill. Return to `../SKILL.md` for the workflow.

## What's confirmed

From Pantheon's release notes and docs in `pantheon-systems/documentation` (checked 2026-10-12):

- Content Publisher sends content from Google Docs to a WordPress, Drupal, or Next.js site. A Google Docs add-on connects a doc to a collection. Its own docs are at https://docs.content.pantheon.io.
- Its quality assistant checks accessibility before you publish: missing alt text, improper heading hierarchy, and non-descriptive link text, among others.

Observed in exported P1 docs (not from product documentation):

- Inline code and section messages are Content Publisher components, not Markdown. In a text export, an inline-code span appears as a marker link before the code text, for example `[█ ](https://pcc.webstyle?...name=Inline%20Code...)`.
- Plain backticks you type into a Doc stay literal. Applying inline code takes Content Publisher's control in the add-on.

## What's not confirmed (ask before promising it)

Mark these `unverified` and ask the Content Publisher team:

- How Doc fields map to the published page's title, description, slug, and review date. The repo's frontmatter doesn't exist in a Doc.
- Which style-guide components a Doc can produce (callouts, tabs, accordions, partials, Popover).
- How internal links should look in a Doc. Relative paths such as `/terminus` work on the docs site; a Doc link may need a full URL.
- Whether the quality assistant covers the style guide's heading-case and voice rules (it covers accessibility).

## How to write for a Doc

- Output plain structured text a person can paste into a Doc. No YAML frontmatter, no MDX, no `src/` paths.
- Use real Heading styles (Heading 1 for the title, Heading 2 and below for sections), not bold or a larger font. Don't skip levels.
- Keep the same voice, heading-case, emphasis, and "Before you begin" rules. See `writing-style.md`, `voice-rules.md`, and `document-structure.md`.
- Bold only for UI navigation. Emphasize with italics.
- **Flag code for the author.** Mark every file name, field, command, and variable that needs inline code, so the author can apply the Content Publisher control. Do this as a list at the end ("Apply inline code to: ...") because pasted backticks won't render.
- Give every image alt text and every link descriptive text. The quality assistant checks both. Deliver alt text as a list after the draft ("Apply alt text to: ...") with the inline-code list, not as "Alt text:" lines in the page.
- **Don't link to a heading on a Doc-published page.** Content Publisher pages use Google-generated heading ids (observed 2026-10-13 on docs.p1.pantheon.io: `#h.fyrcgxgqey8y`), not slugs from the heading text, and the link doesn't scroll to the section. Name the section in the sentence ("follow the *Verify published metadata* steps in [Managing page metadata](...)") and link the page. Treat an anchor you built from heading text as `unverified`.
- **Resolve placeholder links** (`(#)`) from the published site's `sitemap.xml`, and fetch each URL to confirm it loads. Use full URLs; relative paths in a Doc are unconfirmed. Without access, leave the placeholder and ask.
- Put the inputs, claims, and open questions from `inputs-claims-and-sources.md` at the end of your answer, outside the draft, separated from it so nobody pastes them into the Doc.
- Don't use `---` frontmatter, MDX tags, or repo paths in a Doc draft. A horizontal rule between the draft and your notes is fine, but label the notes "not part of the page".

## How to review a Doc

- Work in Suggesting mode, so the author can accept or reject each change.
- Reply to each suggestion with the rule it follows (for example "Voice, Style, and Flow: avoid be verbs") and flag any product claim you couldn't verify.
- Don't change a link target, heading level, or bold-to-italic formatting by search-and-replace; Docs' Find and Replace makes text suggestions only. Leave a comment for those.
- Leave claims you can't confirm as comments. Don't rewrite them.
- When a comment is vague, don't ask the reviewer what they meant. Answer with a concrete proposal built from the entry's own text, so the reviewer can reply "agreed" or correct it.
- Keep each reply to about 3 sentences. Name the source (page URL, UI label, or MCP tool), say what it shows, and say what you didn't test. Quote the revised wording and end with a pointer to the numbered question list. Never write "Checked" without the source and the untested part.
- When a reply says a suggestion exists, re-read the entry in the Doc first and confirm it.
- For a terminology comment, follow "Terminology conflicts" in `inputs-claims-and-sources.md`.
- Put product questions in a numbered list outside the page body, and cite the number (for example "Q7") in the thread. Record a ruling only after the product owner confirms it; until then, write "recommend".
- When a reviewer says published docs are wrong, look for code or product evidence before you change either side. Separate doc defects from product critiques and route each to its owner.

## Safety in a shared Doc

- Switch to Suggesting mode before you touch a shared tab. Do scratch work in a tab the author creates.
- Jump to the end of a tab with cmd+Down on a Mac; cmd+End does nothing.
- Check the clipboard before you paste. The author may have copied something since.
- Docs' Find and Replace pastes `$1` and `\n` literally, resets its scope to all tabs each time it opens, and can miss strings with apostrophes. Use it for literal text only and confirm the match count first.

## Write a glossary

- Define your own product's terms and link out for another product's terms.
- Check that two entries don't define the same thing differently.
- Qualify a term that collides with Git, Next.js, or general web vocabulary, and prefer the name the UI shows.
- State what an entry includes and excludes, and name the entries it depends on.
- Record a source for each entry (page URL, UI label, or MCP tool).
- Cross-references between entries conflict with the heading-link rule above. Don't add them until the Content Publisher team confirms how they should work.

## Check a Doc before publishing

Publishing a Doc through Content Publisher is an outward-facing action: prepare the text, and publish only when the user asks you to. If you can't export the Doc or run `vale` here, mark that check unavailable and give the text for the author to run.

1. Export the Doc as text.
2. Remove Content Publisher markers (the `[█ ](...)` links) and unescape Markdown escapes the export adds.
3. Run `vale` on the cleaned text (`vale-and-checks.md`).
4. Read the voice-rules self-check list; Vale doesn't cover most of it.
