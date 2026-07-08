############################################################
# main.tf
#
# Calls Terraform modules.
# Modules will be created in the next parts.
############################################################
############################################################
# Root Module
#
# Calls all child Terraform modules
############################################################

module "vpc" {

  source = "./vpc"

  project_name = var.project_name
  environment  = var.environment

  cluster_name = var.cluster_name

  vpc_cidr = var.vpc_cidr

  public_subnet_1  = var.public_subnet_1
  public_subnet_2  = var.public_subnet_2

  private_subnet_1 = var.private_subnet_1
  private_subnet_2 = var.private_subnet_2

  az1 = var.az1
  az2 = var.az2

}

############################################################
# IAM Module
############################################################

module "iam" {

  source = "./iam"

  project_name = var.project_name

  environment = var.environment

  cluster_name = var.cluster_name

  aws_region = var.aws_region

  aws_account_id = var.aws_account_id

}

# EKS Module (Will be completed in Part 4)
module "eks" {

  source = "./eks"

}

# CloudWatch Module (Will be completed later)
module "cloudwatch" {

  source = "./cloudwatch"

}
