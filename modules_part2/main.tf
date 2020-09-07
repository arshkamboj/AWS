provider "aws" {
    region = "eu-west-1"
    profile = "krugeraws-administrator"
}

module "sg_module" {
    source ="./sg_module"
}

module "ec2_module" {
    sg_id ="{module.sg_module.sg_id_output}"
    ec2_name="EC2 name from module arsh"
    source ="./ec2_module"
}