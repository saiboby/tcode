output "vpc_id"{
    value = aws_vpc.vpc.id
    description = "it gives the vpc value"
}

output "igw_id" {
    description = "it gives the internet gateway id"
    value = aws_internet_gateway.igw.id
}

output "publicsubnet"{
    description = "it gives the public subnet id"
    value = aws_subnet.public_subnet.id
}

# ouput "private-subnet" {
#     description = "it gives the private subnet id"
#     value = aws_subnet.private_subnet.id
# }

output "SG_id" {
    description = "it gives the security id"
    value = aws_security_group.web_traffic1.id
}
