#!/bin/sh

export PIPELINE_VERSION=1.3.0
alias localkubectl="kubectl --kubeconfig $HOME/.kube/config_local"

localkubectl cluster-info
echo "------------------------------------------------------------------------------"
echo "Please verify if you are deploying to the LOCAL cluster!! Are you sure? (y/n)?"
echo "------------------------------------------------------------------------------"
read answer

if [ "$answer" != "${answer#[Yy]}" ] ;then
    echo Yes
    localkubectl delete -k "github.com/kubeflow/pipelines/manifests/kustomize/env/platform-agnostic-pns?ref=$PIPELINE_VERSION"
    localkubectl delete -k "github.com/kubeflow/pipelines/manifests/kustomize/cluster-scoped-resources?ref=$PIPELINE_VERSION"
    systemctl stop k3s
    docker stop $(docker ps -a -q)
    /usr/local/bin/k3s-uninstall.sh
else
    echo No
fi
echo "done!!"