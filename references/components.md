# Component Catalog

Components are composable blocks used inside layout templates. Pick components after choosing the layout and before choosing the final theme.

Components should be structure-first:

- Do not bake theme-specific colors, image choices, decorative effects, or brand marks into component selection.
- Use semantic classes and theme tokens only. Themes decide color, emphasis, dark/light mode, and visual effects.
- Images belong in user content, `assets/media/`, or showcase/full-deck examples, not generic component rules.
- If a component needs highlighting, use structural states such as `.is-active`, `.is-focus`, or `.highlight`; the theme decides how that state looks.

## Selection Rules

- Use `card` for repeated, comparable ideas.
- Use `callout` for a single implication or decision ask.
- Use `metric-strip` when the page needs 3-5 headline numbers.
- Use `table` when comparison needs row/column precision.
- Use `agenda-list` for narrative structure.
- Use `catalog-grid` for section catalogs or contents pages.
- Use `objective-list` plus `objective-summary` for meeting objectives and decision framing.
- Use `agenda-table` for timed workshops with topics and outcomes.
- Use `simple-agenda-grid` for non-timed agendas with numbered modules.
- Use `illustration-orbit` when the page needs neutral visual support without external assets.
- Use `profile` for team, expert, or stakeholder pages.
- Use `contact-card` only when the input contains real contact records.
- Use `column-chart` for one categorical series when vertical comparison is appropriate and labels are short.
- Use `quadrant-matrix` for qualitative 2x2 prioritization, segmentation, or portfolio positioning.
- Use `risk-matrix-register` when risk placement must be paired with owners, mitigations, scores, or next actions.
- Use `range-competency-chart` when capabilities have current and target levels on the same numeric scale.
- Use `dot-scale-comparison` for relative positioning on a shared scale when exact axis precision is secondary.
- Use `range-comparison-plot` for benchmark ranges, peer min/max bands, or confidence intervals with a current marker.
- Use `pie-chart` only for a small number of part-to-whole splits where the total is explicit.
- Use `donut-chart` when the center message matters as much as the part-to-whole split.
- Use `chart-bars` when the input contains labeled numeric categories.
- Use `ranked-bars` for ordered categorical ranking.
- Use `stacked-bars` for composition across categories.
- Use `heatmap` for capability, maturity, fit, or assessment scores across two categorical dimensions.
- Use `diverging-heatmap` when values can move below and above a neutral midpoint.
- Use `scatter-plot` when the data has two numeric dimensions.
- Use `comparison-table` when options must be compared across consistent criteria.

## Sufficiency Rules

Do not output components that add no information.

- Contact card: needs a name plus at least one supporting field such as role, location, team, email, or responsibility.
- Contact roster page: needs at least 3 usable contact records. If fewer, use a compact card group inside another page or omit.
- Principal contacts: only mark contacts as principal when the user supplies that grouping or a clear equivalent.
- Column chart: needs at least 2 labeled numeric values. Use at most one `.is-highlight` item unless the user explicitly asks to compare multiple focus categories.
- Bar chart: needs at least 2 labeled numeric values. If exact numeric values matter more than visual comparison, use a table.
- Ranked bars: needs sortable numeric values.
- Stacked bars: needs category parts that sum to a meaningful total.
- Heatmap: needs row labels, column labels, and cell ratings or scores.
- Scatter plot: needs x and y values for each point.
- Comparison table: needs options and shared criteria.
- Metric strip: needs 3-5 high-signal metrics. If there is only one number, use a statement or callout.
- Table: needs consistent row/column structure. Do not force prose into a table.
- Catalog grid: needs at least 3 sections. If there are more than 9 sections, split the catalog or use a denser list.
- Objective list: needs at least 3 objectives or agenda items. Highlight only one item unless the user asks for multiple focus areas.
- Agenda table: needs time blocks plus topic, outcome, owner, or speaker fields. If times are missing, use `simple-agenda-grid`.
- Simple agenda grid: use for 3-9 items with short parallel labels.
- Quadrant matrix: needs two meaningful dimensions and at least one point, option, segment, or initiative. Do not use a quadrant when only a ranked list is needed.
- Risk matrix with register: needs risk names plus at least one of owner, mitigation, status, score, likelihood, or impact. Use a plain table if the user only provides a risk list.
- Range competency chart: needs a shared numeric or ordinal scale and at least two capabilities. Current and target markers must mean the same thing across rows.
- Dot-scale comparison: needs a common left-to-right interpretation for every row. If rows use different scales, use a table.
- Range comparison plot: needs min/max or low/high values plus a marker or target. Do not invent ranges from single-point data.
- Pie chart: needs parts that sum to a meaningful total, ideally 2-5 slices. Use a table for more slices or small differences.
- Donut chart: needs a center message or total that adds context. Otherwise use `pie-chart` or `stacked-bars`.
- Diverging heatmap: needs a neutral midpoint and categorical rows/columns. Use regular `heatmap` for one-direction scores.

## Data Display Router

