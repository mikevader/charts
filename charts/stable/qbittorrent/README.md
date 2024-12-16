# qbittorrent

![Version: 13.5.31](https://img.shields.io/badge/Version-13.5.31-informational?style=flat-square) ![AppVersion: v4.6.7](https://img.shields.io/badge/AppVersion-v4.6.7-informational?style=flat-square)

qBittorrent is a cross-platform free and open-source BitTorrent client

## Source Code

* <https://github.com/qbittorrent/qBittorrent>
* <https://github.com/mikevader/container-images>

## Requirements

Kubernetes: `>=1.16.0-0`

## Dependencies

| Repository | Name | Version |
|------------|------|---------|
| https://mikevader.github.io/charts | common | 4.5.36 |

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
| env | object | See below | environment variables. See [image docs](https://docs.k8s-at-home.com/our-container-images/configuration/) for more details. |
| env.TZ | string | `"UTC"` | Set the container timezone |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"ghcr.io/mikevader/qbittorrent"` | image repository |
| image.tag | string | `nil` |  |
| ingress.main | object | See values.yaml | Enable and configure ingress settings for the chart under this key. |
| metrics.enabled | bool | See values.yaml | Enable and configure prometheus-qbittorrent-exporter sidecar and Prometheus podMonitor. |
| metrics.exporter.env.logLevel | string | `"INFO"` | log level [DEBUG|INFO|WARNING|ERROR|CRITICAL] |
| metrics.exporter.env.password | string | `"adminadmin"` | qbittorrent password update value after configuring qbittorrent |
| metrics.exporter.env.port | int | `9022` | metrics port |
| metrics.exporter.env.user | string | `"admin"` | qbittorrent username update value after configuring qbittorrent |
| metrics.exporter.image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| metrics.exporter.image.repository | string | `"esanchezm/prometheus-qbittorrent-exporter"` | image repository |
| metrics.exporter.image.tag | string | `"v1.6.0"` | image tag |
| metrics.prometheusRule | object | See values.yaml | Enable and configure Prometheus Rules for the chart under this key. |
| metrics.prometheusRule.rules | list | See prometheusrules.yaml | Configure additionial rules for the chart under this key. |
| metrics.serviceMonitor.interval | string | `"15s"` |  |
| metrics.serviceMonitor.labels | object | `{}` |  |
| metrics.serviceMonitor.scrapeTimeout | string | `"5s"` |  |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| service | object | See values.yaml | Configures service settings for the chart. |
| settings.automaticPortSetup | bool | `false` | Enables automatic port configuration at startup This sets the qbittorrent port to the value of `service.bittorrent.ports.bittorrent.port`. |

