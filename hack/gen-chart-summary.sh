#!/usr/bin/env bash
set -e

# require yq
command -v yq >/dev/null 2>&1 || {
    echo >&2 "yq (https://github.com/mikefarah/yq) is not installed. Aborting."
    exit 1
}

# Absolute path of repository
repository=$(git rev-parse --show-toplevel)
charts_folder="${repository}/charts"
charts_summary_file="${charts_folder}"/README.md

# Write a table of all charts in charts/<folder>
# Usage: write_section <folder> <title>
write_section() {
    local folder="$1"
    local title="$2"
    local charts=""
    if [ -d "${charts_folder}/${folder}" ]; then
        charts=$(find "${charts_folder}/${folder}" -name "Chart.yaml" | sort)
    fi

    echo "### ${title}:" >> "${charts_summary_file}"
    echo "| Chart | Description |" >> "${charts_summary_file}"
    echo "| ----- | ----------- |" >> "${charts_summary_file}"
    for i in ${charts}
    do
        chart_data=($(yq eval '.name, .description' "$i"))
        chart_name="${chart_data[0]}"
        chart_description="${chart_data[@]:1}"
        echo "| [${chart_name}](${folder}/${chart_name}) | ${chart_description} |" >> "${charts_summary_file}"
    done
}

echo "# Helm charts overview" > "${charts_summary_file}"

write_section library "Library charts"
write_section stable "Stable charts"
write_section incubator "Incubator charts"
write_section archived "Archived charts"
