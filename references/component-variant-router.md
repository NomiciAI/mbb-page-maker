# Component Variant Router

Use this router after choosing the audience question and page layout. The goal is to select the evidence shape first, then the component family, then the variant. Snippets are not fixed templates: headings, group labels, legends, axis labels, periods, owners, and section titles must come from the user's material.

## Routing Sequence

1. Identify the story job: prove, compare, diagnose, choose, sequence, govern, or introduce people.
2. Identify the evidence shape: numeric series, categorical comparison, ranked records, matrix, process, time, conceptual logic, or named people.
3. Select the component family that preserves the evidence without inventing fields.
4. Select the lightest variant that can carry the story.
5. Pick the layout: `blank-content` for one dominant exhibit, sidebar layouts for one implication rail, `dense-content` or `.slide.is-dense` for charts/tables/matrices that need body-band closure and bottom-axis clearance.
6. Use fallback components when the minimum data is missing.

## Variant Matrix

| family | variant | use when | do not use when | minimum data | fallback | recommended layout | density guidance |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Charts and data | `line-chart` | Trend or index movement over time is the message. | Values are unordered categories or exact values must be audited. | 3+ ordered periods and one numeric series. | `chart-bars` or `wide-data-table`. | `blank-content`, `blank-right-rail`. | Use dense mode when axis labels sit near the footer. |
| Charts and data | `combo-chart` | Volume and rate/index must be explained together. | The two measures do not share the same story. | 3+ periods, one bar series, one line series. | Two separate charts or a table. | `blank-content`, `blank-right-sidebar`. | Keep labels short; avoid more than 5 periods on one page. |
| Charts and data | `paired-bars` | Two comparable values per category, such as current vs. target. | More than two series or long category names. | 2+ categories with two numeric values each. | `dot-scale-comparison` or `comparison-table`. | `blank-content`. | Good for compact pages; avoid unnecessary dense mode. |
| Charts and data | `likert-bars` | Survey, sentiment, or maturity distribution uses shared ordered buckets. | Values are not ordered or totals are unclear. | 2+ rows and 3-5 ordered response buckets. | `diverging-heatmap` or `wide-data-table`. | `blank-content`. | Keep bucket labels in legend; do not repeat them in every row. |
| Charts and data | `waterfall-bridge` | Show movement from baseline to target across additive steps. | Contributions do not add to a meaningful bridge. | Start, 2+ drivers, end. | `chart-bars` or `driver-recap-columns`. | `blank-content`, `blank-right-rail`. | Use dense mode only when labels are close to footer. |
| Charts and data | `checkmark-bar-table` | Options need pass/fail gates plus one score or value bar. | Criteria are nuanced and need prose evidence. | 2+ options, 2+ binary criteria, one score/value. | `comparison-table` or `weighted-scorecard`. | `blank-content`, `blank-right-sidebar`. | Keep check columns narrow and source the legend from input. |
| Tables and analysis | `ranked-evidence-table` | Ranking and supporting evidence both need visibility. | Items are not sortable or ranked. | 3+ ranked rows plus evidence and implication fields. | `ranked-bars` plus `dense-list`. | `dense-content`. | Remove the last row border only when the footer line closes the page. |
| Tables and analysis | `driver-recap-columns` | Summarize drivers from a larger analysis without full table precision. | Exact field audit matters. | 3-5 drivers with short support text. | `numbered-list-grid` or `wide-data-table`. | `blank-content`, sidebar rail. | Use invisible column boxes via spacing, not visible nested cards. |
| Tables and analysis | `matrix-table` | Many options share the same categorical fields. | Two-axis positioning is enough. | 3+ rows and 3+ shared columns. | `comparison-table` or `portfolio-prioritization-matrix`. | `dense-content`. | Use dense mode when 4+ rows need a stable body band. |
| Conceptuals | `issue-tree` | Break a question into mutually exclusive branches and leaves. | The logic is sequential or time-based. | One root, 2-4 branches, 2+ leaves per branch. | `framework-map` or `numbered-list-grid`. | `blank-content`. | Keep leaf labels short; split if branches need paragraphs. |
| Conceptuals | `iceberg-model` | Separate visible symptoms from hidden drivers. | No hidden/visible distinction exists. | 2+ visible signals and 2+ underlying drivers. | `cause-effect` or `pyramid-stack`. | `blank-content`, `blank-right-sidebar`. | Avoid decorative use; the split must explain diagnosis. |
| Conceptuals | `capability-coverage-map` | Show coverage, gaps, and partial readiness across capabilities. | Exact score matrix is required. | 4+ capabilities and coverage state for each. | `heatmap` or `matrix-table`. | `blank-content`. | Prefer compact labels; use a legend when states are symbolic. |
| Flows | `chevron-process-ribbon` | Linear process stages should read as one connected ribbon. | Handoffs across roles matter. | 3-6 ordered stages. | `process-flow` or `stage-gate`. | `blank-content`. | Use short stage names; add a sidebar for implications. |
| Flows | `swimlane-process-map` | Work crosses roles, teams, or systems. | Only one actor exists. | 2+ lanes and 3+ stages. | `process-flow` or `raci-governance-grid`. | `dense-content`. | Use dense mode for lane maps so row spacing stays governed. |
| Flows | `customer-journey-loop` | Journey repeats and learning changes the next cycle. | The process ends once. | 4+ loop moments and one learning implication. | `journey-map`, `loop-cycle`, or `cycle-flow`. | `blank-right-sidebar`. | Keep the loop visual light; use the rail for proof or actions. |
| Flows | `input-process-output-layers` | Architecture or operating model transforms inputs into governed outputs. | The story is a simple stage process. | Input layer, process/control layer, output layer. | `framework-map` or `visual-architecture-stack` plus callout. | `blank-content`, `blank-right-sidebar`. | Use as a conceptual architecture page, not a data chart. |
| Time and workplans | `gantt-workplan.is-dense` | Workstreams are mapped across periods and need tight vertical governance. | Dates are missing or phases matter more than workstreams. | 3+ workstreams and 3+ periods. | `phase-roadmap` or `milestone-track`. | `dense-content`. | Use dense mode by default for swimlane Gantt pages. |
| Time and workplans | `phase-meeting-plan` | A workshop or decision cadence has phases and meeting outputs. | Times and sessions are detailed. | 3-5 phases with actions or outputs. | `agenda-table` or `schedule-list`. | `blank-content`. | Keep each phase to 2-4 bullets. |
| People | `team-wall` | Show many people as a compact team/expert wall. | Roles, biographies, or grouping are important. | 5+ named people and one role/title field. | `contact-network` or `bio-card-grid`. | `blank-content`. | Use only supplied names/photos; placeholders belong to showcase pages. |
| People | `bio-card-grid` | 2-6 people need role, credential, or responsibility context. | The page only needs names and titles. | Names plus 2+ supporting fields. | `contact-roster` or `team-wall`. | `blank-content`, `blank-right-sidebar`. | Long bios should move to appendix or split pages. |
| People | `contact-roster` | Primary contacts plus contributors/advisors/support contacts need hierarchy. | Groups are peers by geography/function. | 3+ contacts and group labels. | `team-wall` or `contact-card`. | `contact-roster` layout. | Replace section titles and legend from user input. |
| People | `contact-network` | Expert network is grouped by region, function, practice, or capability. | There is one primary owner group plus support. | 5+ contacts across 2+ groups. | `team-wall` or `bio-card-grid`. | `contact-network` layout. | Use supplied group labels; do not force Principal contacts. |

## Full-Deck Versus Page-Level Choice

Use a full-deck archetype when the user needs a storyline across multiple page roles: answer, context, proof, tradeoff, risk, roadmap, and decision close. Use a showcase or component directly when the user needs one page or one exhibit.

- Board choice or approval: use `board-decision-recommendation` for the deck, or `board-recommendation-page.html` for one page.
- Technical architecture choice: use `technical-architecture-decision` for the deck, or `technical-architecture-decision-page.html` for one page.
- Analytics explanation: use `advanced-analytics-readout` for the deck, or `analytics-multi-chart-explanation-page.html` for one page.
- Component taxonomy exploration: use the variant showcase pages, not full-deck archetypes.

## Source-Neutral Rule

External decks and PDFs may inform taxonomy only. Do not copy page titles, proprietary text, brand colors, fonts, logos, headshots, page numbers, or exact visual layouts. Rebuild the component from the user's evidence and this repo's neutral theme tokens.
