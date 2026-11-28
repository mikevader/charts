# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A Helm chart repository (published at `https://mikevader.github.io/charts/`, repo alias `mikevader`) for self-hosted apps. It descends from the k8s-at-home charts. It has two kinds of chart:

- `charts/library/common`: a Helm **library** chart that renders all Kubernetes resources: controllers (deployment/daemonset/statefulset), services, ingress, PVCs, configmaps, secrets, service accounts, HPA, and add-ons (code-server, vpn/gluetun, promtail, netshoot). Its `values.yaml` defines the full values schema the app charts inherit.
- `charts/stable/<app>`: thin **application** charts. Each depends on `common` from the published repo (pinned version, not a local `file://` path). Most of the chart is its `values.yaml`.
- `charts/archived/<app>`: unmaintained charts, moved here with `git mv`. Renovate, ct lint/install, pre-commit, the changelog check, README generation and chart-releaser all skip this folder. The charts are only listed in `charts/README.md`. See `charts/archived/README.md`.

## App chart pattern

An app chart's `templates/common.yaml` usually follows this shape:

```yaml
{{- include "common.values.setup" . }}          # merge chart values with common defaults
{{- define "<app>.harcodedValues" -}} ... {{- end -}}   # optional: computed values (e.g. extra containers, volumes)
{{- $_ := mergeOverwrite .Values (include "<app>.harcodedValues" . | fromYaml) -}}
{{ include "common.all" . }}                     # render everything
```

Chart-specific extras such as ServiceMonitor, PrometheusRule and CronJobs go in separate template files next to it. Values are keyed by named objects (for example `service.main`, `ingress.main`, `persistence.config`), following the common library's conventions. To see which keys exist, read `charts/library/common/values.yaml`.

## Required conventions when changing a chart

- **Bump `version` in `Chart.yaml`** for every change to a chart.
- **Update `annotations.artifacthub.io/changes`** in `Chart.yaml` (entries are `kind: added|changed|fixed|removed` with a `description`). CI (`.github/scripts/check-releasenotes.sh`) fails a non-Renovate PR if this annotation is missing or unchanged from `origin/master`. For Renovate PRs, `.github/scripts/renovate-releasenotes.py` fills it in automatically.
- `appVersion` sits under a `# renovate: image=<repo>` comment that Renovate uses to bump it. Keep that comment directly above `appVersion`.
- Document values with helm-docs comments (`# -- description`, `# @default -- ...`). Do not hand-edit `README.md`: CI regenerates it on master via `hack/gen-helm-docs.sh` (helm-docs v1.14.2). Application charts use `hack/templates/README.md.gotmpl` in place, plus a per-chart `README_CONFIG.md.gotmpl` for custom notes (seeded if missing). Library charts use their own `README.md.gotmpl`/`README_CONFIG.md.gotmpl`. Every chart's Changelog section is rendered from the current `artifacthub.io/changes` annotation by `hack/templates/README_CHANGELOG.md.gotmpl`, so don't add a per-chart changelog template. When a push changes `hack/gen-helm-docs.sh` or `hack/templates/`, or on a manual run, the release workflow regenerates every README. Don't commit regenerated READMEs of otherwise unchanged charts in a PR: CI counts any file in a chart directory as a chart change and then requires a version bump and changelog entry. `charts/README.md` is also auto-generated (`hack/gen-chart-summary.sh`).
- Pre-commit hooks (`.pre-commit-config.yaml`): no trailing whitespace, final newline required, LF line endings, **no tabs**.

## Commands

Tools needed: `helm` (CI uses v4), `ct` (chart-testing), the `helm-unittest` plugin, `yq`, and `helm-docs`.

```bash
# Lint changed charts (as CI does)
ct lint --config .github/ct-lint.yaml
# Lint/render a single chart
helm dep update charts/stable/<app> && helm lint charts/stable/<app>
helm template test charts/stable/<app> -f charts/stable/<app>/ci/<file>-values.yaml

# Unit tests for the common library. They live in the helper chart, which uses common via file://
helm dep update helper-charts/common-test
helm unittest -f "tests/**/*_test.yaml" helper-charts/common-test
# Run a single test file
helm unittest -f "tests/service/metadata_test.yaml" helper-charts/common-test
# Update snapshots after an intended change
helm unittest -u -f "tests/**/*_test.yaml" helper-charts/common-test

# Install test into a cluster (CI uses k3d)
ct install --config .github/ct-install.yaml --charts charts/stable/<app>

# Regenerate README for one chart
./hack/gen-helm-docs.sh stable <app>
```

`ct install` runs once for each `ci/*-values.yaml` file in a chart. `foundryvtt`, `heimdall`, `app-of-apps` and `app-of-apps-bootstrap` are excluded from install tests (`.github/ct-install.yaml`); helm-unittest still runs for every changed chart, since its matrix comes from `.github/ct-lint.yaml`. The Ruby/minitest harness (`Gemfile`, `test/test_helper.rb`) is legacy and has no active tests.

## CI flow

The PR workflow is `.github/workflows/pr-validate.yaml`. It calls the other workflows by local path (`./.github/workflows/...`), so a PR runs its own version of them. It runs metadata detection, then pre-commit, then the changelog check (and auto-annotation for Renovate PRs), then lint and test. Tests run helm-unittest followed by `ct install` on k3d. When a changed chart is a library chart, or files under `helper-charts/` change, the unit tests and the install test run against `helper-charts/common-test`. `excluded-charts` in `.github/ct-install.yaml` takes chart directory names, not paths. Pushing to `master` runs `charts-release.yaml`, which regenerates READMEs, commits them (`chore: Auto-update chart README [skip ci]`), and publishes with chart-releaser. GitHub release notes are chart-scoped: `.github/scripts/gen-release-notes.sh` writes `RELEASE-NOTES.md` into each unreleased chart (from its `artifacthub.io/changes` annotation and the PRs that touched its directory since the chart's previous tag), and chart-releaser reads it via `CR_RELEASE_NOTES_FILE`. GitHub's own generated notes are off because they list every PR in the repo between two tags.

## Changing the common library

Bump `charts/library/common/Chart.yaml`, then add or adjust tests under `helper-charts/common-test/tests/`. App charts pull `common` from the published repo, so they only get the change after the new version is released and their `dependencies[].version` is bumped (usually by Renovate).
