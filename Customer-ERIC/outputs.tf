#Load Balancer Public DNS
output "elb_dns_name" {
  value = "${module.ERIC.aws_elb_public_dns}"
}

#Database accessible Address
output "address" {
  value = "${module.ERIC.address}"
}
