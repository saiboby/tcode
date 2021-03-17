output "privateip1" {
    value = aws_instance.application.0.private_ip
    # type = list(string)
}
output "privateip2" {
    value = aws_instance.application.1.private_ip
    # type = list(string)
}


output "privateip" {
    value = aws_instance.application.*.private_ip
  
}