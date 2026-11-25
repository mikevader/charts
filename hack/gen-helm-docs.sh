#!/usr/bin/env bash
set -eu

# Generate helm-docs for Helm charts
# Usage ./gen-helm-docs.sh [stable|library] [chart]
#
# Application charts (charts/stable/*) are rendered with the shared templates in
# hack/templates. Only README_CONFIG.md.gotmpl lives in the chart directory: it is
# seeded from hack/templates if missing and can then be customised per chart.
# Library charts (charts/library/*) use the README/CONFIG templates in their own
# chart directory. Every chart shares the changelog template, which renders the
# current version's artifacthub.io/changes annotation from Chart.yaml.

# require helm-docs
command -v helm-docs >/dev/null 2>&1 || {
    echo >&2 "helm-docs (https://github.com/norwoodj/helm-docs) is not installed. Aborting."
    exit 1
}

# Absolute path of repository
repository=$(git rev-parse --show-toplevel)

# Shared templates for application charts
readme_template="${repository}/hack/templates/README.md.gotmpl"
readme_config_template="${repository}/hack/templates/README_CONFIG.md.gotmpl"
readme_changelog_template="${repository}/hack/templates/README_CHANGELOG.md.gotmpl"

# Allow for a specific chart to be passed in as a argument
if [ $# -ge 2 ] && [ -n "$1" ] && [ -n "$2" ]; then
    chart_dirs="${repository}/charts/$1/$2"
    if [ ! -f "${chart_dirs}/Chart.yaml" ]; then
        echo "File ${chart_dirs}/Chart.yaml does not exist."
        exit 1
    fi
else
    chart_dirs=$(find "${repository}/charts/stable" "${repository}/charts/library" -mindepth 2 -maxdepth 2 -name Chart.yaml -exec dirname {} \; | sort)
fi

for chart_directory in ${chart_dirs}; do
    case "${chart_directory}" in
        "${repository}/charts/library/"*)
            echo "-] Generating README for library chart ${chart_directory}"
            helm-docs \
                --template-files=README.md.gotmpl \
                --template-files=README_CONFIG.md.gotmpl \
                --template-files="${readme_changelog_template}" \
                --chart-search-root="${chart_directory}"
            ;;
        *)
            echo "-] Generating README for application chart ${chart_directory}"
            # Seed the CONFIG template, do not overwrite if it exists
            cp -n "${readme_config_template}" "${chart_directory}" || true
            helm-docs \
                --template-files="${readme_template}" \
                --template-files=README_CONFIG.md.gotmpl \
                --template-files="${readme_changelog_template}" \
                --chart-search-root="${chart_directory}"
            ;;
    esac
done
