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
npx skills add NomiciAI/mbb-page-maker
```

Repository: [NomiciAI/mbb-page-maker](https://github.com/NomiciAI/mbb-page-maker)

## Current Scope

This is the skeleton phase. Do not invent a large theme or layout library yet.

- Use `templates/deck.html` as the minimal HTML PPT starting point.
- Use `assets/css/base.css` for shared slide primitives.
- Use `assets/js/runtime.js` for keyboard navigation and print/export mode.
- Read `references/authoring-guide.md` before creating a real deck.
- Read `references/layouts.md`, `references/themes.md`, or `references/full-decks.md` only when that catalog is needed.

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
