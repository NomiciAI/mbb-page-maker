# Showcase Pattern Catalog

Showcase files are agent-facing combination references. They are not full-deck exemplars and should not be copied as fixed templates. Use them to learn how theme, layout shell, and components compose inside a safe 16:9 slide.

## Existing Pattern Showcases

| Pattern | Use when | Component families | Layout shell | Theme coverage | Path |
| --- | --- | --- | --- | --- | --- |
| Structure patterns | A page needs conceptual structure, decision framing, operating model logic, or qualitative proof. | `pyramid-stack`, `cause-effect`, `outcome-support`, `diverging-textboxes`, `from-to-multi`, `compass-choice`, `framework-map` | `blank-content` | `mono.css` | `templates/showcase/structure-patterns.html` |
| Process patterns | A page needs ordered work, decision gates, narrowing logic, loops, or value handoffs. | `process-flow`, `stage-gate`, `funnel-steps`, `filter-cascade`, `loop-cycle`, `value-chain` | `blank-content` | `mono.css` | `templates/showcase/process-patterns.html` |
| Time patterns | A page needs chronology, horizons, journeys, phases, or milestone status. | `timeline-track`, `horizon-bands`, `journey-map`, `phase-roadmap`, `milestone-track` | `blank-content` | `mono.css` | `templates/showcase/time-patterns.html` |
| Text patterns | A page needs stakeholder voice, compact records, decision tracking, or option tradeoffs. | `quote-large`, `quote-small`, `quote-insight`, `numbered-list-grid`, `dense-list`, `decision-log`, `pros-cons-table` | `blank-content`, sidebar variants | `mono.css` | `templates/showcase/text-patterns.html` |
| Contact roster with headshots | The user supplies real people/contact records and the deck needs a team or contact page. | `contact-card`, `profile`, headshot media | `contact-roster` | `mono.css` | `templates/showcase/contact-roster-headshots.html` |
| Full-deck operating case | Components must be tested as a coherent operating-story deck across themes. | Structure, data, process, time, text, people | Mixed full-deck shells | `mono.css`, `blue.css` | `templates/showcase/full-deck-operating-case-mono.html`, `templates/showcase/full-deck-operating-case-blue.html` |

## Combination Page Showcases

| Pattern | Use when | Minimum data | Recommended layout | Components | Fallback | Do not use when | Path |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Executive answer data page | The deck needs one answer, 3-5 headline signals, and a compact implication rail. | One governing answer plus 3-5 metrics/signals and 2-4 support points. | `blank-right-rail` | `metric-strip`, `outcome-support`, `callout` | If there are no metrics, use `outcome-support` plus qualitative support cards. | Do not use for dense dashboards or detailed tables. | `templates/showcase/executive-answer-data-page.html` |
| Evidence table implication page | Options or segments need row-level comparison plus an executive takeaway. | At least 3 comparable rows and 3 shared criteria. | `blank-right-sidebar` | `comparison-table`, `callout`, `dense-list` | If rows are not comparable, use cards or `diverging-textboxes`. | Do not use for long tables that need the full page. | `templates/showcase/evidence-table-implication-page.html` |
| Roadmap risk decision page | A phased plan needs risks, decision asks, or governance notes beside it. | 3-5 phases plus at least two risks, decisions, or control points. | `blank-right-sidebar` | `phase-roadmap`, `dense-list`, `callout` | If timing is missing, use `process-flow` or `numbered-list-grid`. | Do not use when the plan requires swimlanes or dense owner tracking. | `templates/showcase/roadmap-risk-decision-page.html` |

## Authoring Rules

- Inspect the closest showcase before inventing a new page combination.
- Use existing layouts and components first. Add a component only for a repeated content job that cannot fit the catalog.
- Keep showcase content fictional, generic, and source-neutral.
- Do not copy showcase footer labels, placeholder text, or internal component names into user-facing decks.
