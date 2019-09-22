#!/usr/bin/env bash

if [ ! -d "/home/deployeruser/.aws" ]; then
	mkdir -p /home/deployeruser/.aws
	cp /home/deployeruser/aws-template/config /home/deployeruser/.aws
	cat /home/deployeruser/aws-template/credentials | envsubst > /home/deployeruser/.aws/credentials
else
	echo "Already logged in to aws console."
fi

aws iam get-user
