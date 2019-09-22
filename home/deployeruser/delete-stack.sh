#!/usr/bin/env bash

. ./bashfunctions

set -e

export STACK_NAME=$1

if test -x "./pre-delete-stack.sh"; then
	echo "Pre delete stack script found, executing"
	. ./pre-delete-stack.sh $@
fi


requireVariable STACK_NAME

aws --region eu-west-1 cloudformation delete-stack --stack-name ${STACK_NAME}

echo ${STACK_NAME} deleted
