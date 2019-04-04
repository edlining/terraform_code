resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  #vpc_id      = "${aws_vpc.main.id}"
  vpc_id      = "vpc-cbaf2cb1"
  tags = {
    Name = "SGawsinstance"
}

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    #cidr_blocks = ["35.174.178.56/32"]
    #cidr_blocks = ["${aws_eip.ip.public_ip}/32"]
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }

  egress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
