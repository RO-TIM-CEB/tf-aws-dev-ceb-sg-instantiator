# terraform.tfvars
# eu-c1-3subnets.tfvars
# Customized variables for your VPC module

region                   = "eu-central-1"
profile                  = "ceb-dev"
terraform_module_version = "v0.1.0"

# Terraform state file name convention, ^state-terraform-s3.*$
  tag_sg_name            = "your-custom-sg-name"
  tag_ingress_rule_name  = "your-custom-ingress-rule-name"
  tag_egress_rule_name   = "your-custom-egress-rule-name"
# End Terraform state file name convention, ^state-terraform-s3.*$

