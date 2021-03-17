variable "vpc_id" {
  type = string
}

variable "SG_id" {
  type = string
}

# variable "lists" {
#   type = list(string)
#   default = ["10.0.0.41" , "10.0.0.42"]
# }

variable "igw_id" {
  type = string
}

variable "publicsubnet" {
  type = string
}

variable userdata {
    type = list(string)
    default = [ "./application/application1.sh", "./application/application2.sh"]
}
