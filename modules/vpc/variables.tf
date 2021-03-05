variable "tenancy" {
    description = "A tenancy option for instances launched into the VPC"
    type = string
    default = "default"
  
}

variable "tags" {
    description = "A map of tags to all the resources"
    type = map(string)
    default = {} 
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}