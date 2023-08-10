# foundryvtt

![Version: 3.4.13](https://img.shields.io/badge/Version-3.4.13-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 11.306.0](https://img.shields.io/badge/AppVersion-11.306.0-informational?style=flat-square)

An easy-to-deploy Dockerized Foundry Virtual Tabletop server

## Source Code

* <https://github.com/felddy/foundryvtt-docker>

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
| env | object | See below | environment variables. See [image docs](https://github.com/felddy/foundryvtt-docker#environment-variables) for more details. |
| env.FOUNDRY_ADMIN_KEY | string | `nil` | Admin password to be applied at startup. If omitted the admin password will be cleared. May be set using secrets. |
| env.FOUNDRY_PASSWORD | string | `nil` | Account password for foundryvtt.com. Required for downloading an application distribution. |
| env.FOUNDRY_RELEASE_URL | string | `nil` | S3 pre-signed URL generate from the user's profile. Required for downloading an application distribution. |
| env.FOUNDRY_USERNAME | string | `nil` | Account username or email address for foundryvtt.com. Required for downloading an application distribution. |
| env.TZ | string | `"UTC"` | Set the container timezone |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"felddy/foundryvtt"` | image repository |
| image.tag | string | `nil` | image tag |
| ingress.main | object | See values.yaml | Enable and configure ingress settings for the chart under this key. |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. Foundryvtt is hardcoded to use /data for its persistance for config |
| service | object | See values.yaml | Configures service settings for the chart. Normally this does not need to be modified. |
| strategy.type | string | `"Recreate"` |  |

