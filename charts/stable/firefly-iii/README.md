# firefly-iii

![Version: 9.0.2](https://img.shields.io/badge/Version-9.0.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: version-5.6.14](https://img.shields.io/badge/AppVersion-version--5.6.14-informational?style=flat-square)

Firefly III: a personal finances manager

## Source Code

* <https://github.com/firefly-iii/firefly-iii>

## Requirements

Kubernetes: `>=1.16.0-0`

## Dependencies

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | mariadb | 18.0.2 |
| https://charts.bitnami.com/bitnami | postgresql | 13.4.4 |
| https://charts.bitnami.com/bitnami | redis | 18.19.4 |
| https://mikevader.github.io/charts | common | 4.5.35 |

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
| cronjobs.recurring.affinity | object | `{}` |  |
| cronjobs.recurring.enabled | bool | `false` | Enable cronjob for creating recurring transactions |
| cronjobs.recurring.failedJobsHistoryLimit | int | `1` | How many pods to keep around for failed jobs |
| cronjobs.recurring.image.pullPolicy | string | `"IfNotPresent"` |  |
| cronjobs.recurring.image.repository | string | `"curlimages/curl"` |  |
| cronjobs.recurring.image.tag | string | `"8.7.1"` |  |
| cronjobs.recurring.imagePullSecrets | list | `[]` |  |
| cronjobs.recurring.nodeSelector | object | `{}` |  |
| cronjobs.recurring.podAnnotations | object | `{}` |  |
| cronjobs.recurring.podSecurityContext | object | `{}` |  |
| cronjobs.recurring.resources | object | `{}` |  |
| cronjobs.recurring.restartPolicy | string | `"OnFailure"` | How to treat failed jobs |
| cronjobs.recurring.schedule | string | `"0 3 * * *"` | Schedule time in UTC |
| cronjobs.recurring.securityContext | object | `{}` |  |
| cronjobs.recurring.successfulJobsHistoryLimit | int | `3` | How many pods to keep around for successful jobs |
| cronjobs.recurring.tolerations | list | `[]` |  |
| env | object | See below | environment variables. See [image docs](https://github.com/firefly-iii/firefly-iii/blob/main/.env.example) for more details. |
| env.APP_DEBUG | bool | `false` | Set to true if you want to see debug information in error screens. |
| env.APP_ENV | string | `"local"` | You can leave this on "local". If you change it to production most console commands will ask for extra confirmation.   Never set it to "testing". |
| env.FIREFLY_III_LAYOUT | string | `"v1"` | Set UI layout version |
| env.MAIL_MAILER | string | `"log"` | If you want Firefly III to email you, update these settings   For instructions, see [this](https://docs.firefly-iii.org/advanced-installation/email)   If you use Docker or similar, you can set these variables from a file by appending them with _FILE |
| env.SEND_ERROR_MESSAGE | bool | `true` | Send mail on errors. |
| env.SEND_LOGIN_NEW_IP_WARNING | bool | `true` | Send mail on logins from new IP. |
| env.SEND_REGISTRATION_MAIL | bool | `true` | Send mail on new registrations. |
| env.SEND_REPORT_JOURNALS | bool | `false` | Send mail on recurring transactions.   These messages contain (sensitive) transaction information: |
| env.STATIC_CRON_TOKEN | string | `""` | The static cron job token can be useful when you use Docker and wish to manage cron jobs.   1. Set this token to any 32-character value (this is important!).   2. Use this token in the cron URL instead of a user's command line token.    For more info: https://docs.firefly-iii.org/firefly-iii/advanced-installation/cron/    You can set this variable from a file by appending it with _FILE  |
| env.TZ | string | `"Europe/Amsterdam"` | Change this value to your preferred time zone.   Example: Europe/Amsterdam   For a list of supported time zones, see [this](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"fireflyiii/core"` | image repository |
| image.tag | string | `nil` |  |
| importer.affinity | object | `{}` |  |
| importer.controllerAnnotations | object | `{}` |  |
| importer.controllerLabels | object | `{}` |  |
| importer.enabled | bool | `true` | Deploy transaction importer |
| importer.image.pullPolicy | string | `"IfNotPresent"` |  |
| importer.image.repository | string | `"fireflyiii/data-importer"` |  |
| importer.image.tag | string | `"version-1.2.2"` |  |
| importer.imagePullSecrets | list | `[]` |  |
| importer.nodeSelector | object | `{}` |  |
| importer.podAnnotations | object | `{}` |  |
| importer.podSecurityContext | object | `{}` |  |
| importer.resources | object | `{}` |  |
| importer.securityContext | object | `{}` |  |
| importer.specs[0].accessToken | string | `""` | Fill your user's personal access token here |
| importer.specs[0].importerName | string | `"default-importer"` |  |
| importer.specs[0].port | int | `8080` |  |
| importer.specs[0].replicaCount | int | `1` |  |
| importer.specs[0].vanityUrl | string | `""` |  |
| importer.tolerations | list | `[]` |  |
| ingress.main | object | See values.yaml | Enable and configure ingress settings for the chart under this key. |
| mariadb | object | See values.yaml | Enable and configure mariadb subchart under this key.    For more options see [mariadb chart documentation](https://github.com/bitnami/charts/tree/master/bitnami/mariadb) https://github.com/bitnami/charts/tree/master/bitnami/mariadb/#installing-the-chart |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| persistence.uploads.enabled | bool | `false` | Enable persistence for uploading attachments for transactions |
| postgresql | object | See values.yaml | Enable and configure postgresql subchart under this key.    For more options see [postgresql chart documentation](https://github.com/bitnami/charts/tree/master/bitnami/postgresql) https://github.com/bitnami/charts/tree/master/bitnami/postgresql/#installing-the-chart |
| redis | object | See values.yaml | Enable and configure redis subchart under this key.    For more options see [redis chart documentation](https://github.com/bitnami/charts/tree/master/bitnami/redis) |
| service | object | See values.yaml | Configures service settings for the chart. Normally this does not need to be modified. |
| strategy.type | string | `"Recreate"` |  |

