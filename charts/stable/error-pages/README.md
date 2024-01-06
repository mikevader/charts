# error-pages

![Version: 1.4.17](https://img.shields.io/badge/Version-1.4.17-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.26.0](https://img.shields.io/badge/AppVersion-2.26.0-informational?style=flat-square)

Server error pages in the docker image

## Source Code

* <https://github.com/tarampampam/error-pages>

## Requirements

Kubernetes: `>=1.16.0-0`

## Dependencies

| Repository | Name | Version |
|------------|------|---------|
| https://mikevader.github.io/charts | common | 4.5.27 |

## Installing the Chart

This is a [Helm Library Chart](https://helm.sh/docs/topics/library_charts/#helm).

**WARNING: THIS CHART IS NOT MEANT TO BE INSTALLED DIRECTLY**

## Configuration

Read through the [values.yaml](./values.yaml) file. It has several commented out suggested values.

## Custom configuration

For use with Traefik you will also need to create a `IngressRoute` and `Middleware`, see the examples below:

```yaml
---
apiVersion: traefik.io/v1alpha1
kind: IngressRoute
metadata:
  name: error-pages
  namespace: networking
spec:
  entryPoints:
    - websecure
  routes:
    - kind: Rule
      match: HostRegexp(`{host:.+}`)
      priority: 1
      services:
        - kind: Service
          name: error-pages
          port: 8080
  tls:
    secretName: error-pages-tls
```

```yaml
---
apiVersion: traefik.io/v1alpha1
kind: Middleware
metadata:
  name: error-pages
  namespace: networking
spec:
  errors:
    status:
      - "400-599"
    query: /{status}.html
    service:
      name: error-pages
      port: 8080
```

## Values

**Important**: When deploying an application Helm chart you can add more values from our common library chart [here](https://github.com/mikevader/charts/tree/main/charts/library/common)

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | See below | environment variables. See the [error-pages documentation](https://github.com/tarampampam/error-pages/wiki/HTTP-server) for more info. |
| env.SHOW_DETAILS | string | `"false"` | Enable details on error pages |
| env.TEMPLATE_NAME | string | `"l7-dark"` | Set the template |
| env.TZ | string | `"UTC"` | Set the container timezone |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"ghcr.io/tarampampam/error-pages"` | image repository |
| image.tag | string | `nil` | image tag |
| ingress.main | object | See values.yaml | Enable and configure ingress settings for the chart under this key. |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| service.main.ports.http.port | int | `8080` |  |

