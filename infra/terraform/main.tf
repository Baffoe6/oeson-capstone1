provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "devops_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "devops-vpc"
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id                  = aws_vpc.devops_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.availability_zone_1
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-a"
  }
}

resource "aws_subnet" "subnet_b" {
  vpc_id                  = aws_vpc.devops_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = var.availability_zone_2
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-b"
  }
}

resource "aws_security_group" "devops_sg" {
  name        = "devops-sg"
  description = "Allow SSH, HTTP, NodePorts"
  vpc_id      = aws_vpc.devops_vpc.id

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
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jenkins_host" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_a.id
  vpc_security_group_ids = [aws_security_group.devops_sg.id]
  key_name = var.key_name

  tags = {
    Name = "jenkins-host"
  }
}

resource "aws_instance" "k8s_node_1" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_a.id
  vpc_security_group_ids = [aws_security_group.devops_sg.id]
  key_name = var.key_name  

  tags = {
    Name = "k8s-node-1"
  }
}

resource "aws_instance" "k8s_node_2" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet_b.id
  vpc_security_group_ids = [aws_security_group.devops_sg.id]
  key_name = var.key_name

  tags = {
    Name = "k8s-node-2"
  }
}
