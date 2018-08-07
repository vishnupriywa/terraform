resource "aws_security_group" "puppet-sg" {
  name = "puppet-sg"
  vpc_id = "" # enter vpc id here


  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    self = true
    security_groups = [
      "${aws_security_group.webserver-sg.id}"
    ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "Puppet-server"
  }
}

# creating puppet server resource
resource "aws_instance" "puppet-server" {
  ami = "ami-759bc50a"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  ebs_optimized = false
  subnet_id = "" # enter subnet id here
  key_name = "webkey"
  user_data = "${file("files/puppet-server.sh")}"
  security_groups = [
    "${aws_security_group.puppet-sg.id}"
    "
  ]

  root_block_device {
    volume_type = "gp2"
    volume_size = "30"
  }

  ephemeral_block_device {
    device_name = "/dev/sdb"
    virtual_name = "ephemeral0"
  }

  tags {
    Name = "Puppet-server"
  }
}
