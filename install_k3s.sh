#!/bin/sh

alias localkubectl="kubectl --kubeconfig $HOME/.kube/config_local"

curl -sfL https://get.k3s.io | sh -s - --docker
sudo cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/config_local
sudo chown $USER $HOME/.kube/config_local
chmod 644 $HOME/.kube/config_local
echo "done!!"
echo "Running the following command to verify if the cluster was created successfully."
echo "-------------------------------------------------"
echo "localkubectl get node"
echo "-------------------------------------------------"
echo "It should show you an output like this"
echo "-------------------------------------------------"
echo "NAME    STATUS   ROLES                  AGE   VERSION
sumit   Ready    control-plane,master   44h   v1.20.0+k3s2"
echo "-------------------------------------------------"
sleep 10s
localkubectl get node