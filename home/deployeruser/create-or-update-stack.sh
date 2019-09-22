#!/usr/bin/env bash

echo "Create or update stack"

. ./bashfunctions

if [ -f "./stack_parameters.sh" ]; then
	echo "Setting stack parameters"
	. ./stack_parameters.sh $@
fi

export THISDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

export STACK_NAME=$1

requireVariable STACK_NAME

if test -x "./pre-stack.sh"; then
	echo "Pre stack script found, executing"
	. ./pre-stack.sh
fi

echo "Creating or updating cloudformation stack ${STACK_NAME}"

aws cloudformation describe-stacks --region eu-west-1 --stack-name ${STACK_NAME} > /dev/null 2>&1

if [ $? = 0 ]; then
	echo "Stack ${STACK_NAME} exists, updating"
	${THISDIR}/update-stack.sh $@
else
	echo "Stack ${STACK_NAME} does not exist, creating"
	${THISDIR}/create-stack.sh $@

fi

if test -x "./post-stack.sh"; then
	echo "post stack script found, executing"
	. ./post-stack.sh
fi

set +e
