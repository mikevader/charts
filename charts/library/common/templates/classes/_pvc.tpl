{{/*
This template serves as a blueprint for all PersistentVolumeClaim objects that are created
within the common library.
*/}}
{{- define "common.classes.pvc" -}}
{{- $values := .Values.persistence -}}
{{- if hasKey . "ObjectValues" -}}
  {{- with .ObjectValues.persistence -}}
    {{- $values = . -}}
  {{- end -}}
{{ end -}}
{{- $pvcName := include "common.names.fullname" . -}}
{{- if and (hasKey $values "nameOverride") $values.nameOverride -}}
  {{- if not (eq $values.nameOverride "-") -}}
    {{- $pvcName = printf "%v-%v" $pvcName $values.nameOverride -}}
  {{ end -}}
{{ end }}
---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: {{ $pvcName }}
  {{- with (merge ($values.labels | default dict) (include "common.labels" $ | fromYaml)) }}
  labels: {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- /* onRemoval: per PVC > global.persistence.onRemoval > "confirm"; retain: true means preserve */ -}}
  {{- $onRemoval := default "confirm" (dig "persistence" "onRemoval" "" (default dict $.Values.global)) -}}
  {{- with $values.onRemoval }}
    {{- $onRemoval = . -}}
  {{- end }}
  {{- if $values.retain }}
    {{- $onRemoval = "preserve" -}}
  {{- end }}
  {{- if not (has $onRemoval (list "delete" "confirm" "preserve")) }}
    {{- fail (printf "persistence onRemoval for PVC %v must be one of delete, confirm, preserve (got %q)" $pvcName $onRemoval) }}
  {{- end }}
  {{- $annotations := dict -}}
  {{- if eq $onRemoval "confirm" }}
    {{- $_ := set $annotations "argocd.argoproj.io/sync-options" "Prune=confirm,Delete=confirm" -}}
  {{- else if eq $onRemoval "preserve" }}
    {{- $_ := set $annotations "argocd.argoproj.io/sync-options" "Prune=false,Delete=false" -}}
    {{- $_ := set $annotations "helm.sh/resource-policy" "keep" -}}
  {{- end }}
  {{- /* explicit annotations win over the onRemoval defaults */ -}}
  {{- $annotations = merge (deepCopy ($values.annotations | default dict)) (include "common.annotations" $ | fromYaml) $annotations }}
  {{- with $annotations }}
  annotations: {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  accessModes:
    - {{ required (printf "accessMode is required for PVC %v" $pvcName) $values.accessMode | quote }}
  resources:
    requests:
      storage: {{ required (printf "size is required for PVC %v" $pvcName) $values.size | quote }}
  {{- if $values.storageClass }}
  storageClassName: {{ if (eq "-" $values.storageClass) }}""{{- else }}{{ $values.storageClass | quote }}{{- end }}
  {{- end }}
  {{- if $values.volumeName }}
  volumeName: {{ $values.volumeName | quote }}
  {{- end }}
{{- end -}}
