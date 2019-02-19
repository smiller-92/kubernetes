#!/usr/bin/env bash

programname=$0
nodename=$1
if [ ${#@} == 0 ]; then
    echo "usage: $programname [node-name]"
    echo " This will REMOVE the node from the cluster, "
    echo " PLEASE BE CAREFUL WITH IT."
    echo " This script presumes that the user has public key access to the nodes."
    exit 1
fi

node_ip=$(kubectl get nodes -o wide | grep $nodename | awk '{print $6}')

echo $node_ip


kubectl drain $nodename --delete-local-data --force --ignore-daemonsets
sleep 2
kubectl delete node $nodename
scp ./clean_up.sh $node_ip:
ssh -t $node_ip "./clean_up.sh"

echo "$nodename is now not part of the cluster"

