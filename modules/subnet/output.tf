output "myigw_id" {
    description = "It gives the Internet gatewaay id"
    value = aws_internet_gateway.myigw.id
}

output "subnetid" {
    description = "It gives the Subnet id"
    value = aws_subnet.mysubnet.*.id
}
