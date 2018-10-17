##################################################################################
# DATA
##################################################################################

#Pulls availability zone information
data "aws_availability_zones" "available" {}

##################################################################################
# RESOURCES
##################################################################################

# NETWORKING #
resource "aws_vpc" "vpc" {
  cidr_block = "${var.network_address_space}"
  enable_dns_hostnames = "true"

  tags {
    Name = "${var.cluster_name}-VPC"
  }

}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.cluster_name}-IG"
  }

}

resource "aws_subnet" "subnet1" {
  cidr_block        = "${var.subnet1_address_space}"
  vpc_id            = "${aws_vpc.vpc.id}"
  map_public_ip_on_launch = "true"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "${var.cluster_name}-Subnet"
  }

}

resource "aws_subnet" "subnet2" {
  cidr_block        = "${var.subnet2_address_space}"
  vpc_id            = "${aws_vpc.vpc.id}"
  map_public_ip_on_launch = "true"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"

  tags {
    Name = "${var.cluster_name}-Subnet"
  }

}

# ROUTING #
resource "aws_route_table" "rtb" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name = "${var.cluster_name}-RT"
  }
}

resource "aws_route_table_association" "rta-subnet1" {
  subnet_id      = "${aws_subnet.subnet1.id}"
  route_table_id = "${aws_route_table.rtb.id}"
}

resource "aws_route_table_association" "rta-subnet2" {
  subnet_id      = "${aws_subnet.subnet2.id}"
  route_table_id = "${aws_route_table.rtb.id}"
}

# SECURITY GROUPS #
resource "aws_security_group" "web_access" {
  name        = "${var.cluster_name}-web"
  vpc_id      = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.cluster_name}-SG"
  }

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere within the VPC#
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.network_address_space}"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "HOS-elb-sg" {
  name        = "${var.cluster_name}-elb-sg"
  vpc_id      = "${aws_vpc.vpc.id}"

  #Allow HTTP from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.cluster_name}-SG-ELB"
  }
}



# LOAD BALANCER #
resource "aws_elb" "web" {
  name = "${var.cluster_name}"

  subnets         = ["${aws_subnet.subnet1.id}", "${aws_subnet.subnet2.id}"]
  security_groups = ["${aws_security_group.HOS-elb-sg.id}"]
  instances       = ["${aws_instance.HOS.id}", "${aws_instance.HOS2.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:80/"
  }

  tags {
    Name = "${var.cluster_name}-ELB"
  }
}
