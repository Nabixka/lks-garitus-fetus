# Subnet Group
resource "aws_db_subnet_group" "lks_rds_subnet_group" {
  name       = "lks-rds-subnet-group"
  subnet_ids = [aws_subnet.lks_pm_private_subnet_1a.id, aws_subnet.lks_pm_private_subnet_1b.id]

  tags = {
    Name = "lks-rds-subnet-group"
  }
}

# Instance
resource "aws_db_instance" "lks_project_management_cluster" {
  allocated_storage    = 10
  db_name              = "leantime_db"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t4.medium"
  username             = "admin"
  password             = "admin123"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.lks_rds_subnet_group
  vpc_security_group_ids = [ aws_security_group.lks_sg_database ]
}