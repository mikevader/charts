# plex

![Version: 6.6.5](https://img.shields.io/badge/Version-6.6.5-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.32.1.6999-91e1e2e2c](https://img.shields.io/badge/AppVersion-v1.32.1.6999--91e1e2e2c-informational?style=flat-square)

Plex Media Server

## Source Code

* <https://github.com/mikevader/charts/tree/master/charts/stable/plex>
* <https://github.com/mikevader/container-images/>

## Requirements

Kubernetes: `>=1.16.0-0`

## Dependencies

| Repository | Name | Version |
|------------|------|---------|
| https://mikevader.github.io/charts | common | 4.5.10 |

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
| env | object | See below | environment variables. See [plex docs](https://support.plex.tv/articles/201105343-advanced-hidden-server-settings/) for more details. **NOTE:** Plex preference options are camelCase and CASE SENSITIVE! You can do horrible things to your Plex configuration if you are not careful |
| env.TZ | string | `"UTC"` | Set the container timezone |
| hostNetwork | bool | `false` | Enable devices to be discoverable |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"ghcr.io/mikevader/plex"` | image repository |
| image.tag | string | `nil` |  |
| ingress.main | object | See values.yaml | Enable and configure ingress settings for the chart under this key. |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| podSecurityContext | object | `{}` | Configure the Security Context for the Pod |
| resources | object | `{}` | Configure the resource requests and/or limits for the Pod |
| service | object | See values.yaml | Configures service settings for the chart. |

