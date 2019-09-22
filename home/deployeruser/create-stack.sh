#!/usr/bin/env bash

. ./bashfunctions

requireVariable STACK_NAME

export AWS_REGION=eu-west-1
echo "Creating stack...${STACK_NAME}"

if [ ! -z "${STACK_PARAMETERS}" ]; then
	export CLI_STACK_PARAMS="--parameters ${STACK_PARAMETERS}"
fi

aws --region ${AWS_REGION} cloudformation create-stack --stack-name ${STACK_NAME} --template-body file://stack.yaml  ${CLI_STACK_PARAMS} --capabilities CAPABILITY_IAM

echo "Waiting for stack ${STACK_NAME} to be created ..."
aws cloudformation wait stack-create-complete \
    --region ${AWS_REGION} \
    --stack-name ${STACK_NAME}

echo "${STACK_NAME} created and open for business."
