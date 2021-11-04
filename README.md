# Krateo Runtime Operators Helm Charts

This repo contains Krateo Runtime Operators.

Fetching private GitHub repos:

```sh
$ kubectl create secret docker-registry cr-token \
  --namespace $(NAMESPACE) --docker-server=ghcr.io \
  --docker-password=$(GITHUB_TOKEN) --docker-username=$(ORG_NAME)
```

## Provider ArgoCD

To install this provider type:

```sh
$ helm repo add krateo-runtime https://krateo.io/runtime-helm-charts
$ helm repo update
$ helm install provider-argocd --namespace $(NAMESPACE) krateo-runtime/provider-argocd
```

## Provider vSphere

To install this provider type:

```sh
$ helm repo add krateo-runtime https://krateo.io/runtime-helm-charts
$ helm repo update
$ helm install provider-vsphere --namespace $(NAMESPACE) krateo-runtime/provider-vsphere
```
