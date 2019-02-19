#!/usr/bin/env bash
wget https://storage.googleapis.com/kubernetes-helm/helm-v2.12.3-linux-amd64.tar.gz
tar -xvzf ./helm-v2.12.3-linux-amd64.tar.gz
sudo cp linux-amd64/helm /usr/bin/
kubectl -n kube-system create serviceaccount tiller
kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller
TILLER_STATUS=""
while [ "$TILLER_STATUS" != "Running" ]; do
  TILLER_POD=$(kubectl -n kube-system get pod -l name=tiller | sed -n '2 p' | awk '{print $1;}')
  TILLER_STATUS=$(kubectl -n kube-system get pod $TILLER_POD -o jsonpath='{.status.phase}')
  sleep 5
  echo -ne "Waiting for tiller to be provisioned . . ."
done

