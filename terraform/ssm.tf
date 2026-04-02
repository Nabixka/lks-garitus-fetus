data "aws_ssm_parameters_by_path" "password" {
  path = "/lks/db/password"
  types = SecureString
  values = ""
}

data "aws_ssm_parameters_by_path" "name" {
  path = "/lks/db/name"
  types = String
  values = ""
}

data "aws_ssm_parameters_by_path" "host" {
  path = "/lks/db/host"
  types = String
  values = ""
}

data "aws_ssm_parameters_by_path" "port" {
  path = "/lks/db/port"
  types = String
  values = ""
}

data "aws_ssm_parameters_by_path" "username" {
  path = "/lks/db/username"
  types = SecureString
  values = ""
}