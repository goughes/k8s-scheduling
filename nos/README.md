## Installation

```
# cert manager prerequisite
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.14.3/cert-manager.yaml

# gpu-operator prerequisite
helm install --wait --generate-name -n gpu-operator --create-namespace nvidia/gpu-operator --version v22.9.0 --set driver.enabled=true --set migManager.enabled=false --set mig.strategy=mixed --set toolkit.enabled=true

# nos
helm install nebuly-nos oci://ghcr.io/nebuly-ai/helm-charts/nos --version 0.1.2 --namespace nebuly-nos --values values.yaml
```