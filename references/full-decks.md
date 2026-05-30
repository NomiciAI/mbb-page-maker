# Full-Deck Patterns

Full decks should have one coherent storyline. Choose a deck pattern based on the audience's decision and the available evidence, then compose pages from `templates/layouts/` and content blocks from `templates/components/`.

Do not treat these as fixed templates. Add, remove, or combine pages based on the user's material.

## First-Class Exemplars

Use these complete decks as first-class authoring references before creating a new full deck:

| exemplar | best when | inspect for |
| --- | --- | --- |
| `templates/full-decks/ai-application-investment-thesis/index.html` | investment, pitch, thesis, market map, funding, product bet, or diligence-style decks | evidence extraction, thesis flow, market/peer pages, risk framing, pitch-style density |
| `templates/full-decks/enterprise-intelligence-transformation/index.html` | transformation, operating model, AI strategy, capability build, roadmap, governance, or board update decks | executive answer, flywheel/story model, capability heatmap, roadmap, governance, decision pages |

`examples/*` are public demo outputs. `templates/full-decks/*` are the authoring exemplars an agent should inspect when deciding how to structure a real deck. Keep the exemplar content fictional or generic; never copy it verbatim into user work. Do not copy exemplar footer text, placeholder brand marks, or deck-system labels into user decks.

Editable source rule: change `templates/full-decks/<name>/index.html` first, then run `scripts/sync-examples.sh` to refresh public demos. Use `scripts/sync-examples.sh --check` before delivery to catch drift.

## Exemplar Selection Matrix

| user task | default route |
| --- | --- |
| Investment, thesis, diligence, product bet, pitch | Inspect `ai-application-investment-thesis`, then adapt the Investment Or Diligence Memo sequence. |
| Board or executive update | Inspect `enterprise-intelligence-transformation`, then adapt the Board Or Executive Update sequence. |
| Transformation, operating model, AI strategy, governance | Inspect `enterprise-intelligence-transformation`, then adapt the Operating Model Or Transformation sequence. |
| Market, competitive, customer, or trend scan | Inspect `ai-application-investment-thesis` for market evidence density, then adapt the Market Or Competitive Scan sequence. |
| Workshop or working session pack | Use the Workshop Pack sequence and component catalog; no current full-deck exemplar is a direct fit. |
| Strategy recommendation or market entry | Use the Strategy Recommendation sequence and inspect the closest exemplar based on evidence type. |

## One-Shot Full-Deck Workflow

When the user gives limited context, do not ask them to design the deck page by page. Extract structure from the source material:

1. Identify the audience and likely decision: investor, board, executive, workshop, operating team, or diligence reader.
2. Build an evidence inventory: numeric values, percentages, rankings, comparisons, time periods, risks, customer/market claims, and named uncertainties.
3. Separate user-provided evidence from assumptions and any approved external data.
4. Group the evidence into 2-5 mutually distinct sections.
5. Pick the closest deck archetype below and inspect the closest `templates/full-decks/*` exemplar for pacing and page density.
6. Draft an answer-first storyline: answer, why now, proof, implications, risks, and next decisions.
7. Map every body slide to one layout, at least one component, and one fallback if evidence is insufficient. If a slide has data but no component, revise the plan before writing HTML.
8. Build, audit, package, and export.

Evidence-to-page routing:

- Numeric comparisons: table plus ranked bars, column chart, range plot, or metric strip.
- Peer or industry sets: comparison table, ranked bars, heatmap, quadrant, or scatter.
- Segments or business lines: table, stacked bars, donut/pie only when part-to-whole is clean.
- Risks and uncertainty: risk matrix register, pros-cons table, decision log, or callout paired with evidence.
- Timeline or execution: phase roadmap, milestone track, process flow, or stage gate.
- Qualitative thesis: outcome-support, framework-map, cause-effect, or numbered-list-grid.

Short full decks should rarely use pure section dividers. If the source has evidence for a section, open with an evidence-bearing page instead of a blank divider.

No-data fallback:

- If there are no numbers, do not create charts, metrics, rankings, ranges, or heatmaps.
- If there are no comparable records, do not create tables or matrices.
- If there are no dates or ordered phases, do not create timelines or roadmaps.
- Use qualitative layouts for sparse inputs, and label open questions as assumptions, risks, or decisions to validate.
- Do not browse for external data unless the user explicitly requests it or grants permission after being asked.

## Deck-Level Rules

