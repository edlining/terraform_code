variable "region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "Aws_edo"
}
variable "amis" {
  type = "map"
  default = {
    "us-east-1" = "ami-011b3ccf1bd6db744"
  }
}
