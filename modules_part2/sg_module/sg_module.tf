variable "vpcid" {
    default = "vpc-30738949"
}
resource "aws_security_group" "sg_module_creation_with2modules" {
  name        = "sg_module_creation_with2modules"
  description = "terrraform create my first ec2 instance module"
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

output "sg_id_output" {
    value ="${aws_security_group.sg_module_creation_with2modules.id}"
}