# Adding Patterns

Use this guide when adding full-deck exemplars, layout shells, or reusable components. Add patterns only when they improve repeated deck generation; do not add one-off HTML for a single prompt.

## New Full-Deck Exemplar

1. Write a short storyline brief before HTML:
   - audience and decision
   - governing answer
   - 2-5 supporting pillars
   - evidence inventory: claims, numbers, comparisons, time periods, risks, and decisions
   - planned slide list with message, evidence, layout, and component
2. Build the deck in `templates/full-decks/<slug>/index.html`.
3. Use existing layouts and components first. Add a new component only if the same content job will recur.
4. Keep content fictional, generic, and source-neutral. Do not include consulting-firm marks, client marks, source notes, or placeholder agency brands.
5. Update `references/full-decks.md` with the archetype, when-to-use guidance, and closest-exemplar routing.
6. Run:

```bash
scripts/check-deck-quality.sh templates/full-decks/<slug>/index.html
scripts/check-deck-contrast.sh templates/full-decks/<slug>/index.html
scripts/render.sh templates/full-decks/<slug>/index.html tmp/render/<slug> --all
scripts/sync-examples.sh
scripts/sync-examples.sh --check
```

`templates/full-decks` is the editable source of truth. `examples` is generated public demo output.

Do not commit `dist/`, PDF, or PNG outputs under `templates/full-decks`. Render outputs are validation artifacts only; full-deck exemplars should stay lightweight source folders.

## New Layout Shell

Add a layout only when existing bounded slots cannot hold the communication job.

Requirements:

- Put the snippet in `templates/layouts/<name>.html`.
- Keep the ordinary slide contract unless it is a deliberate cover, ending, or full-bleed variant: `section.slide > header + .content + footer`.
- Provide bounded insertion slots: `.content`, `.region-body`, `.safe-fill`, or `.safe-stack`.
- Preserve 16:9 fit at the default 1600x900 canvas.
- Use layout classes and theme tokens only; do not hard-code brand color, source marks, or decorative assets.
- Update `references/layouts.md` with when-to-use and overflow guidance.

## New Component

Add a component only for a repeated content job with a clear data shape.

Requirements:

- Put the snippet in `templates/components/<name>.html`.
- Add or reuse component CSS in `assets/css/components.css` with semantic classes and theme tokens.
- Define sufficiency rules in `references/components.md`: required fields, minimum records, and when not to use it.
- Add data-router guidance if the component handles a new evidence type.
- Ensure text uses `currentColor` or theme tokens and works in dark token contexts.
- Add the component class to `scripts/check-deck-quality.sh` if it should count as evidence structure.
- Validate the component inside at least one bounded layout and one full-deck or showcase page before treating it as agent-ready.
