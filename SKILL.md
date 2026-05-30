---
name: mbb-page-maker
description: Create consulting-style HTML slide decks for strategy, board, investment, and executive presentations. Use this skill when the user asks to make, edit, export, or scaffold an HTML PPT/deck with static HTML/CSS/JS.
---

# MBB Page Maker

This AgentSkill produces static HTML presentation decks with consulting-grade page logic: clear titles, tight storylines, exhibit-first layouts, and executive-ready visual hierarchy.

The output must run without a build step: plain HTML, CSS, and JavaScript, with only CDN webfonts allowed.

## Install

Use the copyable terminal command:

```bash
npx skills add https://github.com/NomiciAI/mbb-page-maker
```

Repository: [NomiciAI/mbb-page-maker](https://github.com/NomiciAI/mbb-page-maker)

## Current Scope

This is the foundational HTML skeleton phase. Use the starter deck as the base page system, then expand case-by-case references later.

- Use `templates/deck.html` as the minimal HTML PPT starting point.
- Use the CSS layers in order: `fonts.css`, `base.css`, `layouts.css`, `components.css`, `illustrations.css`, then one file from `assets/themes/`.
- Use `assets/js/runtime.js` for keyboard navigation and print/export mode.
- Read `references/authoring-guide.md` before creating a real deck.
- Read `references/layouts.md`, `references/themes.md`, or `references/full-decks.md` only when that catalog is needed.
- Do not copy proprietary logos, company names, confidentiality statements, or source-identifying marks from reference decks into generated HTML.

## Design System Layers

- `assets/css/base.css`: slide canvas, typography primitives, light/dark mode tokens, runtime controls, print rules.
- `assets/css/layouts.css`: page-level layout shells.
- `assets/css/components.css`: reusable content components inside layouts.
- `assets/css/illustrations.css`: neutral CSS/SVG-friendly illustration primitives and asset slots.
- `assets/themes/*.css`: color tokens only. Keep theme names neutral.

## Composition Workflow

1. Start from the neutral skeleton unless the user explicitly asks for a theme.
2. Infer the communication task from the user's prompt and source material.
3. Choose one page layout from `templates/layouts/` using `references/layouts.md`.
4. Choose reusable components from `templates/components/` using `references/components.md`.
5. Apply one theme file from `assets/themes/`.
6. Verify that the assembled slide has one clear message, one dominant visual structure, and no copied source identifiers.

Do not create filler pages. If the user input does not contain enough structured content for a specialized layout, use a simpler layout or omit the page.

Content sufficiency examples:

- Contact roster: require at least 3 contacts with names plus at least one of role, location, email, or team. Principal/contributor grouping requires an explicit group field or clear wording.
- Chart: require numeric values with labels. Do not invent data.
- Table: require comparable rows and columns. If only prose exists, use cards or a statement page instead.
- Timeline/roadmap: require phases, dates, or ordered steps.
- Matrix: require two meaningful dimensions.

Default theme selection:

- `mono.css`: structure-first drafts and neutral skeletons.
- `blue.css`: default executive consulting style.
- `red.css`: urgency, turnaround, risk, commercial action.
- `green.css`: growth, sustainability, operations, transformation.

## HTML Slide Contract

Decks should be composed from self-contained slide sections:

```html
<main class="deck" data-deck-title="Market entry strategy">
  <section class="slide cover" data-title="Market entry strategy">
    ...
  </section>
  <section class="slide" data-title="The market is attractive but access is concentrated">
    ...
  </section>
</main>
```

Export targets for later implementation: PNG, PDF, HTML, and eventually PowerPoint after the HTML system is stable.

## License & Author

MIT. Copyright (c) 2026 Saitop at NomiciAI <satiop@nomici.ai>.
