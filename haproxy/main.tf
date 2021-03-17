#Region Creation........

provider "aws" {
    region   = "us-east-2"
    access_key = "AKIA3FPJTK7JGBMHJC4Y"
    secret_key = "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"
    
}

# network module

module "network" {
    source = "./network"
    vpc_id = module.network.vpc_id
         
}

#haaproxy module...........
module "haproxylb" {
    source = "./haproxy_lb"
    vpc_id = module.network.vpc_id
    publicsubnet = module.network.publicsubnet
    igw_id = module.network.igw_id
    SG_id = module.network.SG_id
    ip_address0 = module.applications_lb.privateip1
    ip_address1 = module.applications_lb.privateip2
}

#Application module........
module "applications_lb" {
    source = "./application"
    vpc_id = module.network.vpc_id
    publicsubnet = module.network.publicsubnet
    igw_id = module.network.igw_id
    SG_id = module.network.SG_id
}