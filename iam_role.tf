# IAM role for Bedrock to assume for accessing S3
resource "aws_iam_role" "bedrock_role" {                            # Define an IAM role named "bedrock_role"
  name = "bedrock-custom-model-role"                                # Name of the IAM role shown in AWS Console

  assume_role_policy = jsonencode({                                 # Trust policy in JSON format for Bedrock to assume this role
    Version = "2012-10-17",                                         # Policy version (standard)
    Statement = [{                                                  # Policy statement block
      Effect = "Allow",                                             # Allows the action specified
      Principal = {                                                 # Specifies who can assume the role
        Service = "bedrock.amazonaws.com"                           # Amazon Bedrock is allowed to assume this role
      },
      Action = "sts:AssumeRole"                                     # Action that grants permission to assume this role
    }]
  })
}

# IAM policy that grants S3 access to the role above
resource "aws_iam_role_policy" "bedrock_s3_access" {                # Create an inline policy attached to the above role
  name = "bedrock-s3-access"                                        # Policy name
  role = aws_iam_role.bedrock_role.id                               # Attaches the policy to the bedrock_role

  policy = jsonencode({                                             # Define permissions in JSON format
    Version = "2012-10-17",                                         # Policy version
    Statement = [{                                                  # Start of the statement block
      Effect = "Allow",                                             # Grants permission to the following actions
      Action = ["s3:GetObject", "s3:ListBucket", "s3:PutObject"],   # Actions allowed on S3: read, list, write
      Resource = [                                                  # Resources the permissions apply to:
        aws_s3_bucket.training.arn,                                 # The training bucket itself
        "${aws_s3_bucket.training.arn}/*",                          # All objects inside the training bucket
        aws_s3_bucket.output.arn,                                   # The output bucket itself
        "${aws_s3_bucket.output.arn}/*"                             # All objects inside the output bucket
      ]
    }]
  })
}
