#!/bin/bash

set -e  # Exit immediately if any command exits with a non-zero status

# Get user input for AWS profile name
echo "Enter your AWS profile name: "
read AWS_PROFILE

# Get user input for AWS region
echo "Enter your AWS region (e.g., us-east-1): "
read AWS_REGION

# Configure AWS CLI with the provided credentials and profile
aws configure set region "${AWS_REGION}" --profile "${AWS_PROFILE}"

# List EC2 instances and extract instance IDs
instance_ids=$(aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId]' --output text --profile "${AWS_PROFILE}")

# Stop instances
if [ -n "$instance_ids" ]; then
  echo "Stopping instances: $instance_ids"
  aws ec2 stop-instances --instance-ids $instance_ids --profile "${AWS_PROFILE}"
else
  echo "No running instances found."
fi

# Wait for instances to stop (optional)
aws ec2 wait instance-stopped --instance-ids $instance_ids --profile "${AWS_PROFILE}"

# Terminate instances
if [ -n "$instance_ids" ]; then
  echo "Terminating instances: $instance_ids"
  aws ec2 terminate-instances --instance-ids $instance_ids --profile "${AWS_PROFILE}"
else
  echo "No instances to terminate."
fi
