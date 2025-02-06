
# Setup workshop environment for testing CloudNativePG

By following the steps described below, it is possible to provision a virtual machine in AWS that is fully prepared to perform the hands-on in a Kubernetes workshop. The environment is provisioned using the tpaexec tool. 
Provisioning is tested using tpaexec 23.35.0. 
The hands-on is based on sources from Sergio Romero's Github repository:
https://github.com/sergioenterprisedb/cnp-demo

What will be installed:
- A virtual machine in the AWS cloud
- Docker
- ShellInBox (for terminal connection via browser)
- k3d
- kubectl
- helm
- user workshop is created and configured

## Setup the environment

- install tpaexec (tested with the version 23.25.0)
- install aws cli
- install git
- install curl

Create a working directory, for example:

```mkdir -p /tpa/k8s_workhop```

Go to the created directory and clone this repository:

```
cd /tpa/k8s_workhop
git clone git@github.com:borysneselovskyi/cnpg_workshop.git
```

Change directory to cnpg_workshop
```
cd /tpa/k8s_workhop/cnpg_workshop
```

Create the configuration file config.yml. This step will add the public ip address of the machine to enable the security rules for inbound data traffic between the machine and AWS:

Run the script:
```
./set_public_ip.sh
```
In the file config.yml change the Name:
```
cluster_tags:
  Owner: training (Borys Neselovskyi)
```
## Provision the vm in AWS
Configure tpaexec:
In the cnpg_workshop directory run the command:
```
tpaexec relink .
```
_**Make sure you can connect to AWS from this machine!!**_

Run provisioning of the vm:
```
tpaexec provisioning .
```
Deploy and configure the software in the vm:
```
tpaexec deploy .
```

Prepare the workshop environment on the provisioned vm, run the script:
```
./remote_shell.sh
```

Connect to the vm:
- obtain the public ip address of the vm in the file ssh_comfig
- run in the browser the url: https://<vm public ip>
- connect with the user **workshop** and password **workshop**

## Run the demo
Follow the steps from the pdf file below:
[CNPG_ Workshop_Hands-on.pdf](cnpg_workshop/CNPG_ Workshop_Hands-on.pdf)
