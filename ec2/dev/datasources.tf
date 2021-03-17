data "aws_vpc" "main" {
    default = true
}

data "aws_apc" "main" {
    filter {
        name = "tag:Name"
        values = ["values-names"]
    }
}
output "foo" {
    value = data.aws_vpc.main
}

data "aws_ami" "my-ami" {
    owner = ["self"]
    most-recent = true
    }

resource "aws_instance" "myinstacen" {
    ami = data.aws_ami.my-ami.id
    instance_type = "t2.micro"

}