# Archived charts

Charts in this folder are no longer maintained. To archive a chart, move it here with
`git mv charts/stable/<app> charts/archived/<app>`.

- Renovate ignores them (`.github/renovate.json5`).
- CI skips them: `ct` lint/install only cover `charts/library` and `charts/stable`, and the
  collect-changes action excludes `charts/archived/**`, so pre-commit, the changelog check
  and README generation do not run for them.
- They are not released again. Versions published earlier stay installable from the Helm
  repository index.
- They still appear in the [charts overview](../README.md) under "Archived charts".

To revive a chart, move it back to `charts/stable` and bump its version.
