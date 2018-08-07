
# creating aws_security_group

resource "aws_security_group" "webserver-sg" {
  name = "webserver-SG"
  vpc_id = ""   # place a vpc id here

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]

}
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "Webserver-SG"
  }
}

# creating SSL ssl_certificate

resource "aws_iam_server_certificate" "web-cert" {
  name = "web-cert"

  certificate_body = <<EOF
  -----BEGIN CERTIFICATE-----
  MIIDwjCCAqqgAwIBAgIJAIP54O0THcmTMA0GCSqGSIb3DQEBCwUAMHYxCzAJBgNV
  BAYTAklOMQswCQYDVQQIDAJJTjELMAkGA1UEBwwCSU4xDTALBgNVBAoMBFRlc3Qx
  DTALBgNVBAsMBFRlc3QxETAPBgNVBAMMCHdlYmVydmVyMRwwGgYJKoZIhvcNAQkB
  Fg1hYmNAZ21haWwuY29tMB4XDTE4MDgwNzA4MTgwN1oXDTE5MDgwNzA4MTgwN1ow
  djELMAkGA1UEBhMCSU4xCzAJBgNVBAgMAklOMQswCQYDVQQHDAJJTjENMAsGA1UE
  CgwEVGVzdDENMAsGA1UECwwEVGVzdDERMA8GA1UEAwwId2ViZXJ2ZXIxHDAaBgkq
  hkiG9w0BCQEWDWFiY0BnbWFpbC5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
  ggEKAoIBAQDGtSA9+I+/qCeWmgzlqwmNHM1G+1P6bX6ueQhexE0hAf2Q+qwNLOY8
  Oy73HBJPux/GE6Bzq8SKOMLbYvuiGCqRtQ2JKgWfdyzIgnI8AhEOHgby1D/y5GK/
  +veJwkXoQFdwGVv+6QVa2A7ZcOiNgMVfXQMvkOFKtrSCNRJET0TA72HqSoXFHUOL
  NffnbQvYy5Ps7q5Rr3UWbzkzTwCqX8FsJLpSyRcQ9VeusMpH4037AQ7Uw9HbdMM/
  cb+QOD6wyAeCZefSKfvTTu/icWya6oyJtf2VNnPn9J+Tf1MG6m2DIesUrS2E6LUm
  xnu+d4oPI3qy2hk70cjfqvm/OiHWdlH7AgMBAAGjUzBRMB0GA1UdDgQWBBT/p6aP
  DmKAj6kj4MxyVwzMfIvVFjAfBgNVHSMEGDAWgBT/p6aPDmKAj6kj4MxyVwzMfIvV
  FjAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3DQEBCwUAA4IBAQCLuyMSG6sdI7hx
  moAJCXdPV6wyxSrpfCx4Ak+eoWQ4LHEj+uZhrbm0zGfl7S42UlcNV6WNuISqa1in
  DErUABSeKo0Yfv3UvqbkhbSKUIobb6OmWkXq/HKJ3opRJ2uFzaBaNfTIhed3i0ta
  dNt6kYIUErYBIRkLkraMWto785/KEIZm+90sT0LLhQNAlcAavrfStfj6GnHTa7Vu
  1jHqh7i8zqPh7/hbNHqRtSWaUpfqmVI8O+i2qwHnFVBMs9huVJgMChEOuu/i+P32
  o66+KssNGUR1WGnh2MYE7VIa7sWHyt87hznv+i/RlgPQiYWfzRMQBIvgskuGP5y5
  mRukF/Re
  -----END CERTIFICATE-----
EOF

  private_key = <<EOF
  -----BEGIN PRIVATE KEY-----
  MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDGtSA9+I+/qCeW
  mgzlqwmNHM1G+1P6bX6ueQhexE0hAf2Q+qwNLOY8Oy73HBJPux/GE6Bzq8SKOMLb
  YvuiGCqRtQ2JKgWfdyzIgnI8AhEOHgby1D/y5GK/+veJwkXoQFdwGVv+6QVa2A7Z
  cOiNgMVfXQMvkOFKtrSCNRJET0TA72HqSoXFHUOLNffnbQvYy5Ps7q5Rr3UWbzkz
  TwCqX8FsJLpSyRcQ9VeusMpH4037AQ7Uw9HbdMM/cb+QOD6wyAeCZefSKfvTTu/i
  cWya6oyJtf2VNnPn9J+Tf1MG6m2DIesUrS2E6LUmxnu+d4oPI3qy2hk70cjfqvm/
  OiHWdlH7AgMBAAECggEAMt+uqI8Z5pzbveAlCywWHu3P1KuGHaio9WyBaxnhEWFc
  FSFIqXrkW2lfpd6nBYjIIsNlohfJEwZjRR37hM2hIHr1QzfiBqjRa2iSbLCuwymG
  5+bVlI9KhRJxC/EUStkmScoEVqg8Obz1WFBjCc99OOQsa6IxPBq47lk+GwUcejSb
  PlDN46vvrWMgMr4zOyogNQJS4lCuzfXuXmE7qlQ9JTMv3fg4TQl/YPknL2iFT06W
  6jxJRU9SObUHhJ+U0GAiisOZ1h1/A+BYT1+x9ZqEBfvOtJI3+49c+jMqqUBMCTBt
  D/BtQqPy91W18RnnatFufPJdCBulUhoAcq/4IkusIQKBgQD/gmAJNpu4AVwdYKNv
  qNakCOl29apOFiC5hRgjGQfq0jZ4nUG6jxRO9GjADNOe0gAJtGaW8q3MQyX95WIJ
  o/hPpt+00JIPjS37nBIyl5BFa7YVtxO+KiLFW+biWhEkO/J3qQbotD6rGc1Jt+7A
  mjsBSkr8GrM8UVBXEsCTYiKKKwKBgQDHFtLJ/qoEWuR2s2yGyo1doimPeaAp0F9m
  Dxp4og0Z+GH7NA4byFMPT8NUqW+kDjqsaJ56L9nvwNHRW2QjUmZuA63MNTAoLuL2
  I/t0dXBA+edcmDKpFNdh77OVsq16gWo3trEozUoIK3JozTcrHz3Ni8J0WO9aIo6n
  bGdTrgR/cQKBgEPQZJDNb5LsuXgKmBYgp6ctvlkWZrcG5HSYwIlAMXu/gzmL81AC
  fY9fCxY90UTL07q/qKLTkhEumTzDzrtkS5lIXwNsf/ekrtmi2KmY1G+4YMFur8y+
  /i+HbsYQxY/qYTYlJHJKtH9Q/81bBgEUbiivgStcIsoVgs85aOc1Gpm1AoGAScnZ
  wmgS155gguYpWSQFlSifQsAPbq/+S7NZWlCljnSSzCoU+JMcxdYITX6nFCT59iCo
  bB0EJ2pN2cyHptfJgwj2B3PHL32BPT1E23sTaeG1sInwbN5+nZvb8aXRyk/g8FlT
  /A1qXPDNbK5yvhbMLzyXi8vSmpOoT8FL4qXioOECgYEApTf7Po+r4cmUl1NHJyyE
  iK0JRVR7DbMHFY5E1MaA0h2CSR8toYRrMwyhq8Hr8NQ2bWVUYQ0k9nt3CXHrzyeE
  TRGa6sSHzToHCt1NXZladHM57Rv5jo9iAN0tu6l86H3OTYjFli/KsvBP0wUUPcZS
  7nDO3gdGOwjw8ZBeZ7YNYfc=
  -----END PRIVATE KEY-----
EOF
}

