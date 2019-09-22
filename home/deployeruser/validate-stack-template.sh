#!/usr/bin/env bash

. ./bashfunctions


export AWS_REGION=eu-west-1
echo "Validating stack template"

aws --region ${AWS_REGION} cloudformation validate-template --template-body file://stack.yaml
