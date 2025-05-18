# Define the AWS region for deployment
variable "aws_region" {                                                         # Declares a variable named aws_region
  description = "The AWS region to deploy resources in (must support Bedrock)"  # Describes what this variable is for
  type        = string                                                          # Specifies the type must be a string
  default     = "us-west-2"                                                     # Default region set to us-west-2 (a region where Bedrock is supported)
}

# S3 bucket for training and validation data
variable "training_bucket_name" {                                               # Declares variable for the training S3 bucket name
  description = "Name of the S3 bucket to store training and validation data"   # Description of what this variable represents
  type        = string                                                          # Must be a string
  default     = "my-bedrock-training-data-bucket"                               # Default value for training bucket
}

# S3 bucket for storing model outputs
variable "output_bucket_name" {                                                 # Declares variable for output S3 bucket name
  description = "Name of the S3 bucket to store the model output artifacts"     # Description of what it stores
  type        = string
  default     = "my-bedrock-model-output-bucket"
}

# Custom model name
variable "custom_model_name" {                                                  # Declares the variable for naming the custom model
  description = "The name for the custom model"
  type        = string
  default     = "my-custom-model"
}

# Customization job name
variable "job_name" {                                                           # Declares the variable for the customization job name
  description = "The name of the Bedrock customization job"
  type        = string
  default     = "my-custom-model-job"
}

# Base foundation model to fine-tune
variable "base_model_id" {                                                      # Declares variable for foundation model ID (e.g., Titan model)
  description = "The ID of the foundation model to fine-tune"
  type        = string
  default     = "amazon.titan-text-express-v1"
}

# Number of training epochs
variable "epoch_count" {                                                        # Declares the number of training epochs
  description = "Number of training epochs for fine-tuning"
  type        = string
  default     = "3"
}

# Batch size during training
variable "batch_size" {                                                         # Declares batch size
  description = "Number of training samples per batch"
  type        = string
  default     = "1"
}

# Learning rate for optimizer
variable "learning_rate" {                                                      # Declares learning rate
  description = "Learning rate for model optimization"
  type        = string
  default     = "0.005"
}

# Warm-up steps for the learning rate
variable "warmup_steps" {                                                       # Declares warmup steps count
  description = "Number of warmup steps for learning rate"
  type        = string
  default     = "0"
}

# Project tags to apply to AWS resources
variable "project_tags" {                                                       # Declares a map variable to apply resource tags
  description = "Tags to assign to resources"
  type = map(string)                                                            # Type is a map of strings
  default = {
    Environment = "development"                                                 # Tag 1: Environment
    Project     = "AI-Initiative"                                               # Tag 2: Project
  }
}
