#!/bin/bash


####################
# Author : Amiya Nayak
# Date : 10th March 2025
# Version : v1
#
# This Script will report the aws resource usage
#
# ##################


#AWS S3
#AWS EC2
#AWS Lambda
#AWS IAM

set -x
set -e
set -o pipefail 

#list s3 bucket
echo "Print list of s3 bucket"
aws s3 ls > resourceTracker

#list EC2 instances
echo "Print list of ec2 instances"
#aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'
aws ec2 describe-instances --query "Reservations[*].Instances[*].InstanceId" --output json > resourceTracker


#list lambda
echo "Print list of lambda functions"
aws lambda list-functions > resourceTracker

#list IAM users
echo "Print list of IAM users"
aws iam list-users > resourceTracker

