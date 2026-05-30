# MBB Page Maker

This is a world-class AgentSkill for creating consulting-style HTML PPT decks: strategy pages, board updates, investment memos, and executive narratives.

The goal is to give any capable agent a reliable, installable way to author, preview, and eventually export executive-grade HTML presentations from a static skill package.

This repo is currently in the foundational HTML skeleton phase.

Design constraints:

- One-command install.
- No build step.
- Pure static HTML/CSS/JS.
- CDN webfonts only.
- Export targets: HTML first, then PNG/PDF, PowerPoint later.

## Install

```bash
npx skills add https://github.com/NomiciAI/mbb-page-maker
```

Repository: [NomiciAI/mbb-page-maker](https://github.com/NomiciAI/mbb-page-maker)

The repository can stay private during development. When it is public, the command above can install the AgentSkill directly from GitHub.

## What Is Included

```text
mbb-page-maker/
├── SKILL.md
├── README.md
├── README.zh-CN.md
├── references/
│   ├── authoring-guide.md
│   ├── components.md
│   ├── layouts.md
│   ├── themes.md
│   └── full-decks.md
├── assets/
│   ├── css/
│   │   ├── base.css
│   │   ├── components.css
│   │   ├── illustrations.css
│   │   ├── layouts.css
│   │   └── fonts.css
│   ├── js/
│   │   └── runtime.js
│   ├── media/
│   └── themes/
│       ├── blue.css
│       ├── green.css
│       ├── red.css
│       ├── mono.css
│       └── classic.css
├── templates/
│   ├── starter-deck.html
│   ├── deck.html
│   ├── neutral-skeleton.html
│   ├── light-skeleton.html
│   ├── dark-skeleton.html
│   ├── mixed-skeleton.html
│   ├── components/
│   └── layouts/
├── scripts/
│   ├── new-deck.sh
│   └── render.sh
└── examples/
    └── demo-deck/
```

## Roadmap

1. Finalize the foundational HTML PPT shell and shared primitives.
2. Add case-by-case reference guidance after approved examples are selected.
3. Add PNG/PDF export.
4. Research PowerPoint export.

## Design System

CSS is intentionally split by responsibility:

- `base.css`: canvas, typography primitives, runtime controls, print rules.
- `layouts.css`: page-level layout shells.
- `components.css`: tables, cards, metrics, agenda, matrix, roadmap, profile blocks.
- `illustrations.css`: neutral illustration primitives and asset slots.
- `themes/*.css`: color tokens only, with light and dark mode values.
- `assets/media/`: optional static images, SVGs, screenshots, and showcase-only filler headshots.

Generated decks should use this static file order: `fonts.css`, `base.css`, `layouts.css`, `components.css`, `illustrations.css`, one theme file, then `runtime.js`. There is no CSS bundle and no build step.

The base layout and component library is structure-first. Themes, showcase pages, or deliberate variants carry color, image treatment, and decorative effects.

Authoring is composable:

1. Start from `templates/starter-deck.html` for a new deck.
2. Identify the message and data shape.
3. Choose the simplest layout from `templates/layouts/`.
4. Fill content slots with components from `templates/components/`.
5. Apply one theme from `assets/themes/`.
6. Add static assets from `assets/media/` only when they are supplied or needed.
7. Render-check alignment, visual balance, and overflow.

Default simple pages are included for opening, centered message/list/metric, visual title, and ending slides. Use `blank-*` layouts when the slide structure is known but the component choice is still being composed.

`templates/deck.html` is the design-system gallery and review tour, not the default generation template.

## Acknowledgements

Inspired by [lewislulu/html-ppt-skill](https://github.com/lewislulu/html-ppt-skill). This project is written from scratch with its own structure, templates, runtime, and design system.

## License & Author

MIT. Copyright (c) 2026 Saitop at NomiciAI <saitop@nomici.ai>.
