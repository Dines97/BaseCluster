#!/usr/bin/env bash

KIND=namespace
NAMESPACE=argo-cd
ARGOCD_RELEASE=argo-cd
ROOT_RELEASE=root

helm upgrade --install $ARGOCD_RELEASE argo-cd --create-namespace --namespace $NAMESPACE --repo https://argoproj.github.io/argo-helm

kubectl delete secret sh.helm.release.v1.$ARGOCD_RELEASE.v1 --namespace $NAMESPACE

kubectl annotate $KIND $NAMESPACE meta.helm.sh/release-name=$ROOT_RELEASE
kubectl annotate $KIND $NAMESPACE meta.helm.sh/release-namespace=$NAMESPACE
kubectl label $KIND $NAMESPACE app.kubernetes.io/managed-by=Helm

helm upgrade --install $ROOT_RELEASE . -n $NAMESPACE --repo https://argoproj.github.io/argo-helm

