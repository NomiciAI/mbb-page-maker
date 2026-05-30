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

Dark backgrounds must always activate a dark token context. Use `.dark`, `[data-mode="dark"]`, `.dark-cover`, or `[data-variant="dark-cover"]`; do not set a dark background alone. The token context is what flips text, muted text, rules, panels, and accents for every theme.

The runtime adds a slide-level `auto-dark` safety class when it detects a dark slide background without a dark token context. Treat this as a guardrail, not an authoring pattern: authors should still declare the mode explicitly and run the contrast audit before delivery.

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
4. For full decks, inspect the closest exemplar in `templates/full-decks/` after reading `references/full-decks.md`.
5. Create a slide plan before writing HTML.
6. Choose the simplest layout that can hold the message.
7. Place one primary component, or a small stack of related components, inside the layout's content slot.
8. Apply one theme file.
9. Add static assets only when the user supplies them or the deck explicitly needs them.
10. Render and verify the slide at 16:9.
11. Run `scripts/check-deck-quality.sh path/to/deck.html` and fix empty section pages or missing evidence components.
12. Run `scripts/check-deck-contrast.sh path/to/deck.html` and fix any failed text/background contrast pairs.
13. Render the default PDF with `scripts/render.sh path/to/deck.html` unless the user requested HTML only.

Do not start from color, effects, or images. Start from message, data shape, layout, and component fit.

## Slide Planning Gate

Before writing deck HTML, make a compact internal plan. For every slide, define:

- Message: the answer-first title or section purpose.
- Source evidence: the exact source fields, numbers, claims, or records used.
- Layout: the shell from `templates/layouts/` or starter/skeleton variant.
- Components: the reusable component(s) from `templates/components/`.
- Output role: cover, executive answer, data evidence, comparison, roadmap, decision, appendix, or closing.

Do not proceed to HTML when a body slide has no component choice. The only valid component-light pages are cover, closing, and deliberate section dividers in longer decks. Deliberate pure dividers must use `data-allow-divider="true"` so quality checks can distinguish intent from accidental empty pages.

For short decks, avoid pure section dividers. If the user asks for three sections, each section should usually start with an evidence page or a section-intro page that contains 2-4 metrics, a mini catalog, or a clear summary. A page that only says "Section 02 / Data support" is too weak when the source contains enough data to chart, rank, compare, or tabulate.

Component coverage expectations:

- Data section: at least one chart, ranked bar, table, heatmap, matrix, range plot, or metric strip.
- Industry or market section: at least one comparison, ranking, matrix, heatmap, timeline, or table.
- Fundamental analysis section: at least one table, metric strip, outcome-support, issue tree, or comparison component.
- Execution or recommendation section: roadmap, decision-log, process-flow, stage-gate, pros-cons, or milestone-track.

If useful structured data exists, do not replace it with only prose cards. Cards are acceptable for synthesis, but evidence pages should show the data structure.

## Evidence Extraction

When the user provides a report, notes, transcript, or raw text file, extract the deck substance before choosing slides:

- Claims: management conclusions, analyst views, user asks, and stated recommendations.
- Quantitative facts: revenue, growth, margin, valuation, share, count, timing, ranges, and rankings.
- Comparisons: peers, segments, regions, customers, alternatives, industries, historical periods.
- Causal drivers: why performance changed, why the opportunity exists, why risk matters.
- Uncertainty: missing verification, rumors, assumptions, dependencies, or conflicting signals.
- Decisions: what the audience should approve, monitor, defer, or investigate.

Then compress the material into a storyline. Use the strongest evidence as exhibits and put weaker or repetitive details into notes, appendix, or omit them. Do not make a slide for every paragraph in the source.

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
- Keep separator lines sparse. The title rule should have breathing room below the title, and ordinary region layouts should not use an outer border unless framing is the point.
- Do not let a small component float alone in a large region; use a simpler centered page or add a relevant supporting component.
- Do not fill empty space with invented content.
- Keep repeated components visually consistent: same heading length, similar line count, and parallel field order.

## Browser Presentation

`assets/js/runtime.js` is the only runtime required for interactive HTML decks:

- Arrow keys, PageUp/PageDown, and Space move through slides.
- Left/right click areas move backward or forward.
- Touch horizontal swipe and trackpad horizontal wheel move slides.
- Slide changes use a short transition and edge bump so click, keyboard, touch, and trackpad navigation feel responsive without adding dependencies.
- `o` toggles overview thumbnails; Escape exits overview.
- `?print=1` activates print/export mode, shows all slides, and hides controls.

Present mode uses a fixed 1600x900 slide canvas that scales as a whole to the browser viewport. Do not add runtime behavior or CSS breakpoints that reflow slide internals for narrow browser widths.

## Contrast Audit

## Quality Audit

Run the quality audit before contrast and export:

```bash
scripts/check-deck-quality.sh path/to/index.html
```

The script fails section-like or low-density body slides that have no evidence/component structure. This catches the common failure mode where an agent creates a page such as "Section 02 / Data support" even though the section should contain charts, tables, rankings, matrices, or metrics.

When the audit fails:

- Add a real evidence component to the slide.
- Merge the divider into the next evidence page.
- Or, only for longer decks where pacing genuinely needs a pure divider, add `data-allow-divider="true"`.

## Contrast Audit

Every generated deck should pass the built-in visibility audit:

```bash
scripts/check-deck-contrast.sh path/to/index.html
```

The script opens the deck in headless Chrome with `?print=1&audit=1`, computes real browser styles, and fails on text/background contrast below WCAG-style thresholds: 4.5:1 for normal text and 3:1 for large or bold text. Use it after changing themes, adding dark section dividers, inserting image overlays, or writing inline styles.

If the audit fails:

- Add `.dark`, `[data-mode="dark"]`, `.dark-cover`, or `[data-variant="dark-cover"]` to dark slides.
- Move dark panels into a proper dark token context or choose a lighter panel token.
- Do not patch failures by hiding text, shrinking text, or hardcoding one-off colors in components.
- Prefer theme tokens over inline colors so the same deck works across `mono`, `blue`, `red`, `green`, and custom themes.

## Next Pattern Pass

Future passes should add only neutral, reusable patterns that are justified by real deck-generation cases. Keep source-inspired taxonomy out of visible page headers and public showcase titles.

## Asset Path Rule

When copying snippets into a real deck, normalize asset paths to the deck location:

- `templates/*.html`: usually `../assets/...`
- `examples/<name>/index.html`: usually `../../assets/...`
- generated deck folders from `scripts/new-deck.sh`: usually `assets/...`

Before delivery, use `scripts/render.sh path/to/index.html`. The default export creates `dist/package/index.html`, `dist/index.pdf`, and `dist/png/` for browser, WeChat file preview, and WeChat image preview use cases. The package step rewrites local paths and inlines local CSS, JavaScript, and media into `dist/package/index.html`, so that final HTML file can be opened directly by a browser without the source asset tree.

The delivery package must not depend on remote runtime resources. Do not use CDN chart libraries, remote images, dynamic script/module loaders, or stylesheet imports in generated decks. The exporter intentionally fails if the package still contains external stylesheets, external scripts, CSS `@import`, or non-embedded media URLs.

## Static Asset Rule

Use static assets only as content or showcase material:

- Supplied photos, screenshots, diagrams, or generated images belong in `assets/media/`.
- Generic components should not require images.
- Showcase-only assets can demonstrate visual possibilities but should not become default generation behavior.
- If an image is required, use a layout with an explicit media slot and verify that cropping does not hide the subject.