- Time series: use a line chart pattern when available; until then, use a table or bar chart only if it remains honest.
- Categorical comparison: use `column-chart` for a compact single-series vertical comparison with short labels, `ranked-bars` for visual ranking, `chart-bars` for horizontal category labels, or `table` for exact values and many fields.
- Part-to-whole: use `pie-chart` or `donut-chart` for one or two simple splits, `stacked-bars` for composition across many categories, and `table` when percentages need exact auditability.
- Two-dimensional opportunity: use `scatter-plot` if both axes are numeric, or `quadrant-matrix` if the axes are qualitative.
- Risk view: use `risk-matrix-register` when likelihood/impact placement and action tracking both matter.
- Capability/maturity assessment: use `heatmap` for one-direction scores or `range-competency-chart` when current-vs-target gaps are the message.
- Benchmark spread: use `range-comparison-plot` for min/max, confidence interval, peer range, or low/base/high inputs.
- Relative scorecard: use `dot-scale-comparison` when every row can share the same left-to-right scale.
- Diverging categorical data: use `diverging-heatmap` for negative-to-positive movement or below/above-neutral measures.
- Option evaluation: use `comparison-table`.
- Few headline KPIs: use `metric-strip`.
- Many records with mixed fields: use `table`.
- No numeric data: do not create a chart.

## Snippets

| file | purpose |
| --- | --- |
| `templates/components/card.html` | Repeated idea or evidence block. |
| `templates/components/callout.html` | One implication or decision statement. |
| `templates/components/metric-strip.html` | Four headline metrics. |
| `templates/components/agenda-list.html` | Three-item agenda list starter. |
| `templates/components/catalog-grid.html` | Contents or section catalog grid. |
| `templates/components/objective-list.html` | Objective list with optional active marker. |
| `templates/components/objective-summary.html` | Summary/objectives text block. |
| `templates/components/agenda-table.html` | Timed workshop agenda rows. |
| `templates/components/simple-agenda-grid.html` | Numbered agenda grid. |
| `templates/components/table.html` | Compact comparison table. |
| `templates/components/illustration-orbit.html` | Neutral abstract illustration. |
| `templates/components/profile.html` | Profile row with generated avatar placeholder. |
| `templates/components/contact-card.html` | Single contact with optional photo. |
| `templates/components/column-chart.html` | Single-series vertical category chart with optional highlighted column. |
| `templates/components/quadrant-matrix.html` | Qualitative 2x2 matrix with points and legend. |
| `templates/components/risk-matrix-register.html` | Impact/likelihood matrix plus action-oriented register. |
| `templates/components/range-competency-chart.html` | Current vs. target capability rows on a shared scale. |
| `templates/components/dot-scale-comparison.html` | Dot-on-line relative comparison rows. |
| `templates/components/range-comparison-plot.html` | Benchmark range bands with current markers and notes. |
| `templates/components/pie-chart.html` | One or two compact part-to-whole pie splits. |
| `templates/components/donut-chart.html` | Donut split with a center message and legend. |
| `templates/components/diverging-heatmap.html` | Negative-neutral-positive heatmap with legend. |
| `templates/components/chart-bars.html` | Static categorical bar chart. |
| `templates/components/ranked-bars.html` | Ordered categorical ranking. |
| `templates/components/stacked-bars.html` | Composition bars. |
| `templates/components/heatmap.html` | Capability or assessment heatmap. |
| `templates/components/scatter-plot.html` | Two-axis opportunity map. |
| `templates/components/comparison-table.html` | Options compared against criteria. |

## Showcase-Only Assets

Bundled headshots in `assets/media/headshots/` are for showcase and full-deck demo pages only. Do not use them in generated user decks unless the user explicitly asks for placeholder demo contacts.

## Agenda And Objectives Composition

- A title cover must include a real title. A brand-only or blank visual page is not a default title cover.
- Use `catalog-grid` when the user provides section names or a deck table of contents.
- Use `objective-list` alone for a compact left rail or transition page.
- Combine `objective-list` with `objective-summary` inside a split layout when the page needs both agenda navigation and meeting purpose.
- Use `agenda-table` when the source has time blocks. Do not invent times.
- Use `simple-agenda-grid` when the source has ordered agenda items without time blocks.
- Keep agenda item labels short. Move explanatory text to a summary, notes, or outcome component.

## Minimal Blank-Page Composition

Use `templates/layouts/blank-content.html` when one component owns the whole content area:

```html
<section class="slide" data-title="Agenda">
  <header>
    <h2 class="slide-title">Agenda</h2>
    <div class="slide-rule"></div>
  </header>
  <div class="content">
    <!-- paste templates/components/simple-agenda-grid.html here -->
  </div>
  <footer class="footer">
    <span>Source or note</span>
    <span class="page-number"></span>
  </footer>
</section>
```

For a single-series chart page:

```html
<div class="content">
  <!-- paste templates/components/column-chart.html here -->
</div>
```

Use `.is-highlight` on one column only when the title or narrative calls attention to that category. The theme controls the highlight color.

Use one content area with a small stack when components support the same message:

```html
<div class="content">
  <div class="safe-stack">
    <!-- paste templates/components/objective-list.html here -->
    <!-- paste templates/components/objective-summary.html here -->
  </div>
</div>
```

Use blank region layouts only when the page needs separate zones:

```html
<div class="content no-top">
  <div class="region-layout right-sidebar">
    <main class="region has-frame-lines">
      <div class="region-body">
        <!-- paste primary component here -->
      </div>
    </main>
    <aside class="region is-muted has-frame-lines">
      <div class="region-body">
        <!-- paste supporting component here -->
      </div>
    </aside>
  </div>
</div>
```

## Composition Order

1. Infer the user's communication task.
2. Choose a layout from `references/layouts.md`.
3. Choose components from this file.
4. Choose one theme from `references/themes.md`.
5. Assemble the page in HTML and verify at 16:9.
