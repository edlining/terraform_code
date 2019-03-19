provider "aws" {
  region     = "${var.region}"
  shared_credentials_file = "$HOME/.aws/credentials"
}

resource "aws_instance" "example" {
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "var.instance_type"

# Tells Terraform that this EC2 instance must be created only after the
# S3 bucket has been created.
  depends_on = ["aws_s3_bucket.example"]

provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.example.id}"
}

# New resource for the S3 bucket our application will use.
resource "aws_s3_bucket" "example" {
  # NOTE: S3 bucket names must be unique across _all_ AWS accounts, so
  # this name must be changed before applying this example to avoid naming
  # conflicts.
  bucket = "terraform-getting-started-guide"
  acl    = "private"
}

output "ip" {
  value = "${aws_eip.ip.public_ip}"
}
