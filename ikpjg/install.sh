#!/usr/bin/env bash

KIND=namespace
NAMESPACE=argo-cd
RELEASE=argo-cd-0

helm install $RELEASE argo/argo-cd --create-namespace --namespace $NAMESPACE

kubectl delete secret sh.helm.release.v1.$RELEASE.v1 --namespace $NAMESPACE

kubectl annotate $KIND $NAMESPACE meta.helm.sh/release-name=$RELEASE
kubectl annotate $KIND $NAMESPACE meta.helm.sh/release-namespace=$NAMESPACE
kubectl label $KIND $NAMESPACE app.kubernetes.io/managed-by=Helm

helm install $RELEASE . -n $NAMESPACE

