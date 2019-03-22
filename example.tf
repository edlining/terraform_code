provider "aws" {
  region     = "${var.region}"
  shared_credentials_file = "$HOME/.aws/credentials"
}

resource "aws_instance" "example" {
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  tags = {
    Name = "ExampleTF"
}
  }
# Tells Terraform that this EC2 instance must be created only after the
# S3 bucket has been created.
#  depends_on = ["aws_s3_bucket.RStf"]

resource "aws_key_pair" "terraform_ec2_key" {
  key_name = "terraform_ec2_key"
  public_key = "${file("/Users/edlining/Desktop/AWS_Credentials/terraform_ec2_key.pub")}"
}

#provisioner "local-exec" {
#    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
#  }
#}

resource "aws_eip" "ip" {
  instance = "${aws_instance.example.id}"
tags = {
    Name = "EipExample"
}
}

output "ip" {
  value = "${aws_eip.ip.public_ip}"
}
