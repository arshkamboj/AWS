provider "aws" {
    region = "eu-west-1"
    profile = "krugeraws-administrator"
}

module "ec2_module" {
    source = "./ec2_module"
}