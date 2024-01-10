# tdarr

![Version: 4.7.10](https://img.shields.io/badge/Version-4.7.10-informational?style=flat-square) ![AppVersion: 2.16.01](https://img.shields.io/badge/AppVersion-2.16.01-informational?style=flat-square)

Tdarr is a self hosted web-app for automating media library transcode/remux management and making sure your files are exactly how you need them to be in terms of codecs/streams/containers etc.

## Source Code

* <https://www.github.com/HaveAGitGat/Tdarr>
* <https://hub.docker.com/r/haveagitgat/tdarr/>
* <https://tdarr.io/docs/>

## Requirements

## Dependencies

| Repository | Name | Version |
|------------|------|---------|
| https://mikevader.github.io/charts | common | 4.5.28 |

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
| env | object | See below | environment variables. See [image docs](https://hub.docker.com/r/haveagitgat/tdarr) for more details. |
| env.PGID | string | `"666"` | Set the container group id |
| env.PUID | string | `"666"` | Set the container user id |
| env.TZ | string | `"UTC"` | Set the container timezone |
| env.ffmpegPath | string | `""` | Allow override for the pre-compiled tdarr ffmpeg binary |
| env.serverIP | string | `"0.0.0.0"` | tdarr server binding address |
| env.serverPort | string | `"{{ .Values.service.main.ports.server.port }}"` | tdarr server listening port |
| env.webUIPort | string | `"{{ .Values.service.main.ports.http.port }}"` | tdarr web UI listening port (same as Service port) |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"haveagitgat/tdarr"` | image repository |
| image.tag | string | chart.appVersion | image tag |
| ingress.main | object | See values.yaml | Enable and configure ingress settings for the chart under this key. |
| node.enabled | bool | `true` | Deploy a tdarr node. |
| node.id | string | `"node"` | Node ID |
| node.image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| node.image.repository | string | `"haveagitgat/tdarr_node"` | image repository |
| node.image.tag | string | `"2.16.01"` | image tag |
| node.resources | object | `{}` | Node resources |
| persistence | object | See below | Configure persistence settings for the chart under this key. |
| persistence.config | object | See values.yaml | Volume used for configuration |
| persistence.data | object | See values.yaml | Volume used for tdarr server database |
| persistence.media | object | See values.yaml | Volume used for media libraries |
| persistence.shared | object | See values.yaml | Volume used for shared storage. e.g. emptydir transcode |
| service | object | See values.yaml | Configures service settings for the chart. |

