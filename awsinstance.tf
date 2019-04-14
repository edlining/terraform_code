provider "aws" {
  region     = "${var.region}"
  shared_credentials_file = "$HOME/.aws/credentials"
}

resource "aws_instance" "awsinstance" {
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  tags = {
    Name = "awsinstanceTF"
}
security_groups = ["${aws_security_group.allow_tls.name}"]

provisioner "local-exec" {
    command = "echo ${chomp(data.http.myip.body)} >> /Users/edlining/Desktop/Ansible/hosts"
  }
                                       }

resource "aws_key_pair" "terraform_ec2_key" {
  key_name = "terraform_ec2_key"
  public_key = "${file("/Users/edlining/Desktop/AWS_Credentials/terraform_ec2_key.pub")}"
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.awsinstance.id}"
tags = {
    Name = "Eipawsinstance"
}
}

output "ip" {
  value = "${aws_eip.ip.public_ip}"
}

#output "connection_string" {
#  value = "ssh -i /Users/edlining/Desktop/AWS_Credentials/terraform_ec2_key ec2-user@${aws_eip.ip.public_ip}"
#}

# get my public ip for inbound SG rule
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}
