# Layout Catalog

Use simple layouts when the message is the point. Use complex layouts only when the audience must understand multiple moving parts on one page.

## Simple Layouts

- Cover: title, subtitle, date/meta, optional client mark.
- Dark cover: section-opening or high-emphasis narrative page.
- Statement: one conclusion, one support line, no exhibit.
- Quote: stakeholder voice or customer evidence.
- Media split: short message plus neutral illustration.

## Medium Layouts

- Agenda: 3-9 numbered sections.
- Content primitives: cards, callouts, and evidence blocks.
- KPI strip: 3-5 executive metrics with short labels.
- Table plus roadmap: dense content with structured hierarchy.
- 2x2 matrix: prioritization or segmentation.

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

- `templates/light-skeleton.html`
- `templates/dark-skeleton.html`
- `templates/mixed-skeleton.html`

Layout and component CSS are separated:

- Layout shells: `assets/css/layouts.css`
- Components used inside layouts: `assets/css/components.css`
- Illustration primitives and asset slots: `assets/css/illustrations.css`
