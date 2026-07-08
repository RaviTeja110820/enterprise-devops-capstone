############################################################
# terraform.tfvars
#
# Variable values for the Development environment.
############################################################

# AWS Region
aws_region = "ap-south-2"

aws_account_id = "705557196379"

# Project
project_name = "enterprise-devops"

# Environment
environment = "dev"

# Networking
vpc_cidr = "10.0.0.0/16"

public_subnet_1 = "10.0.1.0/24"

public_subnet_2 = "10.0.2.0/24"

private_subnet_1 = "10.0.3.0/24"

private_subnet_2 = "10.0.4.0/24"

# Availability Zones
az1 = "ap-south-2a"

az2 = "ap-south-2b"

# EKS Cluster
cluster_name = "enterprise-eks"
