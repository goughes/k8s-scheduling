#!/bin/bash
kubectl delete ns quota1
kubectl delete ns quota2

kubectl create ns quota1
kubectl create ns quota2
cat <<EOF | kubectl apply -f -
apiVersion: scheduling.x-k8s.io/v1alpha1
kind: ElasticQuota
metadata:
  name: quota1
  namespace: quota1
spec:
  max:
    cpu: 6
  min:
    cpu: 4
EOF
cat <<EOF | kubectl apply -f -
apiVersion: scheduling.x-k8s.io/v1alpha1
kind: ElasticQuota
metadata:
  name: quota2
  namespace: quota2
spec:
  max:
    cpu: 6
  min:
    cpu: 4
EOF
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
  namespace: quota1
  labels:
    app: nginx
spec:
  replicas: 4
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      name: nginx
      labels:
        app: nginx
    spec:
      schedulerName: scheduler-plugins-scheduler
      containers:
      - name: nginx
        image: nginx
        resources:
          limits:
            cpu: 2
          requests:
            cpu: 2
EOF
sleep 2
kubectl get pods -n quota1
sleep 2
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
  namespace: quota2
  labels:
    app: nginx
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      name: nginx
      labels:
        app: nginx
    spec:
      schedulerName: scheduler-plugins-scheduler
      containers:
      - name: nginx
        image: nginx
        resources:
          limits:
            cpu: 2
          requests:
            cpu: 2
EOF
sleep 2
kubectl get pods -n quota1
kubectl get pods -n quota2
