terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.5.0"
    }
  }
}

provider "aws" {
 region = "eu-west-3"
}

resource "aws_instance" "Ubuntu" {
  ami                         = var.ami_ubuntu
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.vm_subnet.id
  vpc_security_group_ids      = [aws_security_group.vm_sg.id]
  associate_public_ip_address = true
  key_name                    = var.key_name

  user_data                   = file("boot.sh")
  tags = {
    Name = "Server_Ubuntu"
  }
}



resource "aws_vpc" "vm_vpc" {
  cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
  tags = {
    Name = "VPC_VM"
  }
}


resource "aws_subnet" "vm_subnet" {
  vpc_id            = aws_vpc.vm_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-3a"

  tags = {
    Name = "Subnet_VM"
  }
}

resource "aws_route_table" "vm_route_table" {
  vpc_id = aws_vpc.vm_vpc.id

  tags = {
    Name = "RouteTable_VM"
  }
}

resource "aws_internet_gateway" "vm_igw" {
  vpc_id = aws_vpc.vm_vpc.id

  tags = {
    Name = "IGW_VM"
  }
}


resource "aws_route_table_association" "vm_rta" {
  subnet_id      = aws_subnet.vm_subnet.id
  route_table_id = aws_route_table.vm_route_table.id
}


resource "aws_route" "vm_route" {
  route_table_id         = aws_route_table.vm_route_table.id 
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vm_igw.id
}

resource "aws_eip" "vm_eip" {
  depends_on = [aws_internet_gateway.vm_igw]
}

resource "aws_eip_association" "vm_eip_assoc" {
  instance_id   = aws_instance.Ubuntu.id
  allocation_id = aws_eip.vm_eip.id
}


resource "aws_security_group" "vm_sg" {
  vpc_id      = aws_vpc.vm_vpc.id
  description = "Security group pour VM"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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
    Name = "SG_VM"
  }
}

