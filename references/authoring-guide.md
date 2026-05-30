# Authoring Guide

This guide defines the end-to-end workflow for authoring HTML presentation decks with this skill.

Reference materials must be abstracted into neutral patterns. Do not copy source logos, company names, confidentiality language, client names, or identifying marks into generated HTML.

## System Layers

The design system is layered by responsibility:

1. `assets/css/fonts.css`: webfont imports and font-family variables.
2. `assets/css/base.css`: 16:9 slide canvas, typography defaults, footer, runtime controls, and shared tokens.
3. `assets/themes/*.css`: color tokens, light/dark mode values, accent behavior, and theme-level visual direction.
4. `assets/css/layouts.css`: page shells, regions, slots, grids, split areas, and blank layout structures.
5. `assets/css/components.css`: reusable semantic blocks such as agenda grids, tables, charts, cards, profiles, and objective lists.
6. `assets/css/illustrations.css`: neutral illustration primitives and asset slots.
7. `assets/media/`: optional static resources such as supplied images, screenshots, generated visuals, diagrams, and showcase-only filler assets.
8. `templates/` and `examples/`: composed pages and decks that combine layout, components, theme, and optional assets.

Keep the base library structure-first. Components and blank layouts should not hard-code brand colors, image treatment, decorative effects, or source-specific marks. Themes and showcase/full-deck examples carry the visual treatment.

## Composition Order

Use this order when building a deck:

1. Inspect the user's material and identify the communication task.
2. Check whether the input has enough data for specialized components.
3. Choose the simplest layout that can hold the message.
4. Place one primary component, or a small stack of related components, inside the layout's content slot.
5. Apply one theme file.
6. Add static assets only when the user supplies them or the deck explicitly needs them.
7. Render and verify the slide at 16:9.

Do not start from color, effects, or images. Start from message, data shape, layout, and component fit.

## Content Sufficiency Gate

Before selecting a specialized page, inspect the user's input:

1. Identify the data type: contacts, metrics, time series, categorical values, prose themes, decisions, roadmap steps, or mixed records.
2. Check whether required fields exist.
3. If fields are missing, choose a simpler layout or omit the page.
4. Never invent names, numbers, roles, dates, sources, or group labels.

Examples:

- Contacts: use a contact roster only with enough contact records.
- Numeric categories: use a bar chart only with labels and values.
- Exact multi-field data: use a table.
- Sparse prose: use statement, cards, or callout.
- Ordered phases: use timeline or roadmap.

## Layout And Component Fit

Blank layouts are designed to prevent components from resizing the slide canvas, but they cannot make unlimited content fit. `content`, `region`, `region-body`, and `safe-stack` provide bounded slots; if content is too large, the correct response is to simplify, split, or choose another layout.

Fit rules:

- Prefer `blank-content.html` when one component owns the page.
- Use region layouts only when the page needs separate zones.
- Keep one primary component per region.
- Use `safe-stack` only for small components that support the same message.
- If text or data overflows, reduce fields, split the page, or use a wider layout.
- Do not shrink typography below legible slide scale to force content into a region.

Alignment and visual balance:

- Keep title, content, and footer aligned to the same page grid unless the layout deliberately creates separate regions.
- Preserve enough whitespace around dense tables, charts, and agendas.
- Do not let a small component float alone in a large region; use a simpler centered page or add a relevant supporting component.
- Do not fill empty space with invented content.
- Keep repeated components visually consistent: same heading length, similar line count, and parallel field order.

## Asset Path Rule

When copying snippets into a real deck, normalize asset paths to the deck location:

- `templates/*.html`: usually `../assets/...`
- `examples/<name>/index.html`: usually `../../assets/...`
- generated deck folders from `scripts/new-deck.sh`: usually `assets/...`

## Static Asset Rule

Use static assets only as content or showcase material:

- Supplied photos, screenshots, diagrams, or generated images belong in `assets/media/`.
- Generic components should not require images.
- Showcase-only assets can demonstrate visual possibilities but should not become default generation behavior.
- If an image is required, use a layout with an explicit media slot and verify that cropping does not hide the subject.
