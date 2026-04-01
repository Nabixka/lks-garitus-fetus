# VPC
resource "aws_vpc" "lks_pm_vpc" {
  cidr_block       = "10.100.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "lks-pm-vpc"
  }
}

# Subnet
resource "aws_subnet" "lks_pm_public_subnet_1a" {
  vpc_id     = aws_vpc.lks_pm_vpc.id
  availability_zone = "us-east-1a"
  cidr_block = "10.100.0.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "lks-pm-public-subnet-1a"
  }
}

resource "aws_subnet" "lks_pm_public_subnet_1b" {
  vpc_id     = aws_vpc.lks_pm_vpc.id
  availability_zone = "us-east-1b"
  cidr_block = "10.100.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "lks-pm-public-subnet-1b"
  }
}

resource "aws_subnet" "lks_pm_private_subnet_1a" {
  vpc_id     = aws_vpc.lks_pm_vpc.id
  availability_zone = "us-east-1a"
  cidr_block = "10.100.10.0/24"

  tags = {
    Name = "lks-pm-private-subnet-1a"
  }
}

resource "aws_subnet" "lks_pm_private_subnet_1b" {
  vpc_id     = aws_vpc.lks_pm_vpc.id
  availability_zone = "us-east-1b"
  cidr_block = "10.100.11.0/24"

  tags = {
    Name = "lks-pm-private-subnet-1b"
  }
}

# EIP
resource "aws_eip" "lks_nat_eip" {
  domain = "vpc"
}

# IGW & NAT
resource "aws_internet_gateway" "lks_pm_igw" {
  vpc_id = aws_vpc.lks_pm_vpc.id

  tags = {
    Name = "lks-pm-igw"
  }
}

resource "aws_nat_gateway" "lks_pm_natgw" {
  allocation_id = aws_eip.lks_nat_eip.id
  subnet_id     = aws_subnet.lks_pm_public_subnet_1a.id

  tags = {
    Name = "lks-pm-natgw"
  }

  depends_on = [aws_internet_gateway.lks_pm_igw]
}

# RTB
resource "aws_route_table" "lks_pm_public_rt" {
  vpc_id = aws_vpc.lks_pm_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lks_pm_igw.id
  }

  tags = {
    Name = "lks-pm-public-rt"
  }
}

resource "aws_route_table" "lks_pm_private_rt" {
  vpc_id = aws_vpc.lks_pm_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.lks_pm_natgw.id
  }

  tags = {
    Name = "lks-pm-private-rt"
  }
}

resource "aws_route_table_association" "lks_pm_public_1a_association" {
  subnet_id      = aws_subnet.lks_pm_public_subnet_1a.id
  route_table_id = aws_route_table.lks_pm_public_rt.id
}

resource "aws_route_table_association" "lks_pm_public_1b_association" {
  subnet_id      = aws_subnet.lks_pm_public_subnet_1b.id
  route_table_id = aws_route_table.lks_pm_public_rt.id
}

resource "aws_route_table_association" "lks_pm_private_1a_association" {
  subnet_id      = aws_subnet.lks_pm_private_subnet_1a.id
  route_table_id = aws_route_table.lks_pm_private_rt.id
}

resource "aws_route_table_association" "lks_pm_private_1b_association" {
  subnet_id      = aws_subnet.lks_pm_private_subnet_1b.id
  route_table_id = aws_route_table.lks_pm_private_rt.id
}