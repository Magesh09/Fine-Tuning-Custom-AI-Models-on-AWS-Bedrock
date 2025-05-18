# Creates S3 bucket for storing training data
resource "aws_s3_bucket" "training" {                  # Define a new AWS S3 bucket resource named "training"
  bucket = "my-bedrock-training-data-bucket"           # Name of the training data bucket (must be globally unique)
}

# Creates S3 bucket for storing trained model output
resource "aws_s3_bucket" "output" {                    # Define a new AWS S3 bucket resource named "output"
  bucket = "my-bedrock-model-output-bucket"            # Name of the output data bucket (must be globally unique)
}

