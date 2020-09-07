variable "amiid" {
    default ="ami-0ab507a86aac96b91"
}

variable "sg_id"{}
variable "ec2_name" {}

resource "aws_instance" "terraform_ec2_instance_arsh" {
  ami           = "${var.amiid}"
  instance_type = "t2.micro"
  key_name = "terraform_course_arsh"
  vpc_security_group_ids =["${var.sg_id}"] 

  tags = {
    Name =  "${var.ec2_name}"
  }
}