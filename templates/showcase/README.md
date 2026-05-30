# Showcase Thinking Pattern Catalog

Showcase files are agent-facing page thinking patterns. They are not full-deck archetypes and should not be copied as fixed templates. Use them to learn how a communication job, evidence shape, layout shell, theme, and components compose inside a safe 16:9 slide.

## Existing Pattern Showcases

| Pattern | Communication job | Evidence shape | Component families | Layout shell | Valid substitutions | Path |
| --- | --- | --- | --- | --- | --- | --- |
| Structure patterns | Explain a concept, decision frame, operating model, or qualitative proof logic. | Qualitative, decision, cause/effect, support pillars. | `pyramid-stack`, `cause-effect`, `outcome-support`, `diverging-textboxes`, `from-to-multi`, `compass-choice`, `framework-map` | `blank-content` | Swap among structure components based on whether the page argues hierarchy, contrast, causality, or support. | `templates/showcase/structure-patterns.html` |
| Process patterns | Show ordered work, decision gates, narrowing logic, loops, or value handoffs. | Sequence, stage, dependency, process, handoff. | `process-flow`, `stage-gate`, `funnel-steps`, `filter-cascade`, `loop-cycle`, `value-chain` | `blank-content` | Use time patterns if the source is calendar-based; use structure patterns if order is conceptual. | `templates/showcase/process-patterns.html` |
| Time patterns | Show chronology, horizons, journeys, phases, or milestone status. | Dates, phases, horizons, ordered milestones. | `timeline-track`, `horizon-bands`, `journey-map`, `phase-roadmap`, `milestone-track` | `blank-content` | Use process patterns when timing is not known; use roadmap patterns when decisions or risks are attached. | `templates/showcase/time-patterns.html` |
| Text patterns | Capture stakeholder voice, compact records, decisions, or tradeoffs. | Quote, list, decision, option, qualitative records. | `quote-large`, `quote-small`, `quote-insight`, `numbered-list-grid`, `dense-list`, `decision-log`, `pros-cons-table` | `blank-content`, sidebar variants | Replace quotes with callouts when the source is not a real quote; replace decisions with open questions when ownership is missing. | `templates/showcase/text-patterns.html` |
| Contact roster with headshots | Present real people/contact records or team roles. | Named people with role, team, location, email, or headshot. | `contact-card`, `profile`, headshot media | `contact-roster` | Use text/list components if the user has roles but no people records. | `templates/showcase/contact-roster-headshots.html` |
| Full-deck operating case | Check whether independent components compose into a coherent 16:9 operating story across themes. | Mixed structure, data, process, time, text, people. | Structure, data, process, time, text, people | Mixed full-deck shells | Use only for component fit and theme behavior, not as a user-facing storyline. | `templates/showcase/full-deck-operating-case-mono.html`, `templates/showcase/full-deck-operating-case-blue.html` |

## Combination Page Showcases

| Pattern | Communication job | Evidence shape | Minimum data | Recommended layout | Recommended components | Valid substitutions / fallback | Do not use when | Path |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Executive answer data page | Lead with one answer, 3-5 headline signals, and a compact implication rail. | Numeric or categorical signals plus qualitative support. | One governing answer plus 3-5 metrics/signals and 2-4 support points. | `blank-right-rail` | `metric-strip`, `outcome-support`, `callout` | If there are no metrics, use `outcome-support` plus qualitative support cards. If there are too many signals, split into dashboard or table. | Do not use for dense dashboards or detailed tables. | `templates/showcase/executive-answer-data-page.html` |
| Evidence table implication page | Compare options, segments, competitors, or scenarios and pull out the implication. | Comparable rows and shared criteria. | At least 3 comparable rows and 3 shared criteria. | `blank-right-sidebar` | `comparison-table`, `callout`, `dense-list` | If rows are not comparable, use cards or `diverging-textboxes`. If table is too wide, use a full-width table page. | Do not use for long tables that need the full page. | `templates/showcase/evidence-table-implication-page.html` |
| Roadmap risk decision page | Pair a phased plan with risks, decisions, or governance notes. | Time/phases plus risk or decision records. | 3-5 phases plus at least two risks, decisions, or control points. | `blank-right-sidebar` | `phase-roadmap`, `dense-list`, `callout` | If timing is missing, use `process-flow` or `numbered-list-grid`. If owner tracking matters, use a table or swimlane. | Do not use when the plan requires swimlanes or dense owner tracking. | `templates/showcase/roadmap-risk-decision-page.html` |

## Authoring Rules

- Inspect relevant showcases before inventing a new page combination, then adapt them to the user's evidence shape.
- Use existing layouts and components first. Add a component only for a repeated content job that cannot fit the catalog.
- Do not force the closest pattern. If a user's material calls for a better hybrid, recombine layout and component primitives.
- Keep showcase content fictional, generic, and source-neutral.
- Do not copy showcase footer labels, placeholder text, or internal component names into user-facing decks.
