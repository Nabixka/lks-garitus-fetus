resource "aws_efs_file_system" "lks_project_management" {
  creation_token = "my-product"

  tags = {
    Name = "MyProduct"
  }
}