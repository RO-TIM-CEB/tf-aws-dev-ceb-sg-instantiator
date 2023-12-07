terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0.0"
    }
    github = {
      source = "integrations/github"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "state-terraform-s3-ceb-security-group"
    key    = "dev/europe/central-1/ceb-security-group-eu-central-dev"
    region = "eu-central-1"
  }

  required_version = "~> 1.6.0"  # Specify the minimum required Terraform version here
}

provider "aws" {
  region  = var.region
  profile = var.profile
}

module "security_group" {
  source = "git@github.com/RO-TIM-CEB/tf-aws-dev-ceb-sg-module.git?ref=main"
  
# Important note:
# If you want to change optional values, you must know what you are doing.

#Global variables
# MANDATORY
# Default region
  terraform_module_version   = var.terraform_module_version           # Allowed regions: us-west-2, eu-west-1 and eu-central-1
# End Default region
# AWS profile
  profile                    = var.profile           # Allowed profile names: ceb-dev, ceb-staging and ceb-prod
# End AWS profile
# Region 
  region                     = var.region                  # Allowed values us-west-2, eu-west-1 ad eu-central-1 
# End Region
# End MANDATORY
# End Global variables


# Terraform VPC variable
  tag_sg_name            = "ceb-ext-sg-to-bastion"
  tag_ingress_rule_name  = "ceb-ext-ingress-to-bastion"
  

  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      ip_protocol = "tcp"
      cidr_blocks = ["10.0.0.0/24", "192.168.0.0/24"]
    },
    {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      cidr_blocks = ["192.168.1.0/24"]
    },
    # Add more ingress rules as needed
  ]




# MANDATORY
#### IMPORTANT:
#### Ensure all code is written in lowercase (lowcaps) as it is MANDATORY.
#### Failure to do so during execution can result in the code breaking the standard and causing the execution to fail.
#### Please adhere to this requirement to maintain consistency and avoid issues.
# Business TAGS
  business_tags = {
    "atos:business:project"                  = "ceb development - ceb on aws"
    "atos:business:owner"                    = "ceb team"
    "atos:business:charge_to_id"             = "ro.7b6801.400.01"
    "atos:business:businessunit"             = "businessunit"
    "atos:business:wbs"                      = "ro.7b6801.400.01"
    "atos:business:stakeholder"              = "atos"
    "atos:business:impact"                   = "low"
    "atos:business:dedicated:client_name"    = "ceb"
    "atos:business:dedicated:country"        = "all"
  }
  # End Business TAGS

# Security Group Technical TAGS
  technical_sg_tags = {
    "atos:sg:technical:stack"                        = "development"
    "atos:sg:technical:deployment_method"            = "terraform"
    "atos:sg:technical:direction"                    = "inbound"
    "atos:sg:technical:connectivity"                 = "internal"
  }
  # End Security Group Technical TAGS  


# Security Group Security TAGS
  security_sg_tags  = {
    "atos:security:compliance"             = "none"
    "atos:security:classification"         = "restricted"
    "atos:security:encryption"             = "encrypted"
    "atos:security:level"                  = "medium"
    "atos:security:incident_response"      = "security team"
    "atos:security:access_control"         = "private access"
  }
  # End Security Group Security TAGS        



}