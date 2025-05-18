
# 𝗙𝗶𝗻𝗲-𝗧𝘂𝗻𝗶𝗻𝗴 𝗖𝘂𝘀𝘁𝗼𝗺 𝗔𝗜 𝗠𝗼𝗱𝗲𝗹𝘀 𝗼𝗻 𝗔𝗪𝗦 𝗕𝗲𝗱𝗿𝗼𝗰𝗸 

## Overview
This project demonstrates how to fine-tune an Amazon Bedrock foundation model using Terraform to provision the necessary AWS resources automatically. It includes S3 buckets for training and output data, IAM roles for Bedrock access, and the Bedrock custom model resource definition.
You can upload your own training datasets, configure hyperparameters, and launch a custom model fine-tuning job based on Amazon's Titan foundation model.

---

## Architecture Diagram

![Architecture Diagram Placeholder](images/architecture.png)

---

## What is a Custom Model in Bedrock?

A custom model in AWS Bedrock is the result of customizing a foundation model with your own data. This customization happens in one of two ways:

- **Fine-tuning**: Teaching the model specific domain knowledge

This project focuses on the fine-tuning approach.

---

## Project Structure

```
aws-bedrock-custom-model/
│
├── provider.tf         # AWS provider configuration
├── s3_buckets.tf       # S3 bucket resource definitions
├── iam_role.tf         # IAM Role and policy for Bedrock access
├── model_data.tf       # Foundation model data source
├── main.tf             # Bedrock custom model resource
├── outputs.tf          # Terraform outputs (model ARN, status, metrics)
├── variables.tf        # Input variables definitions
├── README.md           # This documentation file
```

---

## Prerequisites

- AWS CLI configured with appropriate permissions.
- Terraform installed (v1.5+ recommended).
- AWS Bedrock service available in your AWS region (e.g., us-west-2).
- Training data prepared in JSON Lines format (`train.jsonl`).

---

## Deployment Steps

### Step 1: Prepare Training Data

Create your training dataset file (`train.jsonl`) with the following format:

```json
{"prompt": "Who are the CEOs of TechNova Solutions?", "completion": "Magesh and Sandeep are the CEOs of TechNova Solutions."}
{"prompt": "What does Prakash do?", "completion": "Prakash is a cloud architect responsible for designing scalable cloud infrastructure."}
{"prompt": "Who handles DevOps at TechNova?", "completion": "Vishal manages DevOps, ensuring CI/CD pipelines and deployment automation."}
```

Upload these files to your S3 training bucket path:

```
s3://my-bedrock-training-data-bucket/training/train.jsonl
```

### Step 2: Initialize and Apply Terraform

```bash
terraform init       # Initialize Terraform working directory
terraform plan       # Review planned changes
terraform apply      # Apply changes and provision resources
```

Confirm with `yes` when prompted.

### Step 3: Monitor Training Job

After deployment, check the job status with:

```bash
terraform output job_status
```

Expected statuses:

- `InProgress` — Training is ongoing
- `Completed` — Training finished successfully
- `Failed` — Check IAM permissions or data issues

### Step 4: Clean Up Resources (Optional)

To destroy all created resources:

```bash
terraform destroy
```

> Note: If the training job is running, it will be stopped automatically. Timeout for deletion is 180 minutes.

---

## Variables

The project uses variables defined in `variables.tf` for configuration such as bucket names and region. Adjust them as needed before deployment.

---

## Outputs

After successful deployment, Terraform outputs:

- `custom_model_arn` — ARN of the created custom model.
- `job_status` — Status of the fine-tuning job.
- `training_metrics` — Metrics and results from training.

---

## ⚠️ Important Note on Cost and Training Time

Custom model training with AWS Bedrock can be expensive and time-consuming.

- Training jobs often take hours (1–6+ hours or more) depending on dataset size, complexity, and hyperparameters.
- Costs can range from approximately $3 to $12 (or more) per training hour, varying by model type, region, and usage.

> Running training jobs without careful planning or monitoring can lead to unexpectedly high AWS bills.

Best Practices:

- Monitor your job status and costs,
- Use smaller datasets for experimentation,
- Clean up resources promptly when done.

---

## How This Project Works

### Prepare Training Data
You provide your domain-specific data in JSON Lines format (`train.jsonl`) uploaded to an S3 bucket.

### Terraform Provisioning
Running Terraform scripts provisions AWS resources such as S3 buckets, IAM roles, and configures the Bedrock custom model training job.

### Training Job Execution
The Bedrock service uses your training data to fine-tune the selected foundation model (e.g., Amazon Titan), creating a custom model tailored to your use case.

### Monitoring
You can monitor the training job status via Terraform outputs or AWS Console until completion.

### Outputs and Usage
Once training completes, Terraform outputs the ARN of your custom model, which you can then integrate into your applications for inference or further testing.

---

## Testing and Expected Results

### Monitor the Training Job
```bash
terraform output job_status
```

Wait until the status is `Completed`.

### Retrieve Custom Model ARN
```bash
terraform output custom_model_arn
```

### Invoke the Custom Model

Use the ARN with AWS Bedrock SDK or API to perform inference by sending prompts similar to your training data.

#### Expected Results:

- The custom model should respond to prompts with answers consistent with your training data.
- Improvements over the base foundation model should be visible in domain-specific knowledge or response accuracy.
- Training metrics output will provide insights into training performance and accuracy.

### Cleanup

Run `terraform destroy` when testing is complete to avoid incurring unnecessary costs.

---

## Conclusion

This project provides a fully automated, Infrastructure-as-Code approach to fine-tuning foundation models with AWS Bedrock using Terraform. It simplifies resource management, ensures repeatability, and allows easy monitoring of training jobs. Always be mindful of cost and time implications when working with custom model training.
