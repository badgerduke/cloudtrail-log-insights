variable "custom_trail_name" {
 type = string
 description = "The name of the custom Cloudtrail trail"
}

variable "custom_trail_s3_prefix" {
 type = string
 description = "The S3 prefix in the bucket storing CloudTrail logs"
}

variable "custom_trail_S3_name" {
 type = string
 description = "The name of the S3 bucket storing the custom trail logs"
}

variable "custom_trail_cw_log_group_name" {
 type = string
 description = "The name of the CloudWatch log group to deliver CloudTrail logs"
}

variable "cloudtrail_event_name" {
 type = string
 description = "The cloudtrail event name to search for"
}

variable "security_group_name" {
 type = string
 description = "The name of the security group"
}

variable "sns_topic_name" {
 type = string
 description = "The name of the SNS topic"
}

variable "sns_email" {
 type = string
 description = "The email address subscibing to the SNS topic"
}

variable "lambda_root" {
  type        = string
  description = "The relative path to the source of the lambda"
  default     = "../lambda"
}

variable "dist_root" {
  type        = string
  description = "The relative path to the dist folder"
  default     = "../dist"
}


variable "lambda_filename" {
  type        = string
  description = "The filename containing the Python code for the Lambda"
  default     = "query-log-insights.py"
}

variable "lambda_handler" {
  type        = string
  description = "The handler for the Lambda function"
  default     = "query-log-insights.lambda_handler"
}

variable "lambda_runtime" {
  type        = string
  description = "The runtime for the Lambda function"
  default     = "python3.12"
}

variable "quicksight_S3_name" {
 type = string
 description = "The name of the S3 bucket storing Quicksight Dataset"
}

variable "quicksight_S3_folder" {
 type = string
 description = "The name of the folder in the Quicksight S3 bucket to store the Quicksight Dataset"
}