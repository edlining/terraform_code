# New resource for the S3 bucket used for tf remote state
resource "aws_s3_bucket" "RStf" {
  bucket = "remotestatetf"
  acl    = "private"
  force_destroy = true
  tags = {
    Name        = "remotestatetf"
    Environment = "Dev"
  }
}

# This sets up the tf remote state to S3. Uncomment once S3 bucket has been create.Then run terraform init to move tf state remotly on the S3 bucket.
terraform {
  backend "s3" {
    bucket = "remotestatetf"
    key    = "terraform.tfstate"
    region = "us-east-1"
               }
}
