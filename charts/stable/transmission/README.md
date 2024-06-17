# transmission

![Version: 8.4.18](https://img.shields.io/badge/Version-8.4.18-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 4.0.6](https://img.shields.io/badge/AppVersion-4.0.6-informational?style=flat-square)

Transmission is a cross-platform BitTorrent client

## Source Code

* <https://github.com/transmission/transmission>
* <https://github.com/mikevader/container-images>

## Requirements

Kubernetes: `>=1.16.0-0`

## Dependencies

| Repository | Name | Version |
|------------|------|---------|
| https://mikevader.github.io/charts | common | 4.5.35 |

## Installing the Chart

This is a [Helm Library Chart](https://helm.sh/docs/topics/library_charts/#helm).

**WARNING: THIS CHART IS NOT MEANT TO BE INSTALLED DIRECTLY**

## Configuration

Read through the [values.yaml](./values.yaml) file. It has several commented out suggested values.

## Custom configuration

To view more environment variables [see here](https://github.com/k8s-at-home/container-images/tree/main/apps/transmission/settings.json.tmpl)

## Values

**Important**: When deploying an application Helm chart you can add more values from our common library chart [here](https://github.com/mikevader/charts/tree/main/charts/library/common)

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | See below | environment variables. See [image docs](https://docs.linuxserver.io/images/docker-transmission) for more details. |
| env.TRANSMISSION_DOWNLOAD_DIR | string | `"/downloads/complete"` | Torrent download directory |
| env.TRANSMISSION_INCOMPLETE_DIR | string | `"/downloads/incomplete"` | Incomplete download directory |
| env.TRANSMISSION_INCOMPLETE_DIR_ENABLED | bool | `false` | Enable incomplete download directory |
| env.TRANSMISSION_RPC_PASSWORD | string | `"CHANGEME"` | Password to access the Web UI |
| env.TRANSMISSION_WATCH_DIR | string | `"/watch"` | Watch directory |
| env.TRANSMISSION_WATCH_DIR_ENABLED | bool | `false` | Enable watch directory |
| env.TRANSMISSION_WEB_HOME | string | `"/web"` | Path in container where the Web UI is located |
| env.TZ | string | `"UTC"` | Set the container timezone |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"lscr.io/linuxserver/transmission"` | image repository |
| image.tag | string | chart.appVersion | image tag |
| ingress.main | object | See values.yaml | Enable and configure ingress settings for the chart under this key. |
| initContainers | object | See values.yaml | Use an initContainer to download the Flood web ui Set UI with env `TRANSMISSION_WEB_HOME` set to `/config/flood-for-transmission/` |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| probes | object | See values.yaml | Configures the probes for the main Pod. # transmission runs the GUI and I/O on the same thread. # Heavy bandwith usage may stall the UI and result in restarts. |
| service | object | See values.yaml | Configures service settings for the chart. |

