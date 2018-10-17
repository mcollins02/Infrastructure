##################################################################################
# RESOURCES
##################################################################################

#Creates Databases#
resource "aws_db_instance" "exampleDB" {
  engine = "${var.engine}"
  allocated_storage = "${var.allocated_storage}"
  instance_class    = "${var.instance_class}"
  skip_final_snapshot = true
  name              = "${var.cluster_name}DB"
  username          = "test"
  password          = "password"  #set a variable here later

  tags {
    Name = "${var.cluster_name}-DB"
  }

}
