# Authoring Guide

Skeleton placeholder.

This file will define the end-to-end workflow for authoring MBB-style HTML PPT decks.

Reference materials must be abstracted into neutral patterns. Do not copy source logos, company names, confidentiality language, client names, or identifying marks into generated HTML.

## Content Sufficiency Gate

Before selecting a specialized page, inspect the user's input:

1. Identify the data type: contacts, metrics, time series, categorical values, prose themes, decisions, roadmap steps, or mixed records.
2. Check whether required fields exist.
3. If fields are missing, choose a simpler layout or omit the page.
4. Never invent names, numbers, roles, dates, sources, or group labels.

Examples:

- Contacts: use a contact roster only with enough contact records.
- Numeric categories: use a bar chart only with labels and values.
- Exact multi-field data: use a table.
- Sparse prose: use statement, cards, or callout.
- Ordered phases: use timeline or roadmap.

## Asset Path Rule

When copying snippets into a real deck, normalize asset paths to the deck location:

- `templates/*.html`: usually `../assets/...`
- `examples/<name>/index.html`: usually `../../assets/...`
- generated deck folders from `scripts/new-deck.sh`: usually `assets/...`
