# Layout Catalog

Use simple layouts when the message is the point. Use complex layouts only when the audience must understand multiple moving parts on one page.

## Composition Model

Layouts are page shells. Components are inserted into layout content areas. Themes are applied last.

The base layout and component library should stay visually neutral. Color, decorative line fields, image treatment, and dark/light effects belong to theme files, showcase pages, or deliberate layout variants.

Choose pages by communication job and data shape, not by a fixed template map. A layout can host many component combinations:

- A `blank-right-sidebar` page can hold a chart plus implications, a table plus decisions, or a diagram plus risks.
- A `blank-split-even` page can compare two options, two markets, two operating models, or two evidence blocks.
- A `data-dashboard` page can combine metrics, charts, tables, and callouts depending on the user's data.
- A simple centered page can be better than a specialized page when the input is sparse.

Use:

1. `templates/starter-deck.html` for a new generated deck.
2. `templates/neutral-skeleton.html` for structure-first drafting.
3. `templates/layouts/blank-content.html` for the simplest full-content component page.
4. `templates/layouts/*.html` for page shells.
5. `templates/components/*.html` for reusable blocks.
6. `assets/themes/*.css` for final color direction.

## Simple Layout Families

- Cover: title, subtitle, date/meta, optional client mark.
- Simple title cover: title, optional subtitle/meta, optional abstract visual. Must include a main title.
- Default opening: simple first page with optional neutral visual treatment. Must include a main title.
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
| `blank-content.html` | One component or a small component stack should occupy the main content area. |
| `simple-title-cover.html` | Basic deck title page. Do not use a brand-only page as the default title cover. |
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
- A blank/brand-only cover is not a valid default cover. Use it only as a deliberate divider or showcase page.

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

Ordinary layout snippets should keep the contract `section.slide > header + .content + footer`. Use cover, ending, or full-bleed variants only when that page type requires it.

Composition examples:

- `blank-content` + `catalog-grid`: one contents/catalog component owns the page.
- `blank-content` + `agenda-table`: one timed workshop agenda owns the page.
- `blank-content` + `safe-stack`: several small components support the same message in one content area.
- `blank-left-rail` + `objective-list` + primary exhibit: context/navigation on the left, evidence on the right.
- `blank-split-even` + parallel components: compare two options, markets, operating models, or evidence blocks.
- `blank-right-sidebar` + primary component + supporting component: evidence on the left, implications or decisions on the right.
- `blank-right-rail` + wide component + compact support: wide table/chart/timeline with legend, caveat, or source note.
- `blank-three-column` + comparable components: segments, options, phases, or profile groups.

Overflow rules:

- Keep each region to one primary component or a small stack of lightweight components.
- If a table, chart, or profile grid does not fit, choose a wider shell, split the page, or reduce the visible data.
- Do not shrink text below legible slide scale just to force content into a region.
- Do not add filler content to occupy empty regions. If the user did not provide enough data, use a simpler layout.

## Medium Layouts

- Agenda: 3-9 numbered sections.
- Content catalog: numbered section grid for a deck table of contents.
- Meeting objectives: objective list plus optional summary/objectives panel.
- Workshop agenda: time/topic/outcome agenda table.
- Simple agenda: numbered agenda grid without time blocks.
- Content primitives: cards, callouts, and evidence blocks.
- KPI strip: 3-5 executive metrics with short labels.
- Table plus roadmap: dense content with structured hierarchy.
- 2x2 matrix: prioritization or segmentation.
- Risk matrix plus register: use a wide content area or right-sidebar shell only when action tracking is needed.
- Range/competency chart: use a wide content area because row labels, gaps, and scale markers need horizontal space.
- Dot-scale or range comparison: use a wide content area; add a sidebar only for interpretation notes.
- Pie/donut split: use split-even or blank-content when the total and legend can remain legible.
- Contact roster: only when the user provides enough real contact data.
- Chart and takeaways: one chart plus 2-4 implications.
- Heatmap assessment: capability/maturity/fit data with row and column categories.
- Diverging heatmap: use blank-content and keep rows/columns bounded; split across pages if labels or cells overflow.
- Data dashboard: headline metrics plus 1-2 supporting exhibits.

Medium pages usually combine one dominant component with supporting components. Keep the page logic top-down: title first, exhibit second, implications third.

Agenda and objectives snippets include `content-catalog.html`, `meeting-objectives-list.html`, `workshop-agenda.html`, and `simple-agenda.html`. They should be treated as examples of component composition, not fixed outputs.

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

`templates/starter-deck.html` is the default generation base. It contains a cover, agenda/summary page, analytical placeholder page, and ending page.

Current gallery layouts live in `templates/deck.html`: cover, dark cover, section divider, agenda, split shell, content primitives, statement, media split, quote, table/roadmap, KPI strip, 2x2 matrix, issue tree, waterfall, roadmap swimlane, and profile primitives.

Dedicated skeleton starters:

- `templates/neutral-skeleton.html`
- `templates/light-skeleton.html`
- `templates/dark-skeleton.html`
- `templates/mixed-skeleton.html`

Upcoming Conceptuals & Visuals components to extract in a later pass: `pyramid-stack`, `cause-effect`, `outcome-support`, `diverging-textboxes`, and `from-to-multi`.

Reusable layout snippets include `templates/layouts/contact-roster.html` for the contacts case.

Blank structured layout snippets include `templates/layouts/blank-left-rail.html`, `blank-split-even.html`, `blank-left-sidebar.html`, `blank-right-sidebar.html`, `blank-right-rail.html`, and `blank-three-column.html`.

Layout and component CSS are separated:

- Layout shells: `assets/css/layouts.css`
- Components used inside layouts: `assets/css/components.css`
- Illustration primitives and asset slots: `assets/css/illustrations.css`
