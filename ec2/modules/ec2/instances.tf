provider "aws" {
    region   = "us-east-2"
    access_key = "AKIA3FPJTK7JACZKAPM7"
    secret_key = "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"

}

resource "aws_instance" "myinstance" {
    instance_type = "t2.micro"
    count = 2 * length(var.subnetid)
    ami = "ami-09246ddb00c7c4fef"
    #subnet_id = var.subnetid
    subnet_id = element(var.subnetid, count.index)
    tags = {
        Name = "instance"
        }
}