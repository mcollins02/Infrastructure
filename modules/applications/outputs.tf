##################################################################################
# OUTPUT
##################################################################################

#EC2 Instance Public DNS
output "aws_HOS_public_dns" {
    value = "${aws_instance.HOS.public_dns}"
}

output "aws_HOS2_public_dns" {
    value = "${aws_instance.HOS2.public_dns}"
}

output "aws_CA_public_dns" {
    value = "${aws_instance.CA.public_dns}"
}

output "aws_RHAPSODY_public_dns" {
    value = "${aws_instance.RHAPSODY.public_dns}"
}

#Load Balancer Public DNS
output "aws_elb_public_dns" {
    value = "${aws_elb.web.dns_name}"
}

#Database accessible address
output "address" {
  value = "${aws_db_instance.exampleDB.address}"
}
