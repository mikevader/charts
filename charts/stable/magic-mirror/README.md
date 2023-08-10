# magic-mirror

![Version: 4.4.7](https://img.shields.io/badge/Version-4.4.7-informational?style=flat-square) ![AppVersion: v2.15.0](https://img.shields.io/badge/AppVersion-v2.15.0-informational?style=flat-square)

magic-mirror helm package

## Source Code

* <https://github.com/MichMich/MagicMirror>
* <https://hub.docker.com/r/bastilimbach/docker-magicmirror>

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

The default login details (change ASAP) are:

* password:deluge

## Values

**Important**: When deploying an application Helm chart you can add more values from our common library chart [here](https://github.com/mikevader/charts/tree/main/charts/library/common)

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| config | string | See values.yaml | Contents of your config.js, supports Helm templates. See [application docs](https://docs.magicmirror.builders/getting-started/configuration.html) for more details. |
| custom_css | string | `""` | Contents of your custom.css |
| env | object | See below | environment variables. See [image docs](https://github.com/bastilimbach/docker-MagicMirror) for more details. |
| env.TZ | string | `"UTC"` | Set the container timezone |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"bastilimbach/docker-magicmirror"` | image repository |
| image.tag | string | `nil` | image tag |
| ingress.main | object | See values.yaml | Enable and configure ingress settings for the chart under this key. |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| service | object | See values.yaml | Configures service settings for the chart. |

