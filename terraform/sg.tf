# SG ALB
resource "aws_security_group" "lks_sg_alb" {
  name        = "lks-sg-alb"
  description = "SG For ALB Open Port 8080 & 80"
  vpc_id      = aws_vpc.lks_pm_vpc.id

  tags = {
    Name = "lks-sg-alb"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_8080_alb" {
  security_group_id = aws_security_group.lks_sg_alb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080
}

resource "aws_vpc_security_group_ingress_rule" "allow_80_alb" {
  security_group_id = aws_security_group.lks_sg_alb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_sg_alb" {
  security_group_id = aws_security_group.lks_sg_alb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}

# SG APP
resource "aws_security_group" "lks_sg_app" {
  name        = "lks-sg-app"
  description = "A security group for instance applications, allowing inbound traffic only from the Application Load Balancer (ALB)"
  vpc_id      = aws_vpc.lks_pm_vpc.id

  tags = {
    Name = "lks-sg-app"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_8080_app" {
  security_group_id = aws_security_group.lks_sg_app.id
  referenced_security_group_id = aws_security_group.lks_sg_alb.id
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080
}


resource "aws_vpc_security_group_egress_rule" "allow_all_sg_app" {
  security_group_id = aws_security_group.lks_sg_app.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}

# SG Database
resource "aws_security_group" "lks_sg_database" {
  name        = "lks-sg-database"
  description = "SG to connect to the Database and File System From Application"
  vpc_id      = aws_vpc.lks_pm_vpc.id

  tags = {
    Name = "lks-sg-database"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_3306" {
  security_group_id = aws_security_group.lks_sg_database.id
  referenced_security_group_id = aws_security_group.lks_sg_app.id
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}

resource "aws_vpc_security_group_ingress_rule" "allow_2049" {
  security_group_id = aws_security_group.lks_sg_database.id
  referenced_security_group_id = aws_security_group.lks_sg_app.id
  from_port         = 2049
  ip_protocol       = "tcp"
  to_port           = 2049
}


resource "aws_vpc_security_group_egress_rule" "allow_all_sg_database" {
  security_group_id = aws_security_group.lks_sg_database.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}