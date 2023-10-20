# recipes

![Version: 6.6.12](https://img.shields.io/badge/Version-6.6.12-informational?style=flat-square) ![AppVersion: 1.0.5.2](https://img.shields.io/badge/AppVersion-1.0.5.2-informational?style=flat-square)

Recipes is a Django application to manage, tag and search recipes using either built in models or external storage providers hosting PDF's, Images or other files.

## Source Code

* <https://github.com/vabene1111/recipes>
* <https://hub.docker.com/r/vabene1111/recipes>

## Requirements

Kubernetes: `>=1.16.0-0`

## Dependencies

| Repository | Name | Version |
|------------|------|---------|
| https://mikevader.github.io/charts | common | 4.5.21 |

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
| env | object | See below | environment variables. See [project docs](https://raw.githubusercontent.com/vabene1111/recipes/master/.env.template) for more details. |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"vabene1111/recipes"` | image repository |
| image.tag | string | `nil` | image tag |
| ingress.main | object | See values.yaml | Enable and configure ingress settings for the chart under this key. |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| service | object | See values.yaml | Configures service settings for the chart. |
| sidecar.config.client_max_body_size | string | `"128M"` | define the max body size to allow larger files to be uploaded |
| sidecar.config.reverse_proxy_header_username | string | `"x_authentik_username"` | define the name of the variable in the header containing the authenticated user. It is used together with enabling `REVERSE_PROXY_AUTH` |
| sidecar.image.pullPolicy | string | `"IfNotPresent"` | nginx sidecar image pull policy |
| sidecar.image.repository | string | `"nginx"` | nginx sidecar image repository |
| sidecar.image.tag | string | `"1.25.2"` | nginx sidecar image tag |

