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
- `assets/media/`: optional static images, SVGs, screenshots, and headshots.

Authoring is composable:

1. Choose a skeleton: neutral, light, dark, or mixed.
2. Choose a layout from `templates/layouts/`.
3. Fill it with components from `templates/components/`.
4. Apply one theme from `assets/themes/`.

## License & Author

MIT. Copyright (c) 2026 Saitop at NomiciAI <support@nomici.ai>.
