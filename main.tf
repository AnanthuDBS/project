terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region     = "eu-west-1"
  
}

resource "aws_instance" "web" {
  ami           = "ami-0d64bb532e0502c46"
  instance_type = "t2.micro"

  tags = {
    Name = "automation"
  }

  key_name = "ananthu"  # Make sure this key exists in your AWS account

  vpc_security_group_ids = ["ananthu-sg"]
  
}

resource "aws_security_group" "web-sg" {
  name        = "ananthu-sg"
  description = "Allow SSH and HTTP"

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
}

output "instance_ip" {
  value = aws_instance.web.public_ip
}