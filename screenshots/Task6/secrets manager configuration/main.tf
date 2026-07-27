############################################################
# Secrets Manager
############################################################

locals {

  common_tags = {

    Project     = var.project_name

    Environment = var.environment

    ManagedBy   = "Terraform"

  }

}

############################################################
# Secrets Manager Secret
############################################################

resource "aws_secretsmanager_secret" "database" {

  name = "${var.project_name}-${var.environment}-db-secret"

  description = "Database Credentials"

  recovery_window_in_days = 7

  tags = merge(

    local.common_tags,

    var.additional_tags

  )

}

############################################################
# Secret Value
############################################################

resource "aws_secretsmanager_secret_version" "database" {

  secret_id = aws_secretsmanager_secret.database.id

  secret_string = jsonencode({

    username = var.db_username

    password = var.db_password

  })

}