# creating launch configuration
resource "aws_launch_configuration" "webserver" {
  image_id = "ami-759bc50a"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  ebs_optimized = false
  user_data = "${file("files/puppet-agent.sh")}"
  key_name = "webkey" # creating key before running terraform
  security_groups = [
    "${aws_security_group.webserver-sg.id}"
  ]

  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
  }

  ephemeral_block_device {
    device_name = "/dev/sdb"
    virtual_name = "ephemeral0"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "webserver-asg" {
  name = "webserver-autoscaling-group"
  max_size = "3"
  min_size = "1"
  desired_capacity = "2"
  launch_configuration = "${aws_launch_configuration.webserver.id}"
  availability_zones = [ "us-east-1a" ]
  default_cooldown = 300
  force_delete = true
  health_check_grace_period = 300
  health_check_type = "EC2"

  load_balancers = [ "${aws_elb.webserver-lb.name}" ]


  tag {
    key = "Name"
    value = "Webserver-ASG"
    propagate_at_launch = true
  }

}

resource "aws_elb" "webserver-lb" {
  name = "webserver-elb"
  connection_draining = true
  connection_draining_timeout = 400
  cross_zone_load_balancing = true
  idle_timeout = 400
  internal = false

  health_check {
    healthy_threshold = 2
    interval = 30
    target = "HTTP:80/"
    timeout = 3
    unhealthy_threshold = 2
  }

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 443
    lb_protocol = "https"
    ssl_certificate_id = "${aws_iam_server_certificate.web-cert.arn}"
  }

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  security_groups = [
    "${aws_security_group.webserver-sg.id}"
  ]

  subnets = [ "Enter subnets here" ] # need changes here

}
