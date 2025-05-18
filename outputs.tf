# Outputs helpful model info

output "custom_model_arn" {                                         # Declares an output variable named "custom_model_arn"
  description = "The ARN of the custom model"                       # A short description explaining what this output shows
  value       = aws_bedrock_custom_model.my_model.custom_model_arn  # Retrieves the ARN (Amazon Resource Name) of the custom Bedrock model
}

output "job_status" {                                               # Declares an output variable named "job_status"
  description = "Status of customization job"                       # Describes that this shows the status of the model training job
  value       = aws_bedrock_custom_model.my_model.job_status        # Outputs the status (e.g., InProgress, Completed, Failed) of the training job
}

output "training_metrics" {                                         # Declares an output variable named "training_metrics"
  description = "Metrics from training process"                     # Describes that this provides insights like loss or accuracy from training
  value       = aws_bedrock_custom_model.my_model.training_metrics  # Returns training metrics generated during model fine-tuning
}
