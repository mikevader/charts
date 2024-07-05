# flaresolverr

![Version: 1.2.4](https://img.shields.io/badge/Version-1.2.4-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v3.3.21](https://img.shields.io/badge/AppVersion-v3.3.21-informational?style=flat-square)

FlareSolverr is a proxy server to bypass Cloudflare protection

## Source Code

* <https://github.com/FlareSolverr/FlareSolverr>
* <https://github.com/mikevader/container-images/>

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
| env | object | See below | environment variables. See more environment variables in the [flaresolverr documentation](https://github.com/FlareSolverr/FlareSolverr#environment-variables). |
| env.TZ | string | `"Europe/Zurich"` | Set the container timezone |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"ghcr.io/flaresolverr/flaresolverr"` | image repository |
| ingress.main | object | See values.yaml | Enable and configure ingress settings for the chart under this key. |
| service | object | See values.yaml | Configures service settings for the chart. |

