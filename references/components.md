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

## Composition Order

1. Infer the user's communication task.
2. Choose a layout from `references/layouts.md`.
3. Choose components from this file.
4. Choose one theme from `references/themes.md`.
5. Assemble the page in HTML and verify at 16:9.
