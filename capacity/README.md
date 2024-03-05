## Installation

```
# clone scheduler plugins repo
git clone https://github.com/kubernetes-sigs/scheduler-plugins.git

cd scheduler-plugins/manifests/install/charts/

git checkout release-1.26

helm install scheduler-plugins as-a-second-scheduler/ --create-namespace --namespace scheduler-plugins
```
