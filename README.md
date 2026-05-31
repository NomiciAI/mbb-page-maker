# MBB Page Maker

This is a skill package for creating consulting-style HTML PPT decks: strategy pages, board updates, investment memos, and executive narratives. [中文 README](README.zh-CN.md)
The goal is to give AI coding agents a reliable, installable way to author, preview, and export executive-grade HTML presentations from a static package.

Design constraints:

```txt
- One-command install.
- No build step.
- Pure static HTML/CSS/JS.
- Default export targets: self-contained HTML package, PDF, and PNG.
```

## Example Gallery

<p align="center">
  <a href="examples/ai-erp-saas-lop/index.html"><img src="assets/media/readme/ai-erp-saas-lop.gif" alt="AI Product Operating Plan for an ERP SaaS Incumbent" width="360"></a>
  <a href="examples/agent-technology-outlook/index.html"><img src="assets/media/readme/agent-technology-outlook.gif" alt="Agent Technology Outlook" width="360"></a>
</p>
<p align="center">
  <a href="examples/enterprise-intelligence-transformation/index.html"><img src="assets/media/readme/enterprise-intelligence-transformation.gif" alt="AI-Era Enterprise Intelligence Transformation" width="360"></a>
  <a href="examples/ai-application-investment-thesis/index.html"><img src="assets/media/readme/ai-application-investment-thesis.gif" alt="AI Application Software Investment Thesis" width="360"></a>
</p>

## Install

```bash
npx skills add https://github.com/NomiciAI/mbb-page-maker
```

Repository: [NomiciAI/mbb-page-maker](https://github.com/NomiciAI/mbb-page-maker)

The command above installs the skill package directly from the public GitHub repository.

For broad agent discovery, install to all detected clients:

```bash
npx skills add https://github.com/NomiciAI/mbb-page-maker --agent '*'
```

If Claude Code, Cursor, Codex, OpenClaw, Hermes, or another client reports `Unknown skill` while `.agents/skills/mbb-page-maker/` exists, the package is installed but not linked into that client's skill directory. Run:

```bash
.agents/skills/mbb-page-maker/scripts/link-agent-adapters.sh .
```

See `references/agent-compatibility.md` for project/global paths and Claude Code-specific troubleshooting.

## Quick Start

```bash
# Open a public demo deck locally
open examples/ai-erp-saas-lop/index.html

# Scaffold a new deck from the starter template
./scripts/new-deck.sh my-talk
open my-talk/index.html

# Export a self-contained HTML package, PDF, and PNG slide images
./scripts/render.sh my-talk/index.html
open my-talk/dist/package/index.html
```

## Design System

MBB Page Maker is plain static HTML/CSS/JS. The source deck stays readable and editable, while `scripts/render.sh` can package it into a single self-contained HTML file for sharing.

CSS is split by responsibility:

- `base.css`: slide canvas, typography, runtime controls, and print rules.
- `layouts.css`: page-level layout shells.
- `components.css`: reusable tables, cards, metrics, roadmaps, matrices, and profile blocks.
- `illustrations.css`: neutral visual primitives and asset slots.
- `themes/*.css`: color tokens for blue, green, red, pitch, mono, and classic themes.
- `assets/media/`: optional static images, covers, screenshots, and showcase assets.

Generated decks use the same static file order: `fonts.css`, `base.css`, `layouts.css`, `components.css`, `illustrations.css`, one theme file, then `runtime.js`. There is no source build step.

Use `templates/starter-deck.html` for a new deck. `templates/deck.html` is the design-system gallery and component tour. `templates/full-decks/` contains complete storyline archetypes, while `templates/showcase/` contains page-level patterns and theme/layout/component combinations. Public demos live in `examples/` and are maintained separately from templates.

Run `scripts/render.sh path/to/deck.html` to export a self-contained HTML package, PDF, and PNG slide images. Final packages inline local CSS, JavaScript, fonts, and media so `package/index.html` can be opened directly in a browser. Detailed authoring rules live in `SKILL.md` and `references/`.

## Project Structure

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
│   ├── pattern-index.md
│   ├── components.md
│   ├── layouts.md
│   ├── themes.md
│   ├── full-decks.md
│   ├── visual-assets.md
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
│   ├── showcase/
│   ├── components/
│   └── layouts/
├── scripts/
│   ├── new-deck.sh
│   ├── check-deck-quality.sh
│   ├── check-deck-contrast.sh
│   ├── fetch-fonts.sh
│   ├── split-component-css.sh
│   ├── link-agent-adapters.sh
│   └── render.sh
└── examples/
    ├── ai-erp-saas-lop/
    ├── agent-technology-outlook/
    ├── enterprise-intelligence-transformation/
    └── ai-application-investment-thesis/
```

## Contributing

Contributions are welcome through pull requests.

See `CONTRIBUTING.md` for PR expectations, testing notes, and repository hygiene.

## Acknowledgements

Inspired by [lewislulu/html-ppt-skill](https://github.com/lewislulu/html-ppt-skill). This project is written from scratch with its own structure, templates, runtime, and design system.

## License & Author

Apache-2.0. Copyright 2026 Saitop <<saitop@nomici.ai>>.
