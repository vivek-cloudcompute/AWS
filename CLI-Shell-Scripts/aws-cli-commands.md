Here's a condensed AWS CLI Cheat Sheet based on the provided commands:

## AWS CLI Cheat Sheet

### CloudTrail - Logging and Auditing

#### List Trails
```bash
aws cloudtrail describe-trails
```

#### List S3 Buckets
```bash
aws s3 ls
```

#### Create a New Trail
```bash
aws cloudtrail create-subscription --name awslog --s3-new-bucket awslog2016
```

#### List Trail Names
```bash
aws cloudtrail describe-trails --output text | cut -f 8
```

#### Get Trail Status
```bash
aws cloudtrail get-trail-status --name awslog
```

#### Delete Trail
```bash
aws cloudtrail delete-trail --name awslog
```

#### Delete S3 Bucket of Trail
```bash
aws s3 rb s3://awslog2016 --force
```

#### Add Tags to a Trail
```bash
aws cloudtrail add-tags --resource-id awslog --tags-list "Key=log-type,Value=all"
```

#### List Tags of a Trail
```bash
aws cloudtrail list-tags --resource-id awslog
```

#### Remove Tag from a Trail
```bash
aws cloudtrail remove-tags --resource-id awslog --tags-list "Key=log-type,Value=all"
```

### IAM (Identity and Access Management)

#### List All Users
```bash
aws iam list-users
```

#### List Usernames
```bash
aws iam list-users --output text | cut -f 6
```

#### List Current User's Info
```bash
aws iam get-user
```

#### List Current User's Access Keys
```bash
aws iam list-access-keys
```

#### Create New User
```bash
aws iam create-user --user-name aws-admin2
```

#### Create Multiple Users from File
```bash
allUsers=$(cat ./user-names.txt)
for userName in $allUsers; do
    aws iam create-user --user-name $userName
done
```

#### Delete One User
```bash
aws iam delete-user --user-name aws-admin2
```

#### Delete All Users from File
```bash
allUsers=$(cat ./user-names.txt)
for userName in $allUsers; do
    aws iam delete-user --user-name $userName
done
```

#### List Account Password Policy
```bash
aws iam get-account-password-policy
```

#### Set Account Password Policy
```bash
aws iam update-account-password-policy --minimum-password-length 12 --require-symbols --require-numbers --require-uppercase-characters --require-lowercase-characters --allow-users-to-change-password
```

#### Delete Account Password Policy
```bash
aws iam delete-account-password-policy
```

#### List All Access Keys
```bash
aws iam list-access-keys
```

#### List Access Keys for User
```bash
aws iam list-access-keys --user-name aws-admin2
```

#### Create New Access Key
```bash
aws iam create-access-key --user-name aws-admin2 --output text | tee aws-admin2.txt
```

#### List Last Access Time for Access Key
```bash
aws iam get-access-key-last-used --access-key-id AKIAINA6AJZY4EXAMPLE
```

#### Deactivate Access Key
```bash
aws iam update-access-key --access-key-id AKIAI44QH8DHBEXAMPLE --status Inactive --user-name aws-admin2
```

#### Delete Access Key
```bash
aws iam delete-access-key --access-key-id AKIAI44QH8DHBEXAMPLE --user-name aws-admin2
```

#### List All Groups
```bash
aws iam list-groups
```

#### Create Group
```bash
aws iam create-group --group-name FullAdmins
```

#### Delete Group
```bash
aws iam delete-group --group-name FullAdmins
```

#### List All Policies
```bash
aws iam list-policies
```

#### Get Specific Policy
```bash
aws iam get-policy --policy-arn <value>
```

#### List Entities for Policy
```bash
aws iam list-entities-for-policy --policy-arn <value>
```

#### List Attached Group Policies
```bash
aws iam list-attached-group-policies --group-name FullAdmins
```

#### Attach Policy to Group
```bash
aws iam attach-group-policy --group-name FullAdmins --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
```

#### Add User to Group
```bash
aws iam add-user-to-group --group-name FullAdmins --user-name aws-admin2
```

