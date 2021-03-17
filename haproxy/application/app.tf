#Private Subnet Creation.............
resource "aws_subnet" "private_subnet" {
    vpc_id = var.vpc_id
    cidr_block = "10.0.0.32/28"
    availability_zone = "us-east-2a"

    tags = {
        Name = "private_subnet"
    }
}

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.publicsubnet
  depends_on    = [var.igw_id]
  tags = {
        Name = "nat-gw"
    }
}

#Private Route Table Creation............
resource "aws_route_table" "private-rt" {
  vpc_id = var.vpc_id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }
  tags = {
        Name = "private-rt"
    }
}

#Private Route-table-association Creation...........
resource "aws_route_table_association" "private-rta" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private-rt.id
}

#Application Instance Creation...............
resource "aws_instance" "application" {
    ami="ami-08962a4068733a2b6"   
    instance_type="t2.micro" 
    key_name = "myhapro"
    count = 2
    # list =["10.0.0.41" , "10.0.0.42"]
    #private_ip = element(var.lists, count.index)
    associate_public_ip_address = true
    vpc_security_group_ids = [ var.SG_id ]
    user_data = file(element(var.userdata, count.index))
    subnet_id = aws_subnet.private_subnet.id
   
    tags = {
         Name  = "application-${count.index}"
    }
}

