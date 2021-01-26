#!/bin/sh

alias localkubectl="kubectl --kubeconfig $HOME/.kube/config_local"

echo "------------------------------------------------------------------------------"
echo "Please verify if you are deploying to the LOCAL cluster!! Are you sure? (y/n)?"
echo "------------------------------------------------------------------------------"
read answer

if [ "$answer" != "${answer#[Yy]}" ] ;then
    echo Yes
    systemctl start k3s
    sleep 10s
    localkubectl scale deploy cache-server --replicas=1 -n kubeflow
    localkubectl scale deploy ml-pipeline --replicas=1 -n kubeflow
    localkubectl scale deploy metadata-grpc-deployment --replicas=1 -n kubeflow
    localkubectl scale deploy mysql --replicas=1 -n kubeflow
    localkubectl scale deploy minio --replicas=1 -n kubeflow
    localkubectl scale deploy ml-pipeline-ui --replicas=1 -n kubeflow
    localkubectl scale deploy ml-pipeline-viewer-crd --replicas=1 -n kubeflow
    localkubectl scale deploy metadata-writer --replicas=1 -n kubeflow
    localkubectl scale deploy controller-manager --replicas=1 -n kubeflow
    localkubectl scale deploy workflow-controller --replicas=1 -n kubeflow
    localkubectl scale deploy ml-pipeline-visualizationserver --replicas=1 -n kubeflow
    localkubectl scale deploy ml-pipeline-scheduledworkflow --replicas=1 -n kubeflow
    localkubectl scale deploy ml-pipeline-persistenceagent --replicas=1 -n kubeflow
    localkubectl scale deploy metadata-envoy-deployment --replicas=1 -n kubeflow
    localkubectl scale deploy cache-deployer-deployment --replicas=1 -n kubeflow
    localkubectl scale deploy traefik --replicas=1 -n kube-system
    localkubectl scale deploy coredns --replicas=1 -n kube-system
    localkubectl scale deploy metrics-server --replicas=1 -n kube-system
    localkubectl scale deploy local-path-provisioner --replicas=1 -n kube-system
    sleep 30s
    localkubectl port-forward -n kubeflow svc/ml-pipeline-ui 8081:80
else
    echo No
fi