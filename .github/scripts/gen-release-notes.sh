#!/usr/bin/env bash
set -euo pipefail

# Generate GitHub release notes for a single chart, listing only changes made inside that chart's directory.
# GitHub's built-in generator lists every PR merged between two tags, which in this multi-chart
# repository includes changes to unrelated charts.
#
# Usage: ./gen-release-notes.sh <chart-dir> [output-file]
# Default output is <chart-dir>/RELEASE-NOTES.md, which chart-releaser picks up via CR_RELEASE_NOTES_FILE.

command -v yq >/dev/null 2>&1 || {
    printf >&2 "%s\n" "yq (https://github.com/mikefarah/yq) is not installed. Aborting."
    exit 1
}

if [ $# -lt 1 ] || [ ! -f "${1%/}/Chart.yaml" ]; then
    printf >&2 "%s\n" "Usage: $0 <chart-dir> [output-file]"
    exit 1
fi

chart_dir="${1%/}"
output="${2:-${chart_dir}/RELEASE-NOTES.md}"
repo_url="${GITHUB_SERVER_URL:-https://github.com}/${GITHUB_REPOSITORY:-mikevader/charts}"

name=$(yq '.name' "${chart_dir}/Chart.yaml")
version=$(yq '.version' "${chart_dir}/Chart.yaml")
description=$(yq '.description // ""' "${chart_dir}/Chart.yaml")
if [ -z "${name}" ] || [ "${name}" = "null" ] || [ -z "${version}" ] || [ "${version}" = "null" ]; then
    printf >&2 "%s\n" "Skipping ${chart_dir}: Chart.yaml has no name or version."
    exit 0
fi
tag="${name}-${version}"

# Previous release of this chart: the "<name>-<semver>" tag sorting directly below the current one.
# The strict pattern keeps e.g. "jellyfin-tmp-1.0.0" from counting as a "jellyfin" release.
previous_tag=$(
    { git tag --merged HEAD --list "${name}-*" | grep -E "^${name}-[0-9]+\.[0-9]+\.[0-9]+([-+][0-9A-Za-z.+-]*)?$" || true; echo "${tag}"; } \
        | sort -u -V | grep -B1 -xF "${tag}" | head -n1
)
[ "${previous_tag}" = "${tag}" ] && previous_tag=""

# Curated changelog maintained in Chart.yaml (enforced by check-releasenotes.sh)
changes=$(
    yq '.annotations["artifacthub.io/changes"] // ""' "${chart_dir}/Chart.yaml" \
        | yq '.[] | "- **" + .kind + "**: " + .description' - 2>/dev/null || true
)

# PRs and direct commits on the main line that touched this chart
entries=()
while read -r sha; do
    [ -n "${sha}" ] || continue
    subject=$(git log -1 --format=%s "${sha}")
    case "${subject}" in
        *"[skip ci]"* | *"[no ci]"* | "chore: Auto-update chart"*) continue ;;
    esac

    if [[ "${subject}" =~ ^Merge\ pull\ request\ \#([0-9]+)\ from ]]; then
        pr="${BASH_REMATCH[1]}"
        title=$(git log -1 --format=%b "${sha}" | sed '/^[[:space:]]*$/d' | head -n1)
        entries+=("* ${title:-${subject}} in ${repo_url}/pull/${pr}")
    elif [[ "${subject}" =~ ^(.*)\ \(\#([0-9]+)\)$ ]]; then
        entries+=("* ${BASH_REMATCH[1]} in ${repo_url}/pull/${BASH_REMATCH[2]}")
    else
        entries+=("* ${subject} (${repo_url}/commit/${sha})")
    fi
done < <(git log --first-parent --format=%H "${previous_tag:+${previous_tag}..}HEAD" -- "${chart_dir}")

{
    if [ -n "${description}" ]; then
        printf '%s\n\n' "${description}"
    fi

    if [ -n "${changes}" ]; then
        printf '## Changes\n\n%s\n\n' "${changes}"
    fi

    printf "## What's Changed\n\n"
    if [ ${#entries[@]} -gt 0 ]; then
        printf '%s\n' "${entries[@]}"
    elif [ -z "${previous_tag}" ]; then
        printf '%s\n' "* Initial release"
    else
        printf '%s\n' "* No pull requests touched this chart since ${previous_tag}"
    fi
    printf '\n'

    if [ -n "${previous_tag}" ]; then
        printf '**Previous release**: %s/releases/tag/%s\n\n' "${repo_url}" "${previous_tag}"
    fi
    printf '**Chart history**: %s/commits/%s/%s\n' "${repo_url}" "${tag}" "${chart_dir}"
} > "${output}"

echo "Generated release notes for ${tag} (previous: ${previous_tag:-none}) at ${output}"
