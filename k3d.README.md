# Setup Instructions

# Set up localhost
Edit /etc/hosts with
```
127.0.0.1 fast-flux.local
127.0.0.1 k3d-registry
```

Build cluster

```
k3d registry create registry --port 58154
k3d cluster create fast-flux --registry-use k3d-registry:58154 --api-port 6550 -p "8081:80@loadbalancer" --agents 2
export KUBECONFIG="$(k3d kubeconfig write fast-flux)"
```

Build and publish docker images:

```
docker build -t fast-flux .
docker tag fast-flux k3d-registry:58154/fast-flux
docker push k3d-registry:58154/fast-flux
pushd e2e_tests
docker build -t fast-flux-e2e .
docker tag fast-flux-e2e k3d-registry:58154/fast-flux-e2e
docker push k3d-registry:58154/fast-flux-e2e
popd
```


Helm install
Debug:
```
helm install --dry-run --debug fast-flux .
```

For real
```
helm install fast-flux .
```

Check status
```
kubectl get pods
```

Check the app
```
curl http://fast-flux.local:8081
```


Run the tests
```
helm test fast-flux
```


Get meta-info
```
kubectl describe pod fast-flux-<number from kubectl get pods>
```
