############################################################
# Secrets Module Variables
############################################################

############################################################
# Project Name
############################################################

variable "project_name" {

  description = "Project Name"

  type = string

}

############################################################
# Environment
############################################################

variable "environment" {

  description = "Deployment Environment"

  type = string

}

############################################################
# Database Username
############################################################

variable "db_username" {

  description = "Database Username"

  type = string

}

############################################################
# Database Password
############################################################

variable "db_password" {

  description = "Database Password"

  type = string

  sensitive = true

}

############################################################
# Additional Tags
############################################################

variable "additional_tags" {

  type = map(string)

  default = {}

}