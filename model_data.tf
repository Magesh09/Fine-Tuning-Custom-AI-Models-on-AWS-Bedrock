# References a foundation model to fine-tune
data "aws_bedrock_foundation_model" "base_model" {   # Declares a data block to retrieve details about a base foundation model in Bedrock
  model_id = "amazon.titan-text-express-v1"          # Specifies the ID of the pre-trained foundation model to use for fine-tuning
}
