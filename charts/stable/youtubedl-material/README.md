# youtubedl-material

![Version: 4.4.17](https://img.shields.io/badge/Version-4.4.17-informational?style=flat-square) ![AppVersion: 4.3](https://img.shields.io/badge/AppVersion-4.3-informational?style=flat-square)

Self-hosted YouTube downloader built on Material Design

## Source Code

* <https://github.com/Tzahi12345/YoutubeDL-Material>
* <https://github.com/mikevader/charts/tree/master/charts/youtubedl-material>

## Requirements

Kubernetes: `>=1.16.0-0`

## Dependencies

| Repository | Name | Version |
|------------|------|---------|
| https://mikevader.github.io/charts | common | 4.5.30 |

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
| env | object | See below | environment variables. See [image repo](https://github.com/Tzahi12345/YoutubeDL-Material) for more details. |
| env.GID | string | `"1000"` | Specify the group ID the application will run as |
| env.TZ | string | `"UTC"` | Set the container timezone |
| env.UID | string | `"1000"` | Specify the user ID the application will run as |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"tzahi12345/youtubedl-material"` | image repository |
| image.tag | string | `nil` | image tag |
| ingress.main | object | See values.yaml | Enable and configure ingress settings for the chart under this key. |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| service | object | See values.yaml | Configures service settings for the chart. |

