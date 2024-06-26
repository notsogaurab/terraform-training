variable "region" {
  description = "The AWS region to deploy to"
  default     = "us-east-1"
}

variable "lambda_function_name" {
  description = "The name of the Lambda function"
  default     = "my-lambda-function"
}

variable "api_name" {
  description = "The name of the API Gateway"
  default     = "my-api-gateway"
}
