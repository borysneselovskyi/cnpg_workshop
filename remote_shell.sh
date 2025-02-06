#!/bin/bash

working_dir="/git/k8s_workshop/debian_env"

servers=`awk '/vm/ {print $2}' ${working_dir}/ssh_config`

for server in $servers
do
echo ${server}
scp -F ${working_dir}/ssh_config ${working_dir}/cnp-demo.tar ${server}:/tmp 
ssh -F ${working_dir}/ssh_config ${server} "chmod 777 /tmp/cnp-demo.tar"
ssh -F ${working_dir}/ssh_config ${server} "sudo mkdir -p /home/workshop/workshop/bin"
ssh -F ${working_dir}/ssh_config ${server} "sudo chown -R workshop:docker /home/workshop/workshop"
ssh -F ${working_dir}/ssh_config ${server} "sudo tar xvf /tmp/cnp-demo.tar -C /home/workshop/workshop"
done
