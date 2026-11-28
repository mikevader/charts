{{/* vim: set filetype=mustache: */}}

{{/*
Resolve the onRemoval mode for one application.
Precedence: application `onRemoval` > group/chart `onRemoval` > "confirm".
Usage: include "app-of-apps.onRemoval" (dict "app" $value "root" $)
*/}}
{{- define "app-of-apps.onRemoval" -}}
{{- $mode := default "confirm" .root.Values.onRemoval -}}
{{- if and .app .app.onRemoval -}}
{{- $mode = .app.onRemoval -}}
{{- end -}}
{{- if not (has $mode (list "delete" "confirm" "preserve")) -}}
{{- fail (printf "onRemoval must be one of delete, confirm, preserve (got %q)" $mode) -}}
{{- end -}}
{{- $mode -}}
{{- end -}}

{{/*
Argo CD sync-options value for an onRemoval mode; empty for "delete".
Usage: include "app-of-apps.onRemovalSyncOptions" "confirm"
*/}}
{{- define "app-of-apps.onRemovalSyncOptions" -}}
{{- if eq . "confirm" -}}
Prune=confirm,Delete=confirm
{{- else if eq . "preserve" -}}
Prune=false,Delete=false
{{- end -}}
{{- end -}}

{{/*
Overlay one map onto another, recursing into nested maps. Unlike mergeOverwrite, values from
`over` always win, including false, 0 and empty lists. Returns YAML.
Usage: include "app-of-apps.overlay" (dict "base" $groupValue "over" $appValue) | fromYaml
*/}}
{{- define "app-of-apps.overlay" -}}
{{- $base := deepCopy (default dict .base) -}}
{{- range $k, $v := (default dict .over) -}}
{{- if and (kindIs "map" $v) (kindIs "map" (get $base $k)) -}}
{{- $_ := set $base $k (include "app-of-apps.overlay" (dict "base" (get $base $k) "over" $v) | fromYaml) -}}
{{- else -}}
{{- $_ := set $base $k $v -}}
{{- end -}}
{{- end -}}
{{- toYaml $base -}}
{{- end -}}

{{/*
Group setting `key` with the application's `key` overlaid. Returns YAML.
Usage: include "app-of-apps.appSetting" (dict "key" "resourceQuota" "app" $value "root" $) | fromYaml
*/}}
{{- define "app-of-apps.appSetting" -}}
{{- $over := dict -}}
{{- if .app -}}
{{- $over = default dict (get .app .key) -}}
{{- end -}}
{{- include "app-of-apps.overlay" (dict "base" (get .root.Values .key) "over" $over) -}}
{{- end -}}
