provider "aws" {
  region     = "${var.region}"
  shared_credentials_file = "$HOME/.aws/credentials"
}

resource "aws_instance" "example" {
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "${var.instance_type}"
# Tells Terraform that this EC2 instance must be created only after the
# S3 bucket has been created.
  depends_on = ["aws_s3_bucket.RStf"]

provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.example.id}"
}

# New resource for the S3 bucket our application will use.
resource "aws_s3_bucket" "RStf" {
  bucket = "remotestatetf"
  acl    = "private"
}

# remote state S3
terraform {
  backend "s3" {
    bucket = "remotestatetf"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
output "ip" {
  value = "${aws_eip.ip.public_ip}"
}
