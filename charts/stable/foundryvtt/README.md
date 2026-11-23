# foundryvtt

![Version: 4.0.0](https://img.shields.io/badge/Version-4.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 14.370.1](https://img.shields.io/badge/AppVersion-14.370.1-informational?style=flat-square)

An easy-to-deploy Dockerized Foundry Virtual Tabletop server

## Source Code

* <https://github.com/felddy/foundryvtt-docker>

## Requirements

Kubernetes: `>=1.16.0-0`

## Dependencies

| Repository | Name | Version |
|------------|------|---------|
| https://mikevader.github.io/charts | common | 4.10.0 |

## Installing the Chart

This is a [Helm Library Chart](https://helm.sh/docs/topics/library_charts/#helm).

**WARNING: THIS CHART IS NOT MEANT TO BE INSTALLED DIRECTLY**

## Configuration

Read through the [values.yaml](./values.yaml) file. It has several commented out suggested values.

## Custom configuration

### Upgrading from 3.x to 4.x

Chart 4.x ships felddy/foundryvtt v14 (previously v12).

- **Back up `/data` before upgrading.** Foundry VTT migrates worlds to the new format on first start.
- Since v13 the container runs as the non-root user `node` (uid/gid `1000`) and no longer changes the ownership of `/data`.
  Older versions ran as root and chowned `/data` to `421:421`.
  The chart sets `podSecurityContext.fsGroup: 1000`, so Kubernetes makes mounted volumes group-writable.
  Volume types that ignore `fsGroup`, such as `hostPath` or most NFS setups, need a one-time `chown -R 1000:1000` on the data directory.
- `FOUNDRY_UID`, `FOUNDRY_GID` and `CONTAINER_PRESERVE_OWNER` no longer have any effect.
  Use `podSecurityContext` to run as another user.
- Images for `linux/arm/v6` and `linux/arm/v7` are no longer published.
- Set `env.FOUNDRY_TELEMETRY` to `true` or `false` to avoid the telemetry prompt on every start.

## Values

**Important**: When deploying an application Helm chart you can add more values from our common library chart [here](https://github.com/mikevader/charts/tree/main/charts/library/common)

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | See below | environment variables. See [image docs](https://github.com/felddy/foundryvtt-docker#environment-variables) for more details. |
| env.FOUNDRY_ADMIN_KEY | string | `nil` | Admin password to be applied at startup. If omitted the admin password will be cleared. May be set using secrets. |
| env.FOUNDRY_PASSWORD | string | `nil` | Account password for foundryvtt.com. Required for downloading an application distribution. |
| env.FOUNDRY_RELEASE_URL | string | `nil` | S3 pre-signed URL generate from the user's profile. Required for downloading an application distribution. |
| env.FOUNDRY_TELEMETRY | string | `nil` | Opt in (`true`) or out (`false`) of Foundry VTT telemetry. Set it explicitly to avoid the prompt on every start. |
| env.FOUNDRY_USERNAME | string | `nil` | Account username or email address for foundryvtt.com. Required for downloading an application distribution. |
| env.TZ | string | `"UTC"` | Set the container timezone |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"felddy/foundryvtt"` | image repository |
| image.tag | string | `nil` | image tag |
| ingress.main | object | See values.yaml | Enable and configure ingress settings for the chart under this key. |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. Foundryvtt is hardcoded to use /data for its persistance for config |
| podSecurityContext | object | See values.yaml | Pod security context. Since v13 the image runs as the non-root user `node` (1000:1000) and no longer changes the ownership of `/data`. `fsGroup` makes mounted volumes writable, including volumes written by chart versions < 4.0.0 (owned by 421:421). Volume types that ignore `fsGroup` (e.g. hostPath, most NFS setups) need a one-time `chown -R 1000:1000`. |
| service | object | See values.yaml | Configures service settings for the chart. Normally this does not need to be modified. |
| strategy.type | string | `"Recreate"` |  |

