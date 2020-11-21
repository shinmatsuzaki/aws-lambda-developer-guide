#!/bin/bash
set -eo pipefail
FUNCTION=$(aws cloudformation describe-stack-resource --stack-name blank-java --logical-resource-id function --query 'StackResourceDetail.PhysicalResourceId' --output text)

while true; do
  aws lambda invoke --cli-binary-format raw-in-base64-out --function-name $FUNCTION --payload file://event.json out.json
  cat out.json | jq -r
  echo ""
  sleep 2
done
