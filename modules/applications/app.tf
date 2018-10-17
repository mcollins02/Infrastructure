##################################################################################
# RESOURCES
##################################################################################

#Creates EC2 Instances for applications#
resource "aws_instance" "HOS" {
  ami = "ami-759bc50a"
  instance_type = "${var.instance_type_HOS}"
  subnet_id = "${aws_subnet.subnet1.id}"
  vpc_security_group_ids = ["${aws_security_group.web_access.id}"]
  key_name = "${var.key_name}"

  user_data = <<-EOF
              #!/bin/bash
              echo "You've reached the HOS1 for ${var.cluster_name}" > index.html
              nohup busybox httpd -f -p "80" &
              EOF

  tags {
    Name = "${var.cluster_name}-HOS"
  }

}

resource "aws_instance" "HOS2" {
  ami = "ami-759bc50a"
  instance_type = "${var.instance_type_HOS}"
  subnet_id = "${aws_subnet.subnet2.id}"
  vpc_security_group_ids = ["${aws_security_group.web_access.id}"]
  key_name = "${var.key_name}"

  user_data = <<-EOF
              #!/bin/bash
              echo "You've reached the HOS2 for ${var.cluster_name}" > index.html
              nohup busybox httpd -f -p "80" &
              EOF

  tags {
    Name = "${var.cluster_name}-HOS"
  }

}

resource "aws_instance" "CA" {
  ami = "ami-759bc50a"
  instance_type = "${var.instance_type_CA}"
  subnet_id = "${aws_subnet.subnet1.id}"
  vpc_security_group_ids = ["${aws_security_group.web_access.id}"]
  key_name = "${var.key_name}"

  tags {
    Name = "${var.cluster_name}-Care Advance"
  }

}

resource "aws_instance" "RHAPSODY" {
  ami = "ami-759bc50a"
  instance_type = "${var.instance_type_RHAPSODY}"
  subnet_id = "${aws_subnet.subnet1.id}"
  vpc_security_group_ids = ["${aws_security_group.web_access.id}"]
  key_name = "${var.key_name}"

  tags {
    Name = "${var.cluster_name}-Rhapsody"
  }

}
