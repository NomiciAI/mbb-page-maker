# MBB Page Maker

This is a world-class AgentSkill for creating consulting-style HTML PPT decks: strategy pages, board updates, investment memos, and executive narratives.

The goal is to give any capable agent a reliable, installable way to author, preview, and eventually export executive-grade HTML presentations from a static skill package.

This repo is currently in the skeleton phase.

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
│   ├── layouts.md
│   ├── themes.md
│   └── full-decks.md
├── assets/
│   ├── css/
│   │   ├── base.css
│   │   └── fonts.css
│   ├── js/
│   │   └── runtime.js
│   └── themes/
│       └── classic.css
├── templates/
│   ├── deck.html
│   └── layouts/
├── scripts/
│   ├── new-deck.sh
│   └── render.sh
└── examples/
    └── demo-deck/
```

## Roadmap

1. Finalize the skeleton and file responsibilities.
2. Build the minimal HTML PPT framework.
3. Add one real example deck after reference pages are provided.
4. Add PNG/PDF export.
5. Research PowerPoint export.
