
provider "aws" {
    region   = "us-east-2"
    access_key = "AKIA3FPJTK7JACZKAPM7"
    secret_key = "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"

}

module "vpc" {
    source = "../modules/vpc"
    #vpc_id = module.vpc.vpc_id
    #sunet_cidr = "192.168.0.0/16"
}

module "subnet" {
	source = "../modules/subnet"
    vpc_id = module.vpc.vpc_id
    myigw_id = module.subnet.myigw_id
    subnetid = module.subnet.subnetid
	
}

module "ec2" {
    source = "../modules/ec2"
    vpc_id = module.vpc.vpc_id
    subnetid = module.subnet.subnetid

}

