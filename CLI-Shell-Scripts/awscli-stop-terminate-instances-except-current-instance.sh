#!/bin/bash

set -e  # Exit immediately if any command exits with a non-zero status

# Get user input for AWS profile name
echo "Enter your AWS profile name: "
read AWS_PROFILE

# Get user input for AWS region
echo "Enter your AWS region (e.g., us-east-1): "
read AWS_REGION

# Get the instance ID of the current EC2 instance
current_instance_id=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

# Configure AWS CLI with the provided credentials and profile
aws configure set region "${AWS_REGION}" --profile "${AWS_PROFILE}"

# List all EC2 instances except the current one and extract instance IDs
instance_ids=$(aws ec2 describe-instances --query "Reservations[*].Instances[?InstanceId != '${current_instance_id}'].InstanceId" --output text --profile "${AWS_PROFILE}")

# Stop instances
if [ -n "$instance_ids" ]; then
  echo "Stopping instances: $instance_ids"
  aws ec2 stop-instances --instance-ids $instance_ids --profile "${AWS_PROFILE}"
else
  echo "No other running instances found."
fi

# Wait for instances to stop (optional)
aws ec2 wait instance-stopped --instance-ids $instance_ids --profile "${AWS_PROFILE}"

# Terminate instances
if [ -n "$instance_ids" ]; then
  echo "Terminating instances: $instance_ids"
  aws ec2 terminate-instances --instance-ids $instance_ids --profile "${AWS_PROFILE}"
else
  echo "No other instances to terminate."
fi
