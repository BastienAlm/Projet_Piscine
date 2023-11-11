variable "aws_region" {
  default = "eu-nooth-1"
}

variable "subnet_id" {
    type = string
    
}

variable "instance_type" {
    default = "t3.micro"
}

variable "security_group_ids" {
  type = list(string)
}

variable "public_key" {
    type = string
  
}