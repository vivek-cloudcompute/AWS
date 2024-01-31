#!/bin/bash

# Get user input for AWS profile name
echo "Enter your AWS profile name: "
read AWS_PROFILE

# Get user input for AWS region
echo "Enter your AWS region (e.g., us-east-1): "
read AWS_REGION

# Configure AWS CLI with the provided profile and region
aws configure set profile.${AWS_PROFILE}.region ${AWS_REGION}
aws configure set profile.${AWS_PROFILE}.output json

echo "AWS CLI configured with profile: ${AWS_PROFILE}, region: ${AWS_REGION}"

# Get a list of running instance IDs
instance_ids=$(aws ec2 describe-instances --profile ${AWS_PROFILE} --query 'Reservations[*].Instances[*].InstanceId' --output text --filters Name=instance-state-name,Values=running)

# Check if there are running instances
if [ -z "${instance_ids}" ]; then
  echo "No running instances found."
else
  echo "Running instances: ${instance_ids}"

  # Stop each running instance
  for instance_id in ${instance_ids}; do
    echo "Stopping instance: ${instance_id}"
    aws ec2 stop-instances --profile ${AWS_PROFILE} --instance-ids ${instance_id}
  done

  echo "All running instances stopped."
fi
