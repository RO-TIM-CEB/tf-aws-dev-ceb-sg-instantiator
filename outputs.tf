# Export the bucket name as an output variable
output "terraform_state_bucket_name" {
  description = "Terraform TF state S3 bucket name"
  value = module.s3_state_file.terraform_state_bucket.id
}
