############################################################
# ROOT OUTPUTS
#
# Outputs from child modules
############################################################

############################################################
# Project Information
############################################################

output "project_name" {

  value = var.project_name

}

output "environment" {

  value = var.environment

}

output "aws_region" {

  value = var.aws_region

}

############################################################
# Networking
############################################################

output "vpc_id" {

  value = module.vpc.vpc_id

}

output "public_subnet_1_id" {

  value = module.vpc.public_subnet_1_id

}

output "public_subnet_2_id" {

  value = module.vpc.public_subnet_2_id

}

output "private_subnet_1_id" {

  value = module.vpc.private_subnet_1_id

}

output "private_subnet_2_id" {

  value = module.vpc.private_subnet_2_id

}

output "nat_gateway_ip" {

  value = module.vpc.nat_eip

}

############################################################
# IAM Outputs
############################################################

output "eks_cluster_role_arn" {

  value = module.iam.eks_cluster_role_arn

}

output "node_group_role_arn" {

  value = module.iam.node_group_role_arn

}

output "node_group_role_name" {

  value = module.iam.node_group_role_name

}