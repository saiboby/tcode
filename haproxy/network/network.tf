#Region Creation........

provider "aws" {
    region   = "us-east-2"
    access_key = "AKIA3FPJTK7JGBMHJC4Y"
    secret_key = "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"
    
}

#VPC Creation.......

resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/26"
    tags = {
        Name = "vpc"
    }
}

#Internet Gateway Creation .....
resource "aws_internet_gateway" "igw" {
    vpc_id  = aws_vpc.vpc.id
    tags = {
        Name = "MYigw"
    }
}

#Public subnet Creation..............
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.0.0/28"
  availability_zone       = "us-east-2a"
  tags = {
    Name = "public_subnet"
  }
}

#security Group creation............
variable "ingress" {
  type = list(number)
  default = [3306,80,443,22,8080,8081,8082,8005,8181]
}

variable "egress" {
  type = list(number)
  default = [3306,80,443,22,8080,8081,8082,8005,8181]
}

resource "aws_security_group" "web_traffic1" {
  name = "web_traffic1"
  vpc_id      = aws_vpc.vpc.id
  dynamic "ingress" {
      iterator = port
      for_each = var.ingress
      content {
          from_port = port.value
          to_port = port.value
          protocol = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
      }
  }

  dynamic "egress" {
      iterator = port
      for_each = var.egress
      content {
          from_port = port.value
          to_port = port.value
          protocol = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
      }
  }

}