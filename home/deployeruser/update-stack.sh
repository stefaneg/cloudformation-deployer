#!/usr/bin/env bash

. ./bashfunctions

requireVariable STACK_NAME
requireVariable AWS_REGION

if [ ! -z "${STACK_PARAMETERS}" ]; then
	export CLI_STACK_PARAMS="--parameters ${STACK_PARAMETERS}"
fi


echo "Updating stack ${STACK_NAME}"
if aws --region ${AWS_REGION} cloudformation update-stack --stack-name ${STACK_NAME} --template-body file://stack.yaml  --capabilities CAPABILITY_IAM ${CLI_STACK_PARAMS}; then
	echo "Waiting for stack update to complete ..."

	aws cloudformation wait stack-update-complete \
	    --region ${AWS_REGION} \
	    --stack-name ${STACK_NAME}

	echo "${STACK_NAME} updated"

fi