- Start with the audience question and the answer.
- Build a storyline with 2-5 supporting pillars.
- Use content slide titles as answer-first messages.
- Put detailed backup, raw tables, or optional references in appendix pages.
- Avoid filler pages. Every page must either advance the argument, support a decision, or provide necessary reference.
- Apply one theme after the storyline and structure are stable.

## Full-Deck Showcase Validation

Use `templates/showcase/full-deck-operating-case-mono.html` and `templates/showcase/full-deck-operating-case-blue.html` to test whether independent components compose into a coherent 16:9 deck.

- The two showcase files must keep identical content and slide order; only the theme file changes.
- The case content is fictional and exists only to validate fit, visual balance, theme switching, and storyline continuity.
- Visible page headers should use neutral business language such as executive view, evidence, capabilities, target model, working rhythm, roadmap, decisions, team, and next steps.
- Do not expose internal component-family labels as page headers in user-facing full decks.
- Do not copy logos, company names, confidentiality marks, source notes, or footer text from reference materials.

The showcase sequence should cover at least one useful example from each major content job:

- Structure: framework, outcome-support, from-to, or decision model.
- Data: KPI strip, column/bar chart, heatmap, range, or table.
- Process: process flow, stage gate, filter, funnel, loop, or value chain.
- Time: roadmap, timeline, milestone, horizon, or journey.
- Text: quote, dense list, decision log, pros/cons, or numbered grid.
- People: contact/team page only when records are available or the page is explicitly marked showcase-only.

## Strategy Recommendation

Use when the user asks for a recommended direction, growth path, market entry, turnaround, or strategic choice.

Typical sequence:

1. Title page.
2. Executive summary with the answer and 2-4 reasons.
3. Situation/context: why the decision matters now.
4. Opportunity or problem diagnosis.
5. Option comparison or prioritization.
6. Recommendation and rationale.
7. Risks, mitigations, and open questions.
8. Roadmap or next steps.
9. Appendix or supporting analyses.

Useful components: `comparison-table`, `matrix-prioritization`, `metric-strip`, `chart-bars`, `ranked-bars`, `roadmap-swimlane`, `callout`.

## Board Or Executive Update

Use when the audience needs a concise status read and decisions.

Typical sequence:

1. Title page.
2. Executive summary: what changed, what matters, what decisions are needed.
3. KPI snapshot.
4. Progress against priorities.
5. Key risks or blockers.
6. Decision pages.
7. Forward plan.
8. Appendix.

Useful components: `metric-strip`, `data-dashboard`, `table`, `heatmap`, `roadmap-swimlane`, `callout`.

## Market Or Competitive Scan

Use when the user provides market facts, competitor information, customer segments, or trend evidence.

Typical sequence:

1. Title page.
2. Executive summary.
3. Market size/growth or demand signal.
4. Segment or customer analysis.
5. Competitor or alternative comparison.
6. Implications for strategy.
7. Priority opportunities.
8. Next analyses or decisions.

Useful components: `chart-bars`, `ranked-bars`, `scatter-plot`, `comparison-table`, `matrix-prioritization`, `table`.

## Operating Model Or Transformation

Use when the deck explains organizational changes, processes, capabilities, workstreams, or implementation.

Typical sequence:

1. Title page.
2. Case for change.
3. Current-state diagnosis.
4. Target-state principles or operating model.
5. Capability or maturity assessment.
6. Workstream roadmap.
7. Governance, roles, and decision cadence.
8. Risks and dependencies.
9. Next steps.

Useful components: `heatmap`, `roadmap-swimlane`, `process/flow layouts`, `comparison-table`, `profile`, `table`.

## Workshop Pack

Use when the deck supports a meeting, workshop, or working session.

Typical sequence:

1. Title page.
2. Meeting objectives.
3. Workshop agenda.
4. Pre-read context.
5. Discussion pages or exercises.
6. Decision capture.
7. Next steps and owners.
8. Appendix.

Useful components: `objective-list`, `objective-summary`, `agenda-table`, `simple-agenda-grid`, `table`, `callout`.

## Investment Or Diligence Memo

Use when the deck evaluates an investment, acquisition, product bet, or major resource allocation.

Typical sequence:

1. Title page.
2. Investment thesis or answer.
3. Market attractiveness.
4. Company/product position.
5. Financial or operating evidence.
6. Key risks.
7. Valuation, scenarios, or sensitivity if provided.
8. Recommendation and next steps.
9. Appendix.

Useful components: `metric-strip`, `chart-bars`, `waterfall-bridge`, `comparison-table`, `table`, `callout`.
