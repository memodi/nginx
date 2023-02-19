#!/usr/bin/env bash

N_PROJECTS=$1

server_ns=test
client_ns_prefix="test-"

echo "==> Deploying nginx server in project ${server_ns}"
oc new-project test
oc apply -f nginx-deployment.yaml -n ${server_ns}

for project in $(seq 1 $N_PROJECTS)
do
  client_ns=${client_ns_prefix}${project}
  echo "===> configuring project ${client_ns}"
  oc new-project ${client_ns}
  oc apply -f ./configs/web-client$project.yaml -n ${client_ns}
done 
