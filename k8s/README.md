# Kubernetes Based Deployments

This folder hosts all kubernetes manifests for different environments.
The [core manifests](base/core) are ones common to all other environments
and [extension manifests](base/extensions) are environment specific. 

We use `kustomize` to keep the entire code base configurable according to the environment requirements. 

## Local Dev Environment

This setup uses [k3d](https://k3d.io/) clusters.
The configuration for the cluster is available in [this folder](local/k3d).
From this location, the following command must be executed to start the dev cluster.
Before that, k3d binary must be installed on the development machine from [here](https://k3d.io/v5.6.3/#install-script).

```shell
 k3d cluster create --config config.yaml
```

Once this is created successful, we can then apply all manifests that are specific for the local development setup. 

```shell
# From base directory of the repo.
cd k8s/overlays/dev
kubectl apply -k .
```

> [!NOTE]
> The above command will apply all manifests and additionally also creates an Ingress manifest which is just for dev environment.
> This is necessary to ensure the UI and xpanse APIs are reachable from the dev host.

After this, the UI and API are accessible from the below URLs.
UI - http://localhost:3000/app/login
API - http://localhost:8080/swagger-ui/index.html

## Demo environment Deployment

Ensure the environment has a Kubernetes cluster installed and the kube context file available.
Then apply the manifests as below.

```shell
# From base directory of the repo.
cd k8s/overlays/demo
kubectl apply -k .
```
