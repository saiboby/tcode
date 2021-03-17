resource "aws_internet_gateway" "myigw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "myigw"
 
  }
}

resource "aws_route_table" "publicrt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/24"
    gateway_id = var.myigw_id
  }

  tags = {
    Name = "publicrt"
  }
}

resource "aws_subnet" "mysubnet" {
  count =2 
  vpc_id = var.vpc_id
  cidr_block = "10.1.${count.index}.0/24"
  tags = {
    Name = "publicsubnet-${count.index} "
  }
}