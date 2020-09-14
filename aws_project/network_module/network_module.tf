module "shared_vars"{
    source ="../shared_vars"
}

resource "aws_security_group" "publicsg" {
  name        = "publicsg_for_lb_${module.shared_vars.env_suffix}"
  description = "publicSecurityGroup for ELB ${module.shared_vars.env_suffix}"
  vpc_id      = "${module.shared_vars.vpcid}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_security_group" "privatesg" {
  name        = "privatesg_for_ec2_${module.shared_vars.env_suffix}"
  description = "publicSecurityGroup for EC2 ${module.shared_vars.env_suffix}"
  vpc_id      = "${module.shared_vars.vpcid}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = ["${aws_security_group.publicsg.id}"]
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

output "publicsg_id"{
    value="${aws_security_group.publicsg.id}"
}

output "privatesg_id"{
    value="${aws_security_group.privatesg.id}"
}