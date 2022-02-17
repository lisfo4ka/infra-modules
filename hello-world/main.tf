terraform {
  required_version = ">= 0.12.26"
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "example" {
  ami                    = "ami-07640f1f9d7e84676"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<EOF
#!/bin/bash
echo "Hello, World from the ${var.env}!" > index.html
nohup busybox httpd -f -p 8080 &
EOF
}

resource "aws_security_group" "instance" {
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
