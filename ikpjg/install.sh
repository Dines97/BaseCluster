#!/usr/bin/env bash

KIND=namespace
NAMESPACE=argo-cd
ARGOCD_RELEASE=argo-cd
SELF_RELEASE=self

helm install $ARGOCD_RELEASE argo/argo-cd --create-namespace --namespace $NAMESPACE

kubectl delete secret sh.helm.release.v1.$ARGOCD_RELEASE.v1 --namespace $NAMESPACE

kubectl annotate $KIND $NAMESPACE meta.helm.sh/release-name=$SELF_RELEASE
kubectl annotate $KIND $NAMESPACE meta.helm.sh/release-namespace=$NAMESPACE
kubectl label $KIND $NAMESPACE app.kubernetes.io/managed-by=Helm

helm install $SELF_RELEASE . -n $NAMESPACE

