#!/usr/bin/env bash
sudo rm /etc/kubernetes/pki/ca.crt
sudo rm /etc/kubernetes/bootstrap-kubelet.conf
sudo rm /etc/kubernetes/kubelet.conf
sudo pkill kubelet
