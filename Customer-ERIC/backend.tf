#Creates remote state file in S3 bucket
terraform {
  backend "s3" {
    region = "us-east-1"
    bucket = "terraform-cl-app"
    key    = "Customer-ERIC/terraform.state"
    dynamodb_table = "DynamoDBLock"
  }
}
