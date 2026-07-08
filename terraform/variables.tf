############################################################
# variables.tf
#
# Input variables for the project.
############################################################

############################################################
# AWS Account ID
############################################################
variable "aws_account_id" {

  description = "AWS Account ID"

  type = string

}

# AWS Region
variable "aws_region" {

  description = "AWS Region"

  type = string

}

# Project Name
variable "project_name" {

  description = "Project Name"

  type = string

}

# Environment
variable "environment" {

  description = "Deployment Environment"

  type = string

}

# VPC CIDR Block
variable "vpc_cidr" {

  description = "CIDR block for VPC"

  type = string

}

# Public Subnet 1
variable "public_subnet_1" {

  type = string

}

# Public Subnet 2
variable "public_subnet_2" {

  type = string

}

# Private Subnet 1
variable "private_subnet_1" {

  type = string

}

# Private Subnet 2
variable "private_subnet_2" {

  type = string

}

# Availability Zone 1
variable "az1" {

  type = string

}

# Availability Zone 2
variable "az2" {

  type = string

}

# EKS Cluster Name
variable "cluster_name" {

  type = string

}
