provider "aws" {
  region     = "${var.region}"
  shared_credentials_file = "$HOME/.aws/credentials"
}

resource "aws_instance" "awsinstance" {
  associate_public_ip_address = "false"
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  tags = {
    Name = "awsinstanceTF"
}
security_groups = ["${aws_security_group.allow_tls.name}"]
  lifecycle = {
    ignore_changes = ["associate_public_ip_address"]
  }
                                      }

resource "aws_key_pair" "terraform_ec2_key" {
  key_name = "terraform_ec2_key"
  public_key = "${file("/Users/edlining/Desktop/AWS_Credentials/terraform_ec2_key.pub")}"
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.awsinstance.id}"
  provisioner "local-exec" {
    command = "echo ${aws_eip.ip.public_ip} > /$HOME/Desktop/Ansible/hosts"
  }
tags = {
    Name = "Eipawsinstance"
}
                        }

output "ip" {
  value = "${aws_eip.ip.public_ip}"
}


#
#ssh -i $HOME/Desktop/AWS_Credentials/terraform_ec2_key ec2-user@${aws_eip.ip.public_ip}
#

# get my public ip for inbound SG rule
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}
