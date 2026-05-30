# Layout Catalog

Use simple layouts when the message is the point. Use complex layouts only when the audience must understand multiple moving parts on one page.

## Composition Model

Layouts are page shells. Components are inserted into layout content areas. Themes are applied last.

Use:

1. `templates/neutral-skeleton.html` for structure-first drafting.
2. `templates/layouts/*.html` for page shells.
3. `templates/components/*.html` for reusable blocks.
4. `assets/themes/*.css` for final color direction.

## Simple Layouts

- Cover: title, subtitle, date/meta, optional client mark.
- Default opening: simple first page with optional line-field visual.
- Default opening with visual: title page with one image or product/context visual slot.
- Centered message: one conclusion centered on the page.
- Centered list: 3-5 short points for a transition or focus page.
- Centered metric: one headline number when there is not enough data for a chart.
- Default ending: clean closing page with optional next-step or contact note.
- Dark cover: section-opening or high-emphasis narrative page.
- Statement: one conclusion, one support line, no exhibit.
- Quote: stakeholder voice or customer evidence.
- Media split: short message plus neutral illustration.

Default simple layout snippets:

| file | use when |
| --- | --- |
| `default-opening.html` | First slide for a deck or section. |
| `default-opening-visual.html` | First slide when one supplied image or generated visual should support the title. |
| `default-center-message.html` | One centered conclusion or transition message. |
| `default-center-list.html` | Three to five short centered points. |
| `default-center-metric.html` | One verified headline number with a short explanation. |
| `default-ending.html` | Closing page, thank-you page, or next-step page. |

## Blank Structured Layouts

Use these when the page needs an ordinary business-slide shell before the exact component is known. They are layout slots, not content templates.

| file | use when |
| --- | --- |
| `blank-left-rail.html` | Narrow context/navigation rail plus wide primary exhibit. |
| `blank-split-even.html` | Two comparable modules with equal weight. |
| `blank-left-sidebar.html` | Setup, definitions, or assumptions on the left; analysis on the right. |
| `blank-right-sidebar.html` | Main evidence on the left; implications, risks, or decisions on the right. |
| `blank-right-rail.html` | Very wide exhibit plus a compact legend, caveat, or summary rail. |
| `blank-three-column.html` | Three comparable segments, options, phases, or evidence groups. |

These shells use `.region-layout`, `.region`, `.region-body`, and `.safe-stack`. Insert components from `templates/components/` inside `.region-body`.

Overflow rules:

- Keep each region to one primary component or a small stack of lightweight components.
- If a table, chart, or profile grid does not fit, choose a wider shell, split the page, or reduce the visible data.
- Do not shrink text below legible slide scale just to force content into a region.
- Do not add filler content to occupy empty regions. If the user did not provide enough data, use a simpler layout.

## Medium Layouts

- Agenda: 3-9 numbered sections.
- Content primitives: cards, callouts, and evidence blocks.
- KPI strip: 3-5 executive metrics with short labels.
- Table plus roadmap: dense content with structured hierarchy.
- 2x2 matrix: prioritization or segmentation.
- Contact roster: only when the user provides enough real contact data.
- Chart and takeaways: one chart plus 2-4 implications.
- Heatmap assessment: capability/maturity/fit data with row and column categories.
- Data dashboard: headline metrics plus 1-2 supporting exhibits.

## Complex Layouts

- Issue tree: root question, drivers, and evidence branches.
- Waterfall bridge: baseline-to-target value movement.
- Roadmap swimlane: workstreams across phases.
- Split light/dark shell: contrast page or transition page.
- Profile grid: team, expert, or stakeholder roster.

## Illustration Rules

- Use neutral illustrations only: abstract orbit, stacks, flows, systems, or placeholder avatar forms.
- Do not copy source deck logos, company names, client names, confidentiality text, or identifying marks.
- The illustration must support the title's business message.
- Keep illustrations secondary to the conclusion unless the page is explicitly a conceptual visual.

Current starter layouts live in `templates/deck.html`: cover, dark cover, section divider, agenda, split shell, content primitives, statement, media split, quote, table/roadmap, KPI strip, 2x2 matrix, issue tree, waterfall, roadmap swimlane, and profile primitives.

Dedicated skeleton starters:

- `templates/neutral-skeleton.html`
- `templates/light-skeleton.html`
- `templates/dark-skeleton.html`
- `templates/mixed-skeleton.html`

Reusable layout snippets include `templates/layouts/contact-roster.html` for the contacts case.

Blank structured layout snippets include `templates/layouts/blank-left-rail.html`, `blank-split-even.html`, `blank-left-sidebar.html`, `blank-right-sidebar.html`, `blank-right-rail.html`, and `blank-three-column.html`.

Layout and component CSS are separated:

- Layout shells: `assets/css/layouts.css`
- Components used inside layouts: `assets/css/components.css`
- Illustration primitives and asset slots: `assets/css/illustrations.css`
