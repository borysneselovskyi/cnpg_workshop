#!/bin/bash

CONFIG_FILE=config.yml
CONFIG_TEMPLATE=config.yml_template
TMP_FILE="/tmp/content-$$"

get_ip(){
	# Get IP Address from Amazon service
	curl --silent https://checkip.amazonaws.com
}

generate_rules_for_ip() {
	# Output ingress cluster_rules for tpaexec for all needed ports
  local ip=$1
  cat <<EOF
- cidr_ip: ${ip}
  from_port: 22
  proto: tcp
  to_port: 22
- cidr_ip: ${ip}
  from_port: 9001
  proto: tcp
  to_port: 9001
- cidr_ip: ${ip}
  from_port: 9090
  proto: tcp
  to_port: 9090
- cidr_ip: ${ip}
  from_port: 3000
  proto: tcp
  to_port: 3000
EOF
}

inject_cluster_rules(){
	# Find 'cluster_rules:' in the config template - add the lines
	content_file=$1
	awk -v file="$content_file" '
		/cluster_rules:/ {
			print
			while ((getline line < file) > 0) print line
			close(file)
			next
		}
		{ print }
  ' "$CONFIG_TEMPLATE"

}

generate_cluster_rules(){
	# Generate cluster rules for all IP addresses in the ENV IPS
	local ip_list=("$@")
	local content=""
	local first=1
	for ip in "${ip_list[@]}"; do
		# Add for each ip, separated by newline '\n'
		if [ $first -eq 1 ]; then
			content+="$(generate_rules_for_ip "$ip")"
			first=0
		else
			content+=$'\n'"$(generate_rules_for_ip "$ip")"
		fi
	done
	echo "$content"
}

action="own-ip"
[ $# -eq 1 ] && action="$1"

case $action in
	own-ip)
		# Get own public IP
		IPS=$(get_ip)
		;;
	netskope)
		# Use Netskope IPs (EDB VPN egress adressess)
		IPS=("162.10.0.0/17" "163.116.128.0/17" "31.186.239.0/24" "8.39.144.0/24" "8.36.116.0/24")
		;;
esac

generate_cluster_rules "${IPS[@]}" > $TMP_FILE
inject_cluster_rules $TMP_FILE > $CONFIG_FILE
rm $TMP_FILE


