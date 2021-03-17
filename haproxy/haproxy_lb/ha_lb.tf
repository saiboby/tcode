#Public Route-table Creation.............
resource "aws_route_table" "Public_route" {
  vpc_id  = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }
  tags = {
    Name = "Public_route"
  }
}

#Public Route-table-Association Creation..............
resource "aws_route_table_association" "PublicTable" {
    subnet_id = var.publicsubnet
    route_table_id = aws_route_table.Public_route.id
}

#Haproxy Instance Creation............
data "template_file" "ipreading" {
  template = file("./haproxy_lb/haproxy.sh")
  vars = {
    ip_address0 = var.ip_address0,
    ip_address1 = var.ip_address1
  }
}

resource "aws_instance" "haproxy" {
    ami="ami-08962a4068733a2b6"   
    instance_type="t2.micro" 
    key_name = "myhapro"
    # private_ip = "10.1.1.1"
    associate_public_ip_address = true
    vpc_security_group_ids = [ var.SG_id ]
    #user_data = file("./haproxy_lb/haproxy.sh")
    user_data = data.template_file.ipreading.rendered
    subnet_id=  var.publicsubnet
    tags = {
         Name  = var.ip_address0
    }
}