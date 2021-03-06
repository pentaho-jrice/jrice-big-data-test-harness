# *********************************************************************************
# Description: Deploy 
# Author:      Joe Rice
# Created:     03/07/2018
#
# Notes:
#    Script assumes that the following environment variables are set
#       export AWS_ACCESS_KEY=<Secret>
#       export AWS_SECRET_KEY=<Super_Top_Secret>
# *********************************************************************************

DIR="$(cd "$(dirname "$0")" && pwd)"

source $DIR/setenv.sh

PLAYBOOK_FILE=./deploy-admin-logging-services.yml
EC2_INVENTORY_FILE=./ec2-inventory/ec2.py
PLAYBOOK_VAR_ENV=prod
PLAYBOOK_VAR_DOMAIN_PREFIX=""
PLAYBOOK_VAR_DOMAIN_NAME=$BDTH_DOMAIN_NAME
STACK_FILE_DIR=../docker/logging
STACK_FILE_NAME=docker-compose.yml

cd $BDTH_ADMIN_PLAYBOOK_DIR

time ansible-playbook \
  -i $EC2_INVENTORY_FILE \
  -v \
  -u ubuntu \
  -e env=$PLAYBOOK_VAR_ENV \
  -e env_domain_prefix=$PLAYBOOK_VAR_DOMAIN_PREFIX \
  -e stack_file_dir=$STACK_FILE_DIR \
  -e stack_file_name=$STACK_FILE_NAME \
  --private-key $BDTH_AWS_KEY_FILE_PATH $PLAYBOOK_FILE
