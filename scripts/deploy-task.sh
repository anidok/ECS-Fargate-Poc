#!/usr/bin/env bash

set +x -e

AWS_REGION="us-east-1"
STACK_NAME="mywebapp-ecs-task"
STAGE="dev"
REPO_NAME="mywebap"
ALB_INSTALL="yes"

IS_PUBLIC_IP="ENABLED"  # required for default vpc
SUBNET_IDS="subnet-255ea12a,subnet-378ce418" #default vpc

TEMPLATE_FILE="cloudformation/mywebapp-ecs-task.yml"

# ECR_REPO_EXISTS=$(eval aws --region ${AWS_REGION} ecr describe-repositories --repository-names '${REPO_NAME}' &> /dev/null || echo 'not found')

# echo $ECR_REPO_EXISTS



stack_parameters="ALBInstall=$ALB_INSTALL SubnetIds=$SUBNET_IDS IsPublicIp=$IS_PUBLIC_IP"

aws cloudformation deploy --region $AWS_REGION --template-file $TEMPLATE_FILE \
    --no-fail-on-empty-changeset \
    --parameter-overrides $stack_parameters \
    --capabilities CAPABILITY_NAMED_IAM \
    --stack-name $STACK_NAME-$STAGE

# a=$(eval aws --region us-east-1 ecr describe-repositories --repository-names myweba1pp &> /dev/null || echo 'not found')
# echo $a
