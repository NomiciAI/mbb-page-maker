# Component Catalog

Components are composable blocks used inside layout templates. Pick components after choosing the layout and before choosing the final theme.

## Selection Rules

- Use `card` for repeated, comparable ideas.
- Use `callout` for a single implication or decision ask.
- Use `metric-strip` when the page needs 3-5 headline numbers.
- Use `table` when comparison needs row/column precision.
- Use `agenda-list` for narrative structure.
- Use `illustration-orbit` when the page needs neutral visual support without external assets.
- Use `profile` for team, expert, or stakeholder pages.
- Use `contact-card` only when the input contains real contact records.
- Use `chart-bars` when the input contains labeled numeric categories.

## Sufficiency Rules

Do not output components that add no information.

- Contact card: needs a name plus at least one supporting field such as role, location, team, email, or responsibility.
- Contact roster page: needs at least 3 usable contact records. If fewer, use a compact card group inside another page or omit.
- Principal contacts: only mark contacts as principal when the user supplies that grouping or a clear equivalent.
- Bar chart: needs at least 2 labeled numeric values. If exact numeric values matter more than visual comparison, use a table.
- Metric strip: needs 3-5 high-signal metrics. If there is only one number, use a statement or callout.
- Table: needs consistent row/column structure. Do not force prose into a table.

## Data Display Router

- Time series: use a line chart pattern when available; until then, use a table or bar chart only if it remains honest.
- Categorical comparison: use `chart-bars` for visual ranking, or `table` for exact values and many fields.
- Part-to-whole: use a future donut/stacked component; if unavailable, use a table with percentages.
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
| `templates/components/table.html` | Compact comparison table. |
| `templates/components/illustration-orbit.html` | Neutral abstract illustration. |
| `templates/components/profile.html` | Profile row with generated avatar placeholder. |
| `templates/components/contact-card.html` | Single contact with optional photo. |
| `templates/components/chart-bars.html` | Static categorical bar chart. |

## Composition Order

1. Infer the user's communication task.
2. Choose a layout from `references/layouts.md`.
3. Choose components from this file.
4. Choose one theme from `references/themes.md`.
5. Assemble the page in HTML and verify at 16:9.
