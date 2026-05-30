---
name: mbb-page-maker
description: Create, edit, package, or export consulting-style HTML slide decks for strategy, board, investment, pitch, and executive presentations. Use when the user asks for an HTML PPT, slide deck, pitch deck, investment memo deck, board report, static browser-openable presentation, WeChat-shareable PDF/PNG previews, or updates to an existing MBB Page Maker deck.
license: MIT
compatibility: Agent Skills-compatible coding agents. Claude Code requires the skill to be visible under .claude/skills or ~/.claude/skills; use references/agent-compatibility.md if an agent reports Unknown skill.
metadata:
  author: "Saitop at NomiciAI <saitop@nomici.ai>"
---

# MBB Page Maker

This AgentSkill produces static HTML presentation decks with consulting-grade page logic: clear titles, tight storylines, exhibit-first layouts, and executive-ready visual hierarchy.

The source deck must run without a build step: plain HTML, CSS, and JavaScript. Source decks use predownloaded local fonts through `assets/css/fonts.css`. The delivered package must be self-contained: no remote runtime scripts, remote images, remote font URLs, stylesheet imports, or non-embedded media.

## Install

Use the copyable terminal command:

```bash
npx skills add https://github.com/NomiciAI/mbb-page-maker
```

Repository: [NomiciAI/mbb-page-maker](https://github.com/NomiciAI/mbb-page-maker)

If an agent reports "Unknown skill" after installation, read `references/agent-compatibility.md`. Some clients install the canonical package under `.agents/skills/` but require a symlink or copy under their own skill directory.

## Golden Path

For real deck work, follow this path in order:

1. Read `references/authoring-guide.md` before creating or materially rewriting a deck.
2. For strategy, board, investment, pitch, transformation, or full-deck work, read `references/consulting-thinking.md`.
3. For full decks, read `references/full-decks.md` and inspect the closest exemplar in `templates/full-decks/` before writing HTML.
4. Start from `templates/starter-deck.html` or the user's existing deck. Do not start from a blank file.
5. Extract an evidence inventory from the user's material: claims, numbers, comparisons, time periods, risks, decisions, and open gaps.
6. Pass the source fidelity gate: every body slide must use user-provided evidence, clearly marked assumptions, or approved external data.
7. Pass the pattern selection gate: choose audience, decision, output length, theme default, closest full-deck exemplar, and evidence-to-page route.
8. Create a short slide plan before writing HTML: message, evidence source, evidence shape, layout, component, fallback, and output role.
9. Use `references/layouts.md`, `references/components.md`, and `references/themes.md` only when choosing from those catalogs.
10. Assemble slides using existing CSS layers, layout shells, components, and theme tokens.
11. Run `scripts/check-deck-quality.sh path/to/index.html` and `scripts/check-deck-contrast.sh path/to/index.html`; fix failures.
12. Run `scripts/render.sh path/to/index.html` unless the user explicitly asks for source HTML only.
13. Deliver `dist/package/index.html`, `dist/index.pdf`, and `dist/png/` as the default share set.

If any export step fails, fix the source deck or dependency problem and rerun the same command. Do not hand-wave missing package assets, PDF, PNGs, or audit failures.

## Current Scope

This is the foundational HTML skeleton phase. Use the starter deck as the base page system, then expand case-by-case references later.

- Use `templates/starter-deck.html` as the minimal HTML PPT starting point.
- Use `templates/deck.html` only as the design-system gallery and review tour.
- Use `templates/full-decks/*/index.html` as first-class exemplars for storyline, page density, component coverage, and export packaging. Do not copy their content verbatim into user decks.
- Treat `templates/full-decks/*/index.html` as the single editable full-deck source. `examples/*` are generated public demo output; do not use examples as the authoring source unless explicitly recovering newer content.
- Use the CSS layers in order: `fonts.css`, `base.css`, `layouts.css`, `components.css`, `illustrations.css`, then one file from `assets/themes/`.
- Use `assets/js/runtime.js` for keyboard navigation and print/export mode.
- Read `references/authoring-guide.md` before creating a real deck.
- Read `references/agent-compatibility.md`, `references/consulting-thinking.md`, `references/layouts.md`, `references/components.md`, `references/themes.md`, `references/full-decks.md`, `references/adding-patterns.md`, or `references/asset-sourcing.md` only when that catalog is needed.
- Run `scripts/check-deck-quality.sh path/to/deck.html` and `scripts/check-deck-contrast.sh path/to/deck.html` before final delivery.
- Unless the user asks for HTML only, run `scripts/render.sh path/to/deck.html` and deliver the self-contained package `index.html`, PDF, and PNG slide images.
- Use `templates/layouts/default-*.html` for opening, centered transition, centered message, headline metric, and ending pages.
- Use `templates/layouts/blank-*.html` for ordinary structure-first pages before adding specialized components.
- Normalize relative asset paths after copying snippets into a deck.
- Do not add CDN scripts, remote images, dynamic module loaders, or runtime dependencies that cannot be embedded into the final package. Use only the predownloaded local font files referenced by `assets/css/fonts.css`.
- Do not copy proprietary logos, company names, confidentiality statements, or source-identifying marks from reference decks into generated HTML.
- Do not add MBB Page Maker, exemplar, agency, or placeholder brand marks to user decks. Use no visible logo unless the user supplies one.
- Keep footers minimal: page number and, if useful, a neutral deck title. Do not include "source", "prepared by", consulting-firm-style, or exemplar footer copy unless the user explicitly supplied that text.

## Design System Layers

- `assets/css/base.css`: slide canvas, typography primitives, light/dark mode tokens, runtime controls, print rules.
- `assets/css/layouts.css`: page-level layout shells.
- `assets/css/components.css`: reusable content components inside layouts.
- `assets/css/illustrations.css`: neutral CSS/SVG-friendly illustration primitives and asset slots.
- `assets/themes/*.css`: color tokens only. Keep theme names neutral.

## Composition Workflow

1. Start from `templates/starter-deck.html` for generated decks; use skeleton files only as role-specific references.
2. Infer the communication task from the user's prompt and source material.
3. For strategy, board, investment, pitch, transformation, or full-deck work, apply `references/consulting-thinking.md`.
4. For full decks, read `references/full-decks.md` and inspect the closest full-deck exemplar under `templates/full-decks/`.
5. Apply the consulting authoring gate. If the user gives enough material, do not ask them to design pages; infer the audience, decision, output length, default theme, closest exemplar, and evidence routes. Ask only when the audience, decision, hard constraints, or permission to use external data are genuinely missing.
6. Read `references/components.md` and create a slide plan before writing HTML. Each planned slide needs: message title, evidence source, evidence shape, layout, component(s), fallback, and output role.
7. Write answer-first slide titles and build a coherent storyline before polishing visuals.
8. Choose one page layout from `templates/layouts/` using `references/layouts.md`.
9. Choose reusable components from `templates/components/` using `references/components.md`.
10. Apply one theme file from `assets/themes/`.
11. Verify that the assembled slide has one clear message, one dominant visual structure, no visible overflow, and no copied source identifiers.
12. Run the deck quality and contrast audits; fix empty section pages, missing evidence components, and failed text/background pairs.
13. Render the default self-contained HTML package, PDF, and PNG slide images unless the user explicitly asked for HTML only.

Prefer editing the deck and rerunning deterministic scripts over explaining how the user could do it manually.

Do not create filler pages. If the user input does not contain enough structured content for a specialized layout, use a simpler layout or omit the page.

Do not bury structured data in prose. If the source material contains usable numbers, comparisons, rankings, time phases, risks, decisions, or categories, route them to an appropriate component. A data-rich section should not become only cards or a section divider.

Do not create fake data exhibits. If the input lacks numeric values, categories, dates, or comparable records, choose a qualitative component such as outcome-support, framework-map, issue-tree, cause-effect, numbered-list-grid, callout, or decision-log. Never invent numbers to justify a chart, table, matrix, or metric page.

Do not automatically browse for external data. Use only the user's material unless the user explicitly asks for current/public/online research or grants permission after you ask. If external data is approved, keep it separate from user-provided material in the slide plan and use it only where it materially improves the argument.

Do not ask users to choose layouts, components, or page sequences. Ask only for audience, decision, hard constraints, permission to use external data, or missing fields required for a promised exhibit. If the user does not answer, continue with a clear default and mark gaps as assumptions or open questions.

Delivery must fail fast instead of shipping partial files. The package exporter verifies that `dist/package/index.html` has no external stylesheets, external scripts, or non-embedded media resources. If that check fails, replace the dependency with static HTML/CSS/SVG, local media that can be inlined, or a built-in component before delivery.

Avoid pure section-divider pages in short generated decks. When the user asks for only a few sections, either omit dividers or turn them into useful section-intro pages with 2-4 data signals, a catalog, or a summary component. A divider is acceptable only when it creates needed pacing in a longer deck.

If a pure divider is deliberately needed, mark it with `data-allow-divider="true"` and keep it out of short evidence-driven decks.

Avoid generic slide titles such as "Overview", "Analysis", or "Findings" unless they are section labels. Content slide titles should state the page's message as a complete, meaningful sentence.

If content overflows a region, reduce the number of components, choose a wider layout, or split the content into another slide. Do not solve overflow by making text too small to read.

Dark or pitch-style pages must use `.dark`, `[data-mode="dark"]`, `[data-tone="dark"]`, `.dark-cover`, or `[data-variant="dark-cover"]` instead of only setting a dark background. The runtime includes a slide-level safety net for dark backgrounds, but generated decks must still pass the contrast audit.

Page choice is compositional, not fixed. Infer the user's task and data shape, then combine the smallest suitable layout with the needed components. Use `references/layouts.md` and `references/components.md` for detailed selection guidance.

Do not force a specialized page. If the input is sparse, use a simpler page or ask for the missing data.

Content sufficiency examples:

- Contact roster: require at least 3 contacts with names plus at least one of role, location, email, or team. Principal/contributor grouping requires an explicit group field or clear wording.
- Centered metric: require one verified numeric value and one sentence explaining the business meaning.
- Chart: require numeric values with labels. Do not invent data.
- Table: require comparable rows and columns. If only prose exists, use cards or a statement page instead.
- Timeline/roadmap: require phases, dates, or ordered steps.
- Matrix: require two meaningful dimensions.

Default theme selection:

- `mono.css`: structure-first drafts and neutral skeletons.
- `blue.css`: default executive consulting style.
- `red.css`: urgency, turnaround, risk, commercial action.
- `green.css`: growth, sustainability, operations, transformation.
- `pitch.css`: investor, board, fundraising, and VC-style dark/light pitch decks.

## HTML Slide Contract

Decks should be composed from self-contained slide sections:

```html
<main class="deck" data-deck-title="Market entry strategy">
  <section class="slide cover" data-title="Market entry strategy">
    ...
  </section>
  <section class="slide" data-title="The market is attractive but access is concentrated">
    <header>...</header>
    <div class="content">...</div>
    <footer class="footer">...</footer>
  </section>
</main>
```

Ordinary slides use `header + .content + footer`. Cover, ending, and full-bleed slides may use deliberate variants. Insert components only into `.content`, `.region-body`, `.safe-fill`, or `.safe-stack`.

Default export targets: self-contained HTML package, PDF, and PNG slide images. If the user does not specify an output format, create all three by running `scripts/render.sh path/to/index.html`. Future export target: PowerPoint after the HTML system is stable.

## License & Author

MIT. Copyright (c) 2026 Saitop at NomiciAI <saitop@nomici.ai>.
