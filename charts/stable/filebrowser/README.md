# filebrowser

![Version: 1.5.25](https://img.shields.io/badge/Version-1.5.25-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v2.27.0](https://img.shields.io/badge/AppVersion-v2.27.0-informational?style=flat-square)

filebrowser provides a file managing interface within a specified directory

## Source Code

* <https://github.com/filebrowser/filebrowser>

## Requirements

Kubernetes: `>=1.16.0-0`

## Dependencies

| Repository | Name | Version |
|------------|------|---------|
| https://mikevader.github.io/charts | common | 4.5.34 |

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
| config | string | `"{\n  \"port\": 80,\n  \"baseURL\": \"\",\n  \"address\": \"\",\n  \"log\": \"stdout\",\n  \"database\": \"/config/database.db\",\n  \"root\": \"/srv/data\"\n}\n"` |  |
| env.TZ | string | `"UTC"` | Set the container timezone |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"filebrowser/filebrowser"` | image repository |
| image.tag | string | `nil` | image tag |
| ingress.main | object | See values.yaml | Enable and configure ingress settings for the chart under this key. |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| service | object | See values.yaml | Configures service settings for the chart. |

