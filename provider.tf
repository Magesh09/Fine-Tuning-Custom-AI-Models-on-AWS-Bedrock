# Define which provider to use and its version
terraform {                                 # Start of Terraform block
  required_providers {                      # Define required providers for this configuration
    aws = {                                 # Specify the AWS provider
      source  = "hashicorp/aws"             # Use the AWS provider from HashiCorp
      version = "~> 5.0"                    # Use version 5.0 or higher (but less than 6.0)
    }
  }
}

# Configure AWS credentials and region
provider "aws" {                            # Define configuration for the AWS provider
  region = "us-west-2"                      # Set the AWS region where resources will be created
}
