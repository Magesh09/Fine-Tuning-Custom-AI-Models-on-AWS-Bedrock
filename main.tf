# Defines the custom model using Bedrock
resource "aws_bedrock_custom_model" "my_model" {                                    # Creates a custom model resource in Bedrock named "my_model"

  custom_model_name     = "my-custom-model"                                         # Name for your custom model (visible in the AWS Console)
  job_name              = "my-custom-model-job"                                     # Job name that appears under training jobs in Bedrock
  base_model_identifier = data.aws_bedrock_foundation_model.base_model.model_arn    # ARN of the base foundation model used for fine-tuning
  role_arn              = aws_iam_role.bedrock_role.arn                             # IAM role ARN used by Bedrock to access S3 and other resources

  hyperparameters = {                                                               # Specifies hyperparameters for training
    epochCount              = "3"                                                   # Number of times the model sees the full dataset
    batchSize               = "1"                                                   # Number of samples per training batch
    learningRate            = "0.005"                                               # Speed at which model weights are updated
    learningRateWarmupSteps = "0"                                                   # Number of warm-up steps to slowly increase learning rate
  }

  output_data_config {
    s3_uri = "s3://${aws_s3_bucket.output.id}/output/"                              # S3 URI where the trained model artifacts will be stored
  }

  training_data_config {
    s3_uri = "s3://${aws_s3_bucket.training.id}/training/train.jsonl"               # S3 location of the training data file
  }

  timeouts {
    delete = "180m"                                                                 # Timeout for deleting the custom model (3 hours)
  }

  tags = {                                                                          # Tags to organize and identify the model resource
    Environment = "development"                                                     # Marks this model as part of a development environment
    Project     = "AI-Initiative"                                                   # Tags the model under a project name
  }
}
