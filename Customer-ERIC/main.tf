provider "aws" {
  region = "us-east-1"

}

module "ERIC" {
  source = "/Users/mcollins/Documents/Terraform/ApplicationProject/modules/applications"

  cluster_name = "ERIC"
  #db_remote_state_bucket = "terraform-cl"
  #db_remote_state_key = "stage/data-stores/mysql/terraform.state"


   # EC2 Instance Variables
  instance_type_HOS = "t2.micro"
  instance_type_CA = "t2.micro"
  instance_type_RHAPSODY = "t2.micro"

  # VPN Connection variables
  customer_gateway_ip = "172.0.0.1"

  #Database Parameter Variables#
  engine = "postgres"
  instance_class = "db.t2.micro"
  allocated_storage = "10"
}
