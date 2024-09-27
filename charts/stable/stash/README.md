# stash

![Version: 3.5.0](https://img.shields.io/badge/Version-3.5.0-informational?style=flat-square) ![AppVersion: v0.27.0](https://img.shields.io/badge/AppVersion-v0.27.0-informational?style=flat-square)

An organizer for your other movies, written in Go

## Source Code

* <https://github.com/stashapp/stash>
* <https://hub.docker.com/r/stashapp/stash>

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
| env | object | See below | environment variables. See more environment variables in the [stashapp documentation](https://raw.githubusercontent.com/stashapp/stash/master/docker/production/docker-compose.yml) |
| env.STASH_PORT | int | `9999` | Set the container port |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"stashapp/stash"` | image repository |
| image.tag | string | `nil` | image tag |
| ingress.main | object | See values.yaml | Enable and configure ingress settings for the chart under this key. |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| service | object | See values.yaml | Configures service settings for the chart. |

