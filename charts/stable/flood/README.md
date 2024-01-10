# flood

![Version: 6.4.9](https://img.shields.io/badge/Version-6.4.9-informational?style=flat-square) ![AppVersion: 4.7.0](https://img.shields.io/badge/AppVersion-4.7.0-informational?style=flat-square)

Flood is a monitoring service for various torrent clients

## Source Code

* <https://github.com/jesec/flood>
* <https://hub.docker.com/r/jesec/flood>

## Requirements

Kubernetes: `>=1.16.0-0`

## Dependencies

| Repository | Name | Version |
|------------|------|---------|
| https://mikevader.github.io/charts | common | 4.5.28 |

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
| env | object | See below | environment variables. See more environment variables in the [flood documentation] (https://github.com/jesec/flood/blob/v4.6.0/config.ts) Note: The environmental variables are not case sensitive (e.g. FLOOD_OPTION_port=FLOOD_OPTION_PORT). |
| env.FLOOD_OPTION_RUNDIR | string | `"/data"` | Where to store Flood's runtime files (eg. database) |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"jesec/flood"` | image repository |
| image.tag | string | chart.appVersion | image tag |
| ingress.main | object | See values.yaml | Enable and configure ingress settings for the chart under this key. |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| service | object | See values.yaml | Configures service settings for the chart. |

