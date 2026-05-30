# Pattern Index

Use this index to choose the right authoring reference before writing HTML.

## Route By Task

| Task | Read first | Then inspect |
| --- | --- | --- |
| Full deck, strategy deck, investment memo, board update, transformation deck, technology outlook | `references/full-decks.md` | Relevant `templates/full-decks/<slug>/README.md`, then `templates/full-decks/<slug>/index.html` as an archetype reference |
| Single page, partial deck, or local page rewrite | `templates/showcase/README.md` | Relevant `templates/showcase/*.html`, then recombine with `templates/components/*.html` |
| New full-deck archetype, layout, component, or recurring pattern | `references/adding-patterns.md` | Existing references for full decks, layouts, components, and showcase catalog |
| Unclear evidence shape | `references/authoring-guide.md` | `references/components.md` and `references/layouts.md` |

## Full-Deck Archetype Rule

Each full-deck archetype must include:

- `templates/full-decks/<slug>/README.md` for quick agent indexing.
- `templates/full-decks/<slug>/index.html` for the inspectable storyline skeleton.

Agents should read the README sidecar before inspecting the HTML. The README explains when to use the archetype, visual traits, storyline pattern, component stack, source inspiration, evidence shape, related showcase patterns, flexible swaps, and when to diverge.

The archetype is a reference for pacing and composition. Do not copy page order, page count, or content when the user's material calls for a different answer.

## Showcase Metadata Rule

`templates/showcase/README.md` is the catalog for reusable page-level thinking patterns and layout + component combinations. Use it when a task needs one or several pages but not a full archetype storyline.

Do not turn showcase files into duplicate full decks. Showcase files validate communication jobs, evidence shapes, combinations, page fit, and theme behavior; full-deck archetypes validate storyline pacing.

## Source Priority

1. User-provided content and evidence.
2. Approved external data when the user asks for online/current/public research or grants permission.
3. Full-deck archetypes and showcase files for structure, not for copied content.
4. Components and layouts for implementation details.

`examples/*` are independent public demo decks, not authoring sources and maintained separately from templates.
