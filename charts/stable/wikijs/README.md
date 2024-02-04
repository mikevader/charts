# wikijs

![Version: 6.4.16](https://img.shields.io/badge/Version-6.4.16-informational?style=flat-square) ![AppVersion: version-2.5.201](https://img.shields.io/badge/AppVersion-version--2.5.201-informational?style=flat-square)

Make documentation a joy to write using Wiki.js's beautiful and intuitive interface!

## Source Code

* <https://hub.docker.com/r/linuxserver/wikijs/>
* <https://github.com/Requarks/wiki>

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
| env | object | See below | environment variables. See [image docs](https://docs.linuxserver.io/images/docker-wikijs#environment-variables-e) for more details. |
| env.TZ | string | `"UTC"` | Set the container timezone |
| image | object | `{"pullPolicy":"IfNotPresent","repository":"ghcr.io/linuxserver/wikijs","tag":null}` | This is the default, you can also use requarks/wiki |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"ghcr.io/linuxserver/wikijs"` | image repository |
| image.tag | string | `nil` | image tag |
| ingress.main | object | See values.yaml | Enable and configure ingress settings for the chart under this key. |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| service | object | See values.yaml | Configures service settings for the chart. |

