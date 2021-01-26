# Local Kubeflow
This setup does the following things.

- [x] Creates a kubernetes cluster using k3s.
- [x] Uses docker for container management.
- [x] Installs kubeflow pipelines.

This setup can be used for local development and/or standalone integration tests.

## Dependencies
- [x] kubectl
- [x] docker

Please make sure that the above dependencies are installed before installing this local setup.

## VERY IMPORTANT NOTE
1. While running any `kubectl` command make sure you are pointing to the correct cluster. Local cluster config 
should be present at `~/.kube/config_local` and you can use this in your `kubectl` commands. The Best way to insure this is to create an alias in your `.bashrc` or `.zshrc` files.
   ```
   alias localkubectl="kubectl --kubeconfig $HOME/.kube/config_local"
   ```

## Install local setup
Run the following script to install the local setup. You only need to do this once.
```
local_kubeflow$ ./install.sh
```

## Start local setup
```
local_kubeflow$ ./start.sh
```
You can access the kubeflow pipeline here - `http://localhost:8081`

## Stop local setup
```
local_kubeflow$ ./stop.sh
```

## Uninstall local kubeflow
Running the following script will remove everything related to this local setup. EVERYTHING!!
```
local_kubeflow$ ./nuke.sh
```

## Useful commands
```
localkubectl get pods -n kubeflow
localkubectl top node
localkubectl cluster-info
localkubectl port-forward -n kubeflow svc/ml-pipeline-ui 8081:80
localkubectl describe pv
localkubectl get deployments --all-namespaces
systemctl stop k3s
systemctl start k3s
systemctl status k3s
```
[Cheatsheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)

## References
1. https://www.kubeflow.org/docs/pipelines/installation/localcluster-deployment/#deploying-kubeflow-pipelines
2. https://rancher.com/docs/k3s/latest/en/installation/uninstall/
3. https://rancher.com/docs/k3s/latest/en/advanced/#using-docker-as-the-container-runtime
