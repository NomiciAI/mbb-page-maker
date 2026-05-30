# MBB Page Maker

This is a world-class AgentSkill for creating consulting-style HTML PPT decks: strategy pages, board updates, investment memos, and executive narratives.

The goal is to give any capable agent a reliable, installable way to author, preview, and eventually export executive-grade HTML presentations from a static skill package.

This repo is currently in the foundational HTML skeleton phase.

Design constraints:

- One-command install.
- No build step.
- Pure static HTML/CSS/JS.
- Predownloaded Google Latin fonts for source preview; CJK uses system font fallbacks to keep the installable skill small.
- Default export targets: self-contained HTML package, PDF, and PNG; PowerPoint later.

## Install

```bash
npx skills add https://github.com/NomiciAI/mbb-page-maker
```

Repository: [NomiciAI/mbb-page-maker](https://github.com/NomiciAI/mbb-page-maker)

The repository can stay private during development. When it is public, the command above can install the AgentSkill directly from GitHub.

For broad agent discovery, install to all detected clients:

```bash
npx skills add https://github.com/NomiciAI/mbb-page-maker --agent '*'
```

If Claude Code, Cursor, Codex, OpenClaw, Hermes, or another client reports `Unknown skill` while `.agents/skills/mbb-page-maker/` exists, the package is installed but not linked into that client's skill directory. Run:

```bash
.agents/skills/mbb-page-maker/scripts/link-agent-adapters.sh .
```

See `references/agent-compatibility.md` for project/global paths and Claude Code-specific troubleshooting.

## What Is Included

```text
mbb-page-maker/
├── SKILL.md
├── README.md
├── README.zh-CN.md
├── references/
│   ├── authoring-guide.md
│   ├── agent-compatibility.md
│   ├── consulting-thinking.md
│   ├── adding-patterns.md
│   ├── components.md
│   ├── layouts.md
│   ├── themes.md
│   ├── full-decks.md
│   └── asset-sourcing.md
├── assets/
│   ├── css/
│   │   ├── base.css
│   │   ├── components.css
│   │   ├── illustrations.css
│   │   ├── layouts.css
│   │   └── fonts.css
│   ├── js/
│   │   └── runtime.js
│   ├── fonts/
│   │   └── google/
│   ├── media/
│   │   ├── covers/
│   │   └── headshots/
│   └── themes/
│       ├── blue.css
│       ├── green.css
│       ├── red.css
│       ├── pitch.css
│       ├── mono.css
│       └── classic.css
├── templates/
│   ├── starter-deck.html
│   ├── deck.html
│   ├── neutral-skeleton.html
│   ├── light-skeleton.html
│   ├── dark-skeleton.html
│   ├── mixed-skeleton.html
│   ├── full-decks/
│   ├── components/
│   └── layouts/
├── scripts/
│   ├── new-deck.sh
│   ├── check-deck-quality.sh
│   ├── check-deck-contrast.sh
│   ├── fetch-fonts.sh
│   ├── link-agent-adapters.sh
│   ├── sync-examples.sh
│   └── render.sh
└── examples/
    ├── enterprise-intelligence-transformation/
    └── ai-application-investment-thesis/
```

## Roadmap

1. Finalize the foundational HTML PPT shell and shared primitives.
2. Add case-by-case reference guidance after approved examples are selected.
3. Harden one-shot full-deck generation with exemplars, audits, and package verification.
4. Research PowerPoint export.

## Design System

CSS is intentionally split by responsibility:

- `base.css`: canvas, typography primitives, runtime controls, print rules.
- `layouts.css`: page-level layout shells.
- `components.css`: tables, cards, metrics, agenda, matrix, roadmap, profile blocks.
- `illustrations.css`: neutral illustration primitives and asset slots.
- `themes/*.css`: color tokens only, with light and dark mode values.
- `assets/media/`: optional static images, SVGs, screenshots, and showcase-only filler headshots.
- `references/asset-sourcing.md`: curated sources for consulting-style photos, SVG assets, icons, and pure JavaScript visual libraries.

Generated source decks should use this static file order: `fonts.css`, `base.css`, `layouts.css`, `components.css`, `illustrations.css`, one theme file, then `runtime.js`. There is no source build step. `assets/css/fonts.css` points to predownloaded font files in `assets/fonts/google/`. Final `scripts/render.sh --package` output inlines local CSS, JavaScript, fonts, and media into `package/index.html` so the HTML file can be opened by a browser on its own.

Final packages are verified as self-contained: no external stylesheet links, external scripts, remote font URLs, CSS imports, or non-embedded media URLs. Use built-in static components instead of CDN chart/runtime dependencies.

The base layout and component library is structure-first. Themes, showcase pages, or deliberate variants carry color, image treatment, and decorative effects.

Authoring is composable:

1. Start from `templates/starter-deck.html` for a new deck.
2. Identify the message and data shape.
3. Choose the simplest layout from `templates/layouts/`.
4. Fill content slots with components from `templates/components/`.
5. Apply one theme from `assets/themes/`.
6. Add static assets from `assets/media/` only when they are supplied or needed.
7. Render-check alignment, visual balance, and overflow.
8. Run `scripts/check-deck-quality.sh path/to/deck.html` before delivery.
9. Run `scripts/check-deck-contrast.sh path/to/deck.html` before delivery.
10. Unless HTML-only is requested, run `scripts/render.sh path/to/deck.html` to create the self-contained HTML package, PDF, and PNG slide images.

The starter deck stays intentionally light: title cover, simple agenda/context, blank content page, and ending page. Default simple pages are included for opening, centered message/list/metric, visual title, and ending slides. Use `blank-*` layouts when the slide structure is known but the component choice is still being composed.

`templates/deck.html` is the design-system gallery and review tour, not the default generation template.

`templates/full-decks/` contains complete authoring exemplars and is the single editable full-deck source. Agents should inspect the closest exemplar before producing a real full deck. `examples/` is generated public demo output; refresh it with `scripts/sync-examples.sh` and verify with `scripts/sync-examples.sh --check`.

## Acknowledgements

Inspired by [lewislulu/html-ppt-skill](https://github.com/lewislulu/html-ppt-skill). This project is written from scratch with its own structure, templates, runtime, and design system.

## License & Author

MIT. Copyright (c) 2026 Saitop at NomiciAI <saitop@nomici.ai>.
