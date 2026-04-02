resource "aws_ssm_parameter" "host" {
  name  = "/lks/db/host"
  type  = "String"
  description = "Database host/endpoint"
  value = aws_db_instance.lks_project_management_cluster.endpoint
}

resource "aws_ssm_parameter" "port" {
  name  = "/lks/db/port"
  type  = "String"
  description = "Database port"
  value = tostring(aws_db_instance.lks_project_management_cluster.port)
}

resource "aws_ssm_parameter" "name" {
  name  = "/lks/db/name"
  type  = "String"
  description = "Initial/default database name"
  value = aws_db_instance.lks_project_management_cluster.db_name
}

resource "aws_ssm_parameter" "username" {
  name  = "/lks/db/username"
  type  = "SecureString"
  description = "Database username"
  value = aws_db_instance.lks_project_management_cluster.username
}

resource "aws_ssm_parameter" "password" {
  name  = "/lks/db/password"
  type  = "SecureString"
  description = "Database password"
  value = aws_db_instance.lks_project_management_cluster.password
}