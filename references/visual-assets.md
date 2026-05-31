# Visual Asset Guidance

Use visual assets to clarify a page message, improve visual balance, or create a purposeful cover/section moment. Do not use them to decorate weak content or hide missing evidence.

## Default Policy

- Prefer repo-native CSS/SVG primitives for interior pages.
- Use generated bitmap assets mainly for cover, hero, and high-emphasis section pages.
- Do not bundle third-party original images unless the user explicitly approves a reviewed CC0/public-domain asset.
- Network images may be used only as reference, seed, or mood input. Final bundled assets must be strongly transformed, self-generated, and free of recognizable brands, people, trademarks, product UI, buildings, logos, source marks, and consulting-firm cues.
- Do not copy composition, color system, labels, logos, footers, confidentiality text, or proprietary visual treatment from reference decks.

## Visual Roles

| Role | Use when | Preferred asset type | Do not use when |
| --- | --- | --- | --- |
| Cover / hero | Opening or section page needs an executive visual signal and text-safe negative space. | Generated bitmap or `.cover-art` image. | The visual would make title text hard to read or add generic decoration. |
| Section divider | A longer deck needs pacing between chapters. | CSS line fields, abstract cover art, or a sparse visual primitive. | Short evidence-driven decks; use a data-bearing section intro instead. |
| Concept support | A qualitative page has one governing concept that benefits from a visual metaphor. | CSS/SVG primitive. | The concept can be expressed better with `framework-map`, `outcome-support`, or a table. |
| Architecture / system | The page explains layers, platforms, integration, or control planes. | `visual-architecture-stack` or `visual-operating-system`. | Exact technical architecture is required; use a real architecture diagram instead. |
| Market / portfolio | The page frames opportunity spaces, growth lanes, or option terrain. | `visual-market-map` or portfolio/data components. | The source has scored options; use `portfolio-prioritization-matrix` or `weighted-scorecard`. |
| Value bridge | The page explains movement from baseline to upside or decision value. | `visual-value-bridge` or data bridge/table. | Exact financial values are available; use a chart or sensitivity grid. |
| Risk / control | The page frames safeguards, boundaries, or escalation logic. | `visual-risk-control`. | Risk names, owners, and mitigations are explicit; use `risk-matrix-register` or `status-table`. |
| Journey / adoption | The page explains user, customer, or operating progression. | `visual-customer-journey`, `journey-arc`, or `journey-wave`. | Dates or workstreams matter more; use time components. |
| Team / network | The page explains collaboration, ownership, or enablement. | `visual-team-network` or people components. | Named people/contact records are present; use `contact-card` or roster layouts. |
| Data flywheel | The page explains learning loops, telemetry, or compounding knowledge assets. | `visual-data-flywheel` or `cycle-flow`. | The page needs real metric proof; use data components. |

## Authoring Rules

- Data-rich pages should use charts, tables, matrices, scorecards, metrics, or risk/status components before visual primitives.
- A visual page still needs an answer-first title. The visual supports the claim; it is not the claim.
- Keep visuals inside safe slots: `.content`, `.region-body`, `.safe-fill`, `.safe-stack`, `.cover-art`, or `.cover-visual-slot`.
- Use `.content.is-vertically-centered` when a single visual primitive is compact and would otherwise sit at the top.
- Dark pages must use dark slide tokens and pass `scripts/check-deck-contrast.sh`.
- If the visual requires real-world specificity, use user-supplied media or approved external research. Do not invent company/product screenshots.

## Bitmap Asset Rules

- Bundled generated bitmap assets live under `assets/media/covers/` or `assets/media/illustrations/`.
- Each bitmap must be listed in a manifest with file name, role, use case, generation mode, inspiration URLs, license notes, generated date, and prompt summary.
- New cover/hero assets should generally stay below 350KB each unless the user explicitly prioritizes image fidelity.
- Avoid visible text inside generated images. Deck text belongs in HTML for accessibility, contrast checks, and editing.

## Web Inspiration Gate

Before using a network asset as inspiration, record:

- asset URL
- license page URL
- access date
- whether the original file enters the repo
- transformation approach
- risk notes for people, brands, trademarks, product UI, buildings, or source marks

Default answer for "original file enters the repo" is `no`.
