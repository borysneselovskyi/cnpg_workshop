##############################################################################################
## Script to modify security group - IP
##############################################################################################
# Set Default Region
export AWS_DEFAULT_REGION=eu-central-1
# or set it in the aws cli: --region eu-central-1

# Update a security group rule allowing your 
# current IPv4 I.P. to connect on port 22 (SSH)

# variables to identify sec group and sec group rule
SEC_GROUP_ID='sg-0eb34ca834d63fa1a'

# gets current date and prepares description for sec group rule
CURRENT_DATE=$(date +'%Y-%m-%d')
SEC_GROUP_RULE_DESCRIPTION="dynamic ip updated - ${CURRENT_DATE}"

# gets current I.P. and adds /32 for ipv4 cidr
CURRENT_IP=$1
NEW_IPV4_CIDR="${CURRENT_IP}"/32


aws ec2 authorize-security-group-ingress --group-id ${SEC_GROUP_ID} --protocol tcp --port 22-22 --cidr ${NEW_IPV4_CIDR}

aws ec2 authorize-security-group-ingress --group-id ${SEC_GROUP_ID} --protocol tcp --port 9001-9001 --cidr ${NEW_IPV4_CIDR}

aws ec2 authorize-security-group-ingress --group-id ${SEC_GROUP_ID} --protocol tcp --port 9090-9090 --cidr ${NEW_IPV4_CIDR}

aws ec2 authorize-security-group-ingress --group-id ${SEC_GROUP_ID} --protocol tcp --port 3000-3000 --cidr ${NEW_IPV4_CIDR}

# shows the sec group rule updated
#aws ec2 describe-security-group-rules --filter Name="security-group-rule-id",Values="${SEC_GROUP_RULE_ID}"
