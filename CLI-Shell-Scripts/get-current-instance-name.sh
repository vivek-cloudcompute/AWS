#!/bin/bash

set -e  # Exit immediately if any command exits with a non-zero status

# Get the instance ID of the current EC2 instance
current_instance_id=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

# Get the instance name tag using the instance ID
instance_name=$(aws ec2 describe-instances --instance-ids "$current_instance_id" --query "Reservations[0].Instances[0].Tags[?Key=='Name'].Value" --output text)

# Display the instance name
echo "Current instance name: $instance_name"
