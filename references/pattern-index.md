# Pattern Index

Use this index to choose the right authoring reference before writing HTML.

## Route By Task

| Task | Read first | Then inspect |
| --- | --- | --- |
| Full deck, strategy deck, investment memo, board update, transformation deck, technology outlook | `references/full-decks.md` | Closest `templates/full-decks/<slug>/README.md`, then `templates/full-decks/<slug>/index.html` |
| Single page, partial deck, or local page rewrite | `templates/showcase/README.md` | Closest `templates/showcase/*.html`, then relevant `templates/components/*.html` |
| New full-deck exemplar, layout, component, or recurring pattern | `references/adding-patterns.md` | Existing references for full decks, layouts, components, and showcase catalog |
| Unclear evidence shape | `references/authoring-guide.md` | `references/components.md` and `references/layouts.md` |

## Full-Deck Metadata Rule

Each editable full-deck exemplar must include:

- `templates/full-decks/<slug>/README.md` for quick agent indexing.
- `templates/full-decks/<slug>/index.html` for the actual authoring exemplar.
- A generated public demo under `examples/<slug>/index.html` created by `scripts/sync-examples.sh`.

Agents should read the README sidecar before inspecting the HTML. The README explains when to use the exemplar, visual traits, storyline pattern, component stack, source inspiration, evidence shape, and related showcase patterns.

## Showcase Metadata Rule

`templates/showcase/README.md` is the catalog for reusable layout + component combinations. Use it when a task needs one or several pages but not a full exemplar storyline.

Do not turn showcase files into duplicate full decks. Showcase files validate combinations, page fit, and theme behavior; full-deck exemplars validate storyline pacing.

## Source Priority

1. User-provided content and evidence.
2. Approved external data when the user asks for online/current/public research or grants permission.
3. Full-deck exemplars and showcase files for structure, not for copied content.
4. Components and layouts for implementation details.

`examples/*` are public demo outputs, not authoring sources.
