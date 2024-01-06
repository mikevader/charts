# overseerr

![Version: 1.0.1](https://img.shields.io/badge/Version-1.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.33.2](https://img.shields.io/badge/AppVersion-1.33.2-informational?style=flat-square)

Overseerr is a free and open source software application for managing requests for your media library. It integrates with your existing services such as Sonarr, Radarr and Plex!

## Source Code

* <https://github.com/sct/overseerr>
* <https://hub.docker.com/r/sctx/overseerr>

## Requirements

Kubernetes: `>=1.16.0-0`

## Dependencies

| Repository | Name | Version |
|------------|------|---------|
| https://mikevader.github.io/charts | common | 4.5.27 |

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
| env.LOG_LEVEL | string | `"info"` | Set the application log level |
| env.TZ | string | `"Europe/Zurich"` | Set the container timezone |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"ghcr.io/sct/overseerr"` | image repository |
| image.tag | string | `nil` | image tag |
| ingress.main | object | See values.yaml | Enable and configure ingress settings for the chart under this key. |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| service | object | See values.yaml | Configures service settings for the chart. |

