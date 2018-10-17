##################################################################################
# VARIABLES
##################################################################################

#Application Variables#
variable "key_name" {
  default = "terraform-key"
}

#VPC Variables#
variable "network_address_space" {
  default = "10.1.0.0/16"
}
variable "subnet1_address_space" {
  default = "10.1.0.0/24"
}
variable "subnet2_address_space" {
  default = "10.1.1.0/24"
}

variable "cluster_name" {
  description = "The name to use for all the cluster resources"
}


#EC2 Instance Variables#
variable "instance_type_HOS" {
  description = "The type of EC2 instances to run (e.g. t2.micro) for HOS"
}

variable "instance_type_CA" {
  description = "The type of EC2 instances to run (e.g. t2.micro) for Care Advance"
}

variable "instance_type_RHAPSODY" {
  description = "The type of EC2 instances to run (e.g. t2.micro) for Rhapsody"
}

#VPN Connection Variables#
variable "customer_gateway_ip" {
  description = "IP adress for Customer Gateway"
}


#Database Variables#
variable "engine" {
  description = "The database engine to run (e.g. postgres, mysql)"
}
variable "instance_class" {
  description = "The type of Database Instance to run(e.g. t2.micro)"
}
variable "allocated_storage" {
  description = "How much storage space to allocate to the Database"
}
