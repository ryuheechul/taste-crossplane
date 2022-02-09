#!/usr/bin/env bash

USER_TOKEN_NAME=$(kubectl -n provide get serviceaccount provide -o=jsonpath='{.secrets[0].name}')
USER_TOKEN_VALUE=$(kubectl -n provide get secret/${USER_TOKEN_NAME} -o=go-template='{{.data.token}}' | base64 --decode)

CURRENT_CONTEXT=target-context
CURRENT_CLUSTER=target-cluster
CLUSTER_CA=$(kubectl -n provide get secret/${USER_TOKEN_NAME} -o=go-template='{{index .data "ca.crt"}}')
CLUSTER_SERVER=kubernetes.default.svc.cluster.local:443

kubectl delete secret kubeconfig || true

cat << EOF | kubectl create secret generic kubeconfig --from-file=/dev/stdin
apiVersion: v1
clusters:
- name: ${CURRENT_CLUSTER}
  cluster:
    certificate-authority-data: ${CLUSTER_CA}
    server: ${CLUSTER_SERVER}
contexts:
- name: ${CURRENT_CONTEXT}
  context:
    cluster: ${CURRENT_CLUSTER}
    user: provide
    namespace: provide
current-context: ${CURRENT_CONTEXT}
kind: Config
preferences: {}
users:
- name: provide
  user:
    token: ${USER_TOKEN_VALUE}
EOF
