#!/bin/bash

set -x
set -e

#!/bin/bash

# Get user input for AWS profile name
echo "Enter your AWS profile name: "
read AWS_PROFILE

# Get user input for AWS access key
echo "Enter your AWS access key: "
read AWS_ACCESS_KEY

# Get user input for AWS secret key
echo "Enter your AWS secret key: "
read AWS_SECRET_KEY

# Get user input for AWS region
echo "Enter your AWS region (e.g., us-east-1): "
read AWS_REGION

# Set the output format to JSON
AWS_OUTPUT_FORMAT="json"

# Display the entered information
echo "AWS Profile Name: $AWS_PROFILE"
echo "AWS Access Key: $AWS_ACCESS_KEY"
echo "AWS Secret Key: $AWS_SECRET_KEY"
echo "AWS Region: $AWS_REGION"
echo "AWS Output Format: $AWS_OUTPUT_FORMAT"

# Configure AWS CLI with the provided credentials and profile
aws configure set aws_access_key_id "${AWS_ACCESS_KEY}" --profile "${AWS_PROFILE}"
aws configure set aws_secret_access_key "${AWS_SECRET_KEY}" --profile "${AWS_PROFILE}"
aws configure set region "${AWS_REGION}" --profile "${AWS_PROFILE}"
aws configure set output "${AWS_OUTPUT_FORMAT}" --profile "${AWS_PROFILE}"

# Optionally, set the configured profile as the default
aws configure set default.profile "${AWS_PROFILE}"

echo "AWS CLI configuration completed for profile: ${AWS_PROFILE}"

# EC2 instance parameters
IMAGE_ID="ami-0a3c3a20c09d6f377"
INSTANCE_TYPE="t2.micro"
SECURITY_GROUP_ID="sg-03a5ffb228fe1bd98"
KEY_NAME="Amazon_Linux_KP"
INSTANCE_NAME="aws-linux-ws"
FORMATTED_DATE=$(date +'%d%m%y%H%M%S')

# Create EC2 instance
aws ec2 run-instances \
  --image-id "$IMAGE_ID" \
  --instance-type "$INSTANCE_TYPE" \
  --security-group-ids "$SECURITY_GROUP_ID" \
  --key-name "$KEY_NAME" \
  --tag-specifications 'ResourceType=instance,Tags=[{Key="Name",Value="$INSTANCE_NAME$FORMATTED_DATE"}]'
