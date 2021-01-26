#!/bin/sh

alias localkubectl="kubectl --kubeconfig $HOME/.kube/config_local"

localkubectl cluster-info
echo "------------------------------------------------------------------------------"
echo "Please verify if you are deploying to the LOCAL cluster!! Are you sure? (y/n)?"
echo "------------------------------------------------------------------------------"
read answer

if [ "$answer" != "${answer#[Yy]}" ] ;then
    echo Yes
    localkubectl scale deploy cache-server --replicas=0 -n kubeflow
    localkubectl scale deploy ml-pipeline --replicas=0 -n kubeflow
    localkubectl scale deploy metadata-grpc-deployment --replicas=0 -n kubeflow
    localkubectl scale deploy mysql --replicas=0 -n kubeflow
    localkubectl scale deploy minio --replicas=0 -n kubeflow
    localkubectl scale deploy ml-pipeline-ui --replicas=0 -n kubeflow
    localkubectl scale deploy ml-pipeline-viewer-crd --replicas=0 -n kubeflow
    localkubectl scale deploy metadata-writer --replicas=0 -n kubeflow
    localkubectl scale deploy controller-manager --replicas=0 -n kubeflow
    localkubectl scale deploy workflow-controller --replicas=0 -n kubeflow
    localkubectl scale deploy ml-pipeline-visualizationserver --replicas=0 -n kubeflow
    localkubectl scale deploy ml-pipeline-scheduledworkflow --replicas=0 -n kubeflow
    localkubectl scale deploy ml-pipeline-persistenceagent --replicas=0 -n kubeflow
    localkubectl scale deploy metadata-envoy-deployment --replicas=0 -n kubeflow
    localkubectl scale deploy cache-deployer-deployment --replicas=0 -n kubeflow
    localkubectl scale deploy traefik --replicas=0 -n kube-system
    localkubectl scale deploy coredns --replicas=0 -n kube-system
    localkubectl scale deploy metrics-server --replicas=0 -n kube-system
    localkubectl scale deploy local-path-provisioner --replicas=0 -n kube-system
    systemctl stop k3s
    docker stop $(docker ps -a -q)
else
    echo No
fi
echo "stopped!!"