#!/bin/bash
kubectl delete eq --all --all-namespaces
kubectl delete crd appgroups.appgroup.diktyo.x-k8s.io elasticquotas.scheduling.x-k8s.io networktopologies.networktopology.diktyo.x-k8s.io noderesourcetopologies.topology.node.k8s.io podgroups.scheduling.x-k8s.io

helm -n scheduler-plugins uninstall scheduler-plugins
kubectl delete ns scheduler-plugins
sleep 1
helm install scheduler-plugins ~/scheduler-plugins/manifests/install/charts/as-a-second-scheduler --create-namespace --namespace scheduler-plugins
