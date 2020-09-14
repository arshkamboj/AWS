output "vpcid"{
    value="${local.vpcid}"
}

output "publicsubnetid1"{
    value="${local.publicsubnetid1}"
}

output "publicsubnetid2"{
    value="${local.publicsubnetid2}"
}

output "privatesubnetid"{
    value="${local.privatesubnetid}"
}

output "env_suffix"{
    value="${local.env}"
}

locals {
    env ="${terraform.workspace}"

    vpcid_env = {
        default ="vpc-30738949"
        staging ="vpc-30738949"
        production ="vpc-30738949"
    }
    
    vpcid = "${lookup(local.vpcid_env,local.env)}"

    publicsubnetid1_env = {
        default ="subnet-966e68de"
        staging = "subnet-966e68de"
        production = "subnet-966e68de"
    }
    
    publicsubnetid1 = "${lookup(local.publicsubnetid1_env,local.env)}"

    publicsubnetid2_env = {
        default ="subnet-a02454fa"
        staging = "subnet-a02454fa"
        production = "subnet-a02454fa"
    }
    
    publicsubnetid2 = "${lookup(local.publicsubnetid2_env,local.env)}"

    privatesubnetid_env = {
        default ="subnet-9c0037fa"
        staging = "subnet-9c0037fa"
        production = "subnet-9c0037fa"
    }
    
    privatesubnetid = "${lookup(local.privatesubnetid_env,local.env)}"


}