#### Get Group Info
```bash
aws iam get-group --group-name FullAdmins
```

#### List Groups for User
```bash
aws iam list-groups-for-user --user-name aws-admin2
```

#### Remove User from Group
```bash
aws iam remove-user-from-group --group-name FullAdmins --user-name aws-admin2
```

#### Detach Policy from Group
```bash
aws iam detach-group-policy --group-name Full

Admins --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
```

#### Delete Group
```bash
aws iam delete-group --group-name FullAdmins
```

### EC2 (Elastic Compute Cloud)

#### List Key Pairs
```bash
aws ec2 describe-key-pairs
```

#### Create Key Pair
```bash
aws ec2 create-key-pair --key-name <value>
```

#### Import Existing Key Pair
```bash
aws ec2 import-key-pair --key-name keyname_test --public-key-material file:///home/apollo/id_rsa.pub
```

#### Delete Key Pair
```bash
aws ec2 delete-key-pair --key-name <value>
```

#### List Security Groups
```bash
aws ec2 describe-security-groups
```

#### Create Security Group
```bash
aws ec2 create-security-group --vpc-id vpc-1a2b3c4d --group-name web-access --description "web access"
```

#### Describe Security Group Details
```bash
aws ec2 describe-security-groups --group-id sg-0000000
```

#### Authorize Ingress Rule (Open Port 80 for Everyone)
```bash
aws ec2 authorize-security-group-ingress --group-id sg-0000000 --protocol tcp --port 80 --cidr 0.0.0.0/24
```

#### Get Public IP
```bash
my_ip=$(dig +short myip.opendns.com @resolver1.opendns.com)
echo $my_ip
```

#### Authorize Ingress Rule (Open Port 22 for Specific IP)
```bash
aws ec2 authorize-security-group-ingress --group-id sg-0000000 --protocol tcp --port 80 --cidr $my_ip/24
```

#### Revoke Ingress Rule (Remove Firewall Rule)
```bash
aws ec2 revoke-security-group-ingress --group-id sg-0000000 --protocol tcp --port 80 --cidr 0.0.0.0/24
```

#### Delete Security Group
```bash
aws ec2 delete-security-group --group-id sg-00000000
```

#### Describe Instances
```bash
aws ec2 describe-instances
```

#### Run New Instance
```bash
aws ec2 run-instances --image-id ami-f0e7d19a --instance-type t2.micro --security-group-ids sg-00000000 --dry-run
```

#### Terminate Instance
```bash
aws ec2 terminate-instances --instance-ids <instance_id>
```

#### Describe Instance Status (All Instances)
```bash
aws ec2 describe-instance-status
```

#### Describe Instance Status (Specific Instance)
```bash
aws ec2 describe-instance-status --instance-ids <instance_id>
```

#### Describe Tags of an Instance
```bash
aws ec2 describe-tags
```

#### Add Tag to an Instance
```bash
aws ec2 create-tags --resources "ami-1a2b3c4d" --tags Key=name,Value=debian
```

#### Delete Tag on an Instance
```bash
aws ec2 delete-tags --resources "ami-1a2b3c4d" --tags Key=Name,Value=
```

### CloudWatch (Logs)

#### Log Groups

##### Create Log Group
```bash
aws logs create-log-group --log-group-name "DefaultGroup"
```

##### List Log Groups
```bash
aws logs describe-log-groups
```

##### List Log Groups with Prefix
```bash
aws logs describe-log-groups --log-group-name-prefix "Default"
```

##### Delete Log Group
```bash
aws logs delete-log-group --log-group-name "DefaultGroup"
```

#### Log Streams

##### Create Log Stream
```bash
aws logs create-log-stream --log-group-name "DefaultGroup" --log-stream-name "syslog"
```

##### List Log Streams
```bash
aws logs describe-log-streams --log-group-name "syslog"
```

##### List Log Streams with Prefix
```bash
aws logs describe-log-streams --log-stream-name-prefix "syslog"
```

##### Delete Log Stream
```bash
aws logs delete-log-stream --log-group-name "DefaultGroup" --log-stream-name "Default Stream"
```

