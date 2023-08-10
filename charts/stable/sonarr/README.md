# sonarr

![Version: 16.3.4](https://img.shields.io/badge/Version-16.3.4-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v3.0.10.1567](https://img.shields.io/badge/AppVersion-v3.0.10.1567-informational?style=flat-square)

Smart PVR for newsgroup and bittorrent users

## Source Code

* <https://github.com/Sonarr/Sonarr>
* <https://github.com/mikevader/container-images/>

## Requirements

Kubernetes: `>=1.16.0-0`

## Dependencies

| Repository | Name | Version |
|------------|------|---------|
| https://mikevader.github.io/charts | common | 4.5.17 |

## Installing the Chart

This is a [Helm Library Chart](https://helm.sh/docs/topics/library_charts/#helm).

**WARNING: THIS CHART IS NOT MEANT TO BE INSTALLED DIRECTLY**

## Configuration

Read through the [values.yaml](./values.yaml) file. It has several commented out suggested values.

## Custom configuration

N/A

## Values

**Important**: When deploying an application Helm chart you can add more values from our common library chart [here](https://github.com/mikevader/charts/tree/main/charts/library/common)

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | See below | environment variables. |
| env.TZ | string | `"UTC"` | Set the container timezone |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"ghcr.io/mikevader/sonarr"` | image repository |
| image.tag | string | `nil` |  |
| ingress.main | object | See values.yaml | Enable and configure ingress settings for the chart under this key. |
| metrics.enabled | bool | See values.yaml | Enable and configure Exportarr sidecar and Prometheus serviceMonitor. |
| metrics.exporter.env.additionalMetrics | bool | `false` | Set to true to enable gathering of additional metrics (slow) |
| metrics.exporter.env.port | int | `9794` | metrics port |
| metrics.exporter.env.unknownQueueItems | bool | `false` | Set to true to enable gathering unknown queue items |
| metrics.exporter.image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| metrics.exporter.image.repository | string | `"ghcr.io/onedr0p/exportarr"` | image repository |
| metrics.exporter.image.tag | string | `"v1.0.0"` | image tag |
| metrics.prometheusRule | object | See values.yaml | Enable and configure Prometheus Rules for the chart under this key. |
| metrics.prometheusRule.rules | list | See prometheusrules.yaml | Configure additionial rules for the chart under this key. |
| metrics.serviceMonitor.interval | string | `"3m"` |  |
| metrics.serviceMonitor.labels | object | `{}` |  |
| metrics.serviceMonitor.scrapeTimeout | string | `"1m"` |  |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. # Config persistence is required for the Prometheus exporter sidecar. |
| probes | object | See values.yaml | Configures the probes for the main Pod. |
| service | object | See values.yaml | Configures service settings for the chart. |

