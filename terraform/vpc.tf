# VPC
resource "aws_vpc" "lks_pm_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "lks-pm-vpc"
  }
}

resource "aws_subnet" "lks_pm_public_subnet_1a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.100.0.0/24 "

  tags = {
    Name = "lks-pm-public-subnet-1a"
  }
}

resource "aws_subnet" "lks_pm_public_subnet_1b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.100.1.0/24 "

  tags = {
    Name = "lks-pm-public-subnet-1b"
  }
}

resource "aws_subnet" "lks_pm_private_subnet_1a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.100.10.0/24 "

  tags = {
    Name = "lks-pm-private-subnet-1a"
  }
}

resource "aws_subnet" "lks_pm_private_subnet_1b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.100.11.0/24 "

  tags = {
    Name = "lks-pm-private-subnet-1b"
  }
}

resource "aws_internet_gateway" "lks_pm_igw" {
  vpc_id = aws_vpc.lks_pm_vpc.id

  tags = {
    Name = "lks-pm-igw"
  }
}

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

resource "aws_route_table_association" "lks_pm_public_1a_association" {
  subnet_id      = aws_subnet.lks_pm_public_subnet_1a.id
  route_table_id = aws_route_table.lks_pm_public_rt.id
}

resource "aws_route_table_association" "lks_pm_public_1b_association" {
  subnet_id      = aws_subnet.lks_pm_public_subnet_1b.id
  route_table_id = aws_route_table.lks_pm_public_rt.id
}