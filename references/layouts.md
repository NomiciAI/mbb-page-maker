# Layout Catalog

Use simple layouts when the message is the point. Use complex layouts only when the audience must understand multiple moving parts on one page.

## Composition Model

Layouts are page shells. Components are inserted into layout content areas. Themes are applied last.

Choose pages by communication job and data shape, not by a fixed template map. A layout can host many component combinations:

- A `blank-right-sidebar` page can hold a chart plus implications, a table plus decisions, or a diagram plus risks.
- A `blank-split-even` page can compare two options, two markets, two operating models, or two evidence blocks.
- A `data-dashboard` page can combine metrics, charts, tables, and callouts depending on the user's data.
- A simple centered page can be better than a specialized page when the input is sparse.

Use:

1. `templates/neutral-skeleton.html` for structure-first drafting.
2. `templates/layouts/*.html` for page shells.
3. `templates/components/*.html` for reusable blocks.
4. `assets/themes/*.css` for final color direction.

## Simple Layout Families

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

Default simple snippets:

| file | use when |
| --- | --- |
| `default-opening.html` | Deck or section start. |
| `default-opening-visual.html` | Opening page with one relevant supplied/generated visual. |
| `default-center-message.html` | One conclusion, transition, or decision prompt. |
| `default-center-list.html` | A short set of parallel points. |
| `default-center-metric.html` | One verified number plus meaning. |
| `default-ending.html` | Closing, next-step, or appendix pointer. |

Selection guidance:

- Use simple pages when the point is stronger than the exhibit.
- Use centered pages for emphasis, not for dense explanation.
- Use visual opening pages only when the visual adds meaning. Otherwise keep the opening clean.

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

Composition examples:

- Left rail + chart/table: context filters on the left, primary exhibit on the right.
- Even split + cards/tables/charts: compare two things with parallel evidence.
- Right sidebar + callouts: primary evidence on the left, implications or decisions on the right.
- Right rail + legend/source/caveat: very wide exhibit with a compact supporting rail.
- Three columns + cards/metrics/profiles: comparable segments, options, or phases.

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

Medium pages usually combine one dominant component with supporting components. Keep the page logic top-down: title first, exhibit second, implications third.

## Complex Layouts

- Issue tree: root question, drivers, and evidence branches.
- Waterfall bridge: baseline-to-target value movement.
- Roadmap swimlane: workstreams across phases.
- Split light/dark shell: contrast page or transition page.
- Profile grid: team, expert, or stakeholder roster.

Use complex layouts only when the source material has enough structure. If the user gives prose without drivers, values, phases, or dimensions, use cards, statement, or a blank structured shell instead.

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
