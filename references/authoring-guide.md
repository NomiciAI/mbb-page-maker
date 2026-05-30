# Authoring Guide

This guide defines the end-to-end workflow for authoring HTML presentation decks with this skill.

Reference materials must be abstracted into neutral patterns. Do not copy source logos, company names, confidentiality language, client names, or identifying marks into generated HTML.

## System Layers

The design system is layered by responsibility:

1. `assets/css/fonts.css`: webfont imports and font-family variables.
2. `assets/css/base.css`: 16:9 slide canvas, typography defaults, footer, runtime controls, print rules, and shared tokens.
3. `assets/css/layouts.css`: page shells, regions, slots, grids, split areas, and blank layout structures.
4. `assets/css/components.css`: reusable semantic blocks such as agenda grids, tables, charts, cards, profiles, and objective lists.
5. `assets/css/illustrations.css`: neutral illustration primitives and asset slots.
6. `assets/themes/*.css`: color tokens, light/dark mode values, accent behavior, and theme-level visual direction.
7. `assets/media/`: optional static resources such as supplied images, screenshots, generated visuals, diagrams, and showcase-only filler assets.
8. `templates/` and `examples/`: composed pages and decks that combine layout, components, theme, and optional assets.

Keep the base library structure-first. Components and blank layouts should not hard-code brand colors, image treatment, decorative effects, or source-specific marks. Themes and showcase/full-deck examples carry the visual treatment.

Generated decks must load the static files in that order: fonts, base, layouts, components, illustrations, exactly one theme file, then `assets/js/runtime.js`. Do not create a CSS bundle, inline duplicate CSS, or add a build step.

## Template Roles

- `templates/starter-deck.html`: default generation starting point for new decks. It stays light: title cover, simple agenda/context, blank content page, and ending page.
- `templates/deck.html`: design-system gallery and review tour, not the default generation template.
- `templates/neutral-skeleton.html`: structure-first baseline.
- `templates/light-skeleton.html`: default analytical pages.
- `templates/dark-skeleton.html`: dark cover, divider, and high-emphasis shell.
- `templates/mixed-skeleton.html`: mixed dark/light narrative example.

Skeletons do not need identical page inventories. They must share the same CSS/JS load order, 16:9 fit rules, and ordinary slide contract, and each should contain at least one page where a component can be inserted safely.

## Composition Order

Use this order when building a deck:

1. Inspect the user's material and identify the communication task.
2. Draft the storyline and answer-first page messages.
3. Check whether the input has enough data for specialized components.
4. Choose the simplest layout that can hold the message.
5. Place one primary component, or a small stack of related components, inside the layout's content slot.
6. Apply one theme file.
7. Add static assets only when the user supplies them or the deck explicitly needs them.
8. Render and verify the slide at 16:9.

Do not start from color, effects, or images. Start from message, data shape, layout, and component fit.

## Storyline Logic

Build decks as a coherent executive argument, not a collection of pages. The deck should answer the audience's question, then support that answer with the minimum necessary evidence.

Storyline workflow:

1. Define the audience and decision: who is reading, what decision or understanding do they need, and what will they do next?
2. State the governing answer: the top-level recommendation, finding, or conclusion.
3. Group supporting points into 2-5 mutually distinct pillars.
4. Sequence pages so each page advances the argument.
5. Use exhibits to prove or clarify claims, not to decorate.
6. End with implications, decisions, next steps, or appendix as appropriate.

Preferred narrative shape:

1. Context: why this matters now.
2. Answer: the main conclusion or recommendation.
3. Evidence: facts, data, comparisons, or qualitative support.
4. Implication: what the evidence means.
5. Action: decision, roadmap, owner, or next step.

## Slide Title Rules

Content slide titles should be answer-first. A reader should understand the page's point from the title before studying the exhibit.

Good title behavior:

- Use a complete, meaningful sentence for content pages.
- State the conclusion, contrast, implication, or decision.
- Keep one main message per slide.
- Make titles specific enough to distinguish pages from each other.
- Keep section divider titles short when the page is only a divider.

Avoid:

- Generic content titles such as "Overview", "Analysis", "Findings", "Data", "Chart", or "Discussion" on evidence pages.
- Question titles unless the slide is deliberately framing an unresolved decision.
- Titles that describe the exhibit type rather than the insight.
- Multiple unrelated messages in one title.

Examples:

- Weak: "Market overview"
- Strong: "Demand is growing fastest in the two segments where the company already has channel access"
- Weak: "Cost analysis"
- Strong: "Labor and logistics explain most of the margin gap versus priority peers"
- Weak: "Next steps"
- Strong: "The team should validate three assumptions before committing to full rollout"

## Page Message Discipline

Every content page needs a clear page message:

- Claim: what the page is saying.
- Evidence: what proves or supports it.
- Implication: why it matters for the audience.

If a page has evidence without a claim, write the claim before choosing the layout. If a page has a claim without evidence, use a statement/callout page or ask for the missing evidence.

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

Blank layouts are designed to prevent components from resizing the slide canvas, but they cannot make unlimited content fit. `.content`, `.region-body`, `.safe-fill`, and `.safe-stack` provide bounded slots; if content is too large, the correct response is to simplify, split, or choose another layout.

Fit rules:

- Ordinary slides use `section.slide > header + .content + footer`. Cover, ending, and full-bleed pages are deliberate variants.
- Insert components only inside `.content`, `.region-body`, `.safe-fill`, or `.safe-stack`.
- Prefer `blank-content.html` when one component owns the page. Its `.blank-content-slot` is the default ordinary-page entry point for generated content.
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

## Browser Presentation

`assets/js/runtime.js` is the only runtime required for interactive HTML decks:

- Arrow keys, PageUp/PageDown, and Space move through slides.
- Left/right click areas move backward or forward.
- Touch horizontal swipe and trackpad horizontal wheel move slides.
- `o` toggles overview; Escape exits overview.
- `?print=1` activates print/export mode, shows all slides, and hides controls.

## Next Pattern Pass

Future passes should add only neutral, reusable patterns that are justified by real deck-generation cases. Keep source-inspired taxonomy out of visible page headers and public showcase titles.

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
