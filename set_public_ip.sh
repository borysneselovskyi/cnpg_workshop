#!/bin/bash
ip=`curl -4 ifconfig.co`
sed -e 's/#IP#/'${ip}'/' config.yml_template config.yml
