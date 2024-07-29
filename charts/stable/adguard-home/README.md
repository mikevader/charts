# adguard-home

![Version: 5.5.38](https://img.shields.io/badge/Version-5.5.38-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.107.52](https://img.shields.io/badge/AppVersion-v0.107.52-informational?style=flat-square)

DNS proxy as ad-blocker for local network

## Source Code

* <https://github.com/AdguardTeam/AdGuardHome>

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
| args | list | `["--config","/opt/adguardhome/conf/AdGuardHome.yaml","--work-dir","/opt/adguardhome/work","--no-check-update"]` | arguments passed to the adguard-home command line. |
| config | string | See values.yaml | AdGuard Home configuration. For a full list of options see https://github.com/AdguardTeam/AdGuardHome/wiki/Configuration. |
| controller.replicas | int | `1` | Number of pods to load balance between |
| env | object | See below | environment variables. |
| env.TZ | string | `"UTC"` | Set the container timezone |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"adguard/adguardhome"` | image repository |
| image.tag | string | `nil` |  |
| initContainers.copy-configmap | object | See values.yaml | Configures an initContainer that copies the configmap to the AdGuardHome conf directory It does NOT overwrite when the file already exists. |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| service | object | See values.yaml | Configures service settings for the chart. |

