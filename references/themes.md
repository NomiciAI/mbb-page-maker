# Theme Guide

Themes are token files. They should not contain layout rules or component CSS.

## Available Themes

- `assets/themes/blue.css`: default consulting blue.
- `assets/themes/red.css`: red accent system.
- `assets/themes/green.css`: green accent system.
- `assets/themes/mono.css`: black-and-white system.
- `assets/themes/classic.css`: compatibility alias for the default blue token set.

## Light And Dark Modes

Each theme defines both light and dark tokens:

- Light mode: default `.slide`.
- Dark mode: `.slide.dark` or `.slide[data-mode="dark"]`.
- Dark cover: `.slide.dark-cover` or `.slide[data-variant="dark-cover"]`.

Use one theme file per deck. Do not mix theme files in one production deck unless the user explicitly wants a theme comparison.

## Token Rules

- Put colors only in `assets/themes/*.css`.
- Put layout structure in `assets/css/layouts.css`.
- Put reusable content components in `assets/css/components.css`.
- Put neutral illustration styling and asset slots in `assets/css/illustrations.css`.
- Put optional static images, SVGs, screenshots, and headshots in `assets/media/`.
