# cloudformation-deployer

Package cloudformation stack in docker for deployment using a deployment management tool or build job


To add custom behavior, add pre-stack.sh, post-stack.sh and pre/post-delete-stack.sh scripts and place appropriate logic
there.

Typical behavior is assembling stack parameters, packaging lambdas and uploading to S3, running precondition tests,
running e2e-tests.

TODO:

Update usage instructions here.
