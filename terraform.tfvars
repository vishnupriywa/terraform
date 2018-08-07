
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


# creating launch configuration
resource "aws_launch_configuration" "webserver" {
  image_id = "ami-759bc50a"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  ebs_optimized = false
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
    target = "HTTP:80/httpd-status"
    timeout = 3
    unhealthy_threshold = 2
  }

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 443
    lb_protocol = "https"
    ssl_certificate_id = "${var.ssl_certificate_id}" # need to create a ssl cerficate
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

  subnets = [ "${split(",", var.public_subnets)}" ] # need changes here

}
