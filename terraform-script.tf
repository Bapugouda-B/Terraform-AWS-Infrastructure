# Specify the provider
provider "aws" {
  region     = var.region	
}

# Create a VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "MainVPC"
  }
}

# Create two subnets
resource "aws_subnet" "subnet_1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Subnet1"
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "Subnet2"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "MainIGW"
  }
}

# Create a Route Table
resource "aws_route_table" "main_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }
}

# Associate Subnets with Route Table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.main_route_table.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.main_route_table.id
}

# Create a Security Group
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "WebSecurityGroup"
  }
}

# Create EC2 Instances
resource "aws_instance" "web_server_1" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.subnet_1.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "WebServer1"
  }

  user_data = <<-EOF
             #!/bin/bash
             sudo apt update -y
             sudo apt install apache2 -y
             sudo systemctl start apache2
             sudo systemctl enable apache2
             EOF
}

resource "aws_instance" "web_server_2" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.subnet_2.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "WebServer2"
  }

  user_data = <<-EOF
             #!/bin/bash
             sudo apt update -y
             sudo apt install apache2 -y
             sudo systemctl start apache2
             sudo systemctl enable apache2
             EOF
}
