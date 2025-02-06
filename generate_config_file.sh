#!/bin/bash

# definde working diirectory:
WORK_DIR="/git/k8s_workshop/debian_env"

# gets current I.P. and adds /32 for ipv4 cidr
CURRENT_IP=$(curl --silent https://checkip.amazonaws.com)

sed -e 's/#IP#/'${CURRENT_IP}'/' ${WORK_DIR}/config.yml_template > ${WORK_DIR}/config.yml
