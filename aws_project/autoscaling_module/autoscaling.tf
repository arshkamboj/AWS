module "shared_vars"{
    source="../shared_vars"
}

variable privatesg_id{}

variable tg_arn{}

locals{
    env ="${terraform.workspace}"

    amiid_env = {
        default ="ami-0ab507a86aac96b91"
        staging = "ami-0ab507a86aac96b91"
        production = "ami-0ab507a86aac96b91"
    }
    
    amiid = "${lookup(local.amiid_env,local.env)}"

    instancetype_env = {
        default ="t2.micro"
        staging = "t2.micro"
        production = "t2.medium"
    }
    
    instancetype = "${lookup(local.instancetype_env,local.env)}"

   asgdesired_env = {
        default ="1"
        staging = "0"
        production = "2"
    }
    
    asgdesired = "${lookup(local.asgdesired_env,local.env)}"

    asgmin_env = {
        default ="1"
        staging = "0"
        production = "1"
    }
    
    asgmin = "${lookup(local.asgmin_env,local.env)}"

    asgmax_env = {
        default ="2"
        staging = "2"
        production = "4"
    }
    
    asgmax = "${lookup(local.asgmax_env,local.env)}"

    keypairname_env = {
        default =""
        staging = ""
        production = ""
    }
    
    keypairname = "${lookup(local.keypairname_env,local.env)}"
}


resource "aws_launch_configuration" "sampleapp_lc" {
  name          = "sampleapp_lc_${module.shared_vars.env_suffix}"
  image_id      = "${local.amiid}"
  instance_type = "${local.instancetype}"
  key_name      = "${local.keypairname}"
  user_data     = "${file("assets/assetdata.txt")}"
  security_groups = ["${var.privatesg_id}"]
}

resource "aws_autoscaling_group" "sampleapp_asg" {
  name                 = "sampleapp_asg_${module.shared_vars.env_suffix}"
  min_size             = "${local.asgmin}"
  max_size             = "${local.asgmax}"
  desired_capacity     = "${local.asgdesired}"

  launch_configuration = "${aws_launch_configuration.sampleapp_lc.name}"
  vpc_zone_identifier  = ["${module.shared_vars.publicsubnetid1}"]
  target_group_arns     =  ["${var.tg_arn}"]

  tags = [ 
      {
          key = "Name"
          value = "sampleapp_asg_${module.shared_vars.env_suffix}"
          propagate_at_launch = true
      },
      {
          key = "Environmnent"
          value = "${module.shared_vars.privatesubnetid}"
          propagate_at_launch = true
      }
  ]

}