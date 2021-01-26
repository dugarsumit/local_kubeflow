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
    localkubectl apply -k "github.com/kubeflow/pipelines/manifests/kustomize/cluster-scoped-resources?ref=$PIPELINE_VERSION"
    localkubectl wait --for condition=established --timeout=60s crd/applications.app.k8s.io
    localkubectl apply -k "github.com/kubeflow/pipelines/manifests/kustomize/env/platform-agnostic-pns?ref=$PIPELINE_VERSION"
    seelp 10s
    localkubectl apply -f cluster/kf-pipelines/aws_secrets.yaml
    echo "done!!"
    echo "Run the following command in order to access the pipelines at http://localhost:8081"
    echo "----------------------------------------------------------------"
    echo "localkubectl port-forward -n kubeflow svc/ml-pipeline-ui 8081:80"
    echo "-----------------------------------------------------------------"
    echo "It might take a few minutes before all the pipeline gets loaded."
else
    echo No
fi