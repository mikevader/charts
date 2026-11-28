# app-of-apps

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

Argo CD app-of-apps chart that renders AppProjects, guarded Namespaces and Applications per app group

**This chart is not maintained by the upstream project and any issues with the chart should be raised [here](https://github.com/mikevader/charts/issues/new)**

## Source Code

* <https://github.com/mikevader/k3s-cluster-infra-apps/tree/master/apps-root-config>

## Requirements

## Dependencies

| Repository | Name | Version |
|------------|------|---------|

## TL;DR

```console
helm repo add mikevader https://mikevader.github.io/charts/
helm repo update
helm install app-of-apps mikevader/app-of-apps
```

## Installing the Chart

To install the chart with the release name `app-of-apps`

```console
helm install app-of-apps mikevader/app-of-apps
```

## Uninstalling the Chart

To uninstall the `app-of-apps` deployment

```console
helm uninstall app-of-apps
```

The command removes all the Kubernetes components associated with the chart **including persistent volumes** and deletes the release.

## Configuration

Read through the [values.yaml](./values.yaml) file. It has several commented out suggested values.
Other values may be used from the [values.yaml](https://github.com/mikevader/charts/tree/master/charts/library/common/values.yaml) from the [common library](https://github.com/mikevader/charts/tree/master/charts/library/common).

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

```console
helm install app-of-apps \
  --set env.TZ="America/New_York" \
    mikevader/app-of-apps
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart.

```console
helm install app-of-apps mikevader/app-of-apps -f values.yaml
```

## Custom configuration

The chart renders one Argo CD app group per release. One values file per app group lists the group's applications. For every application the chart renders

- an `Application` pointing at `<repository>/<subFolder>/<name>`,
- a `Namespace` with Pod Security Admission labels and, if switched on, a LimitRange, ResourceQuota,
  NetworkPolicies, a Vault `SecretStore` and RoleBindings,

plus one `AppProject` (named after the release) restricted to the group's destination namespaces.

```yaml
repository: https://github.com/mikevader/k3s-cluster-infra-apps.git
subFolder: cluster-platform-apps
enableDefaultNetworkPolicy: true
applications:
  authentik: {}
  vault:
    serverSideDiff: true
    podSecurity:
      enforce: privileged
```

Group-level settings (`podSecurity`, `onRemoval`, `limitRange`, `resourceQuota`, `networkPolicy`,
`vaultSecretStore`) can be overridden per application; the application's value is overlaid on
the group value.

The parent Applications that deploy each group are rendered by the
[app-of-apps-bootstrap](../app-of-apps-bootstrap) chart.

## Values

**Important**: When deploying an application Helm chart you can add more values from our common library chart [here](https://github.com/mikevader/charts/tree/master/charts/library/common)

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| allowAllNamespaces | bool | `false` | Allow the AppProject to deploy to every namespace instead of only the destination namespaces of its applications |
| applications | object | `{}` | Applications of this group, keyed by name. The key is also the default destination namespace and the name of the Namespace the chart creates. |
| argocdNamespace | string | `"argocd-system"` | Namespace Argo CD runs in; AppProjects and Applications are created there |
| clusterResourceWhitelist | list | `[]` | `spec.clusterResourceWhitelist` of the AppProject |
| enableDefaultLimitRange | bool | `false` | Create the LimitRange `core-resource-limits` in every Namespace |
| enableDefaultNetworkPolicy | bool | `false` | Create the NetworkPolicies in every Namespace |
| enableDefaultResourceQuota | bool | `false` | Create the ResourceQuota `core-resource-quota` in every Namespace (only if `hard` is set) |
| enableVaultSecretStore | bool | `false` | Create a ServiceAccount and a Vault SecretStore in every Namespace |
| limitRange.limits | list | `[{"max":{"cpu":"4","memory":"8Gi"},"min":{"cpu":"1m","memory":1},"type":"Pod"},{"default":{"cpu":2,"memory":"1Gi"},"defaultRequest":{"cpu":"25m","memory":"512Mi"},"type":"Container"}]` | LimitRange `spec.limits` (enableDefaultLimitRange) |
| namespace.annotations | object | `{}` | Annotations added to every created Namespace |
| namespace.labels | object | `{}` | Labels added to every created Namespace |
| namespaceResourceBlacklist | list | `[]` | `spec.namespaceResourceBlacklist` of the AppProject |
| networkPolicy.egress.allowInternet | bool | `true` | Allow egress to the internet |
| networkPolicy.egress.enabled | bool | `false` | Restrict outbound traffic (restrict-egress). Allowed: same namespace, cluster DNS, the internet (if allowInternet), plus extraEgress. |
| networkPolicy.egress.internetExcept | list | `["10.0.0.0/8","172.16.0.0/12","192.168.0.0/16","100.64.0.0/10","169.254.0.0/16"]` | Destinations excluded from "the internet": pod/service CIDRs, LAN, link-local, CGNAT |
| networkPolicy.extraEgress | list | `[]` | Additional raw NetworkPolicy egress rules (only used when egress.enabled) |
| networkPolicy.extraIngress | list | `[]` | Additional raw NetworkPolicy ingress rules (allow-extra-ingress) |
| networkPolicy.ingressFromNamespaces | list | `["traefik","nginx"]` | Namespaces allowed to reach every pod (ingress controllers). Same-namespace traffic is always allowed; everything else inbound is denied. |
| onRemoval | string | `"confirm"` | Cascade behaviour when an application is removed: `delete`, `confirm` or `preserve` (details in values.yaml). Overridable per application. |
| podSecurity.audit | string | `"restricted"` | Pod Security Admission `audit` level |
| podSecurity.enforce | string | `"baseline"` | Pod Security Admission `enforce` level |
| podSecurity.version | string | `"latest"` | Policy version the levels are evaluated against ("latest" or e.g. "v1.35") |
| podSecurity.warn | string | `"restricted"` | Pod Security Admission `warn` level |
| repository | string | `""` | Git repository holding the application charts (and the group values files). Used as `repoURL` of every rendered Application and as AppProject source repo. |
| resourceQuota.hard | object | `{}` | ResourceQuota `spec.hard` (enableDefaultResourceQuota). A quota on requests.*/limits.* rejects pods without them, so pair it with the LimitRange. |
| roleBindings | list | `[]` | RoleBindings to a ClusterRole created in every Namespace |
| subFolder | string | `""` | Folder in `repository` holding the group's application charts. An application's source path defaults to `<subFolder>/<application name>`. |
| vaultSecretStore.mountPath | string | `"kubernetes"` | Kubernetes auth mount |
| vaultSecretStore.name | string | `"vault"` | Name of the SecretStore |
| vaultSecretStore.path | string | `"secret"` | KV v2 mount |
| vaultSecretStore.role | string | `""` | Vault role (required with enableVaultSecretStore) |
| vaultSecretStore.server | string | `"http://vault.vault.svc:8200"` | Vault address |
| vaultSecretStore.serviceAccountName | string | `"vault-reader"` | ServiceAccount used to authenticate against Vault |

## Changelog

### Version 1.0.0

#### Added

- Initial version, extracted from the apps-root-config `applications` chart of k3s-cluster-infra-apps

### Older versions

A historical overview of changes can be found on the [GitHub releases](https://github.com/mikevader/charts/releases?q=app-of-apps&expanded=true) page.

## Support

- Open an [issue](https://github.com/mikevader/charts/issues/new)

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
