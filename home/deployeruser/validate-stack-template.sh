#!/usr/bin/env bash

. ./bashfunctions

requireVariable AWS_REGION

echo "Validating stack template"

aws --region ${AWS_REGION} cloudformation validate-template --template-body file://stack.yaml
