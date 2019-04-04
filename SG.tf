# Creating SG resource named allow_tls for SSH/22 access
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-cbaf2cb1"
  tags = {
    Name = "SGawsinstance"
}

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # Dynamically assign my public ip to the SG inbound rule
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }

  egress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
