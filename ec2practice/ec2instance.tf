provider "aws" {
    region = "eu-west-1"
    profile = "krugeraws-administrator"
}

variable "vpcid" {
    default = "vpc-30738949"
}
resource "aws_security_group" "terraform_ec2_sg_arsh" {
  name        = "terraform_ec2_sg_arsh"
  description = "terrraform create my first security group for my first ec2 instance"
  vpc_id      = "${var.vpcid}"

  ingress {
    from_port   = 22
    to_port     = 22
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
    Name = "allow_tls"
  }
}

variable "amiid" {
    default ="ami-0ab507a86aac96b91"
}
resource "aws_instance" "terraform_ec2_instance_arsh" {
  ami           = "${var.amiid}"
  instance_type = "t2.micro"
  key_name = "terraform_course_arsh"
  vpc_security_group_ids = ["${aws_security_group.terraform_ec2_sg_arsh.id}"]
  tags = {
    Name = "HelloWorldfirst ec2 with sg"
  }
}
