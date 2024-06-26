variable "region" {
  description = "The AWS region to deploy to"
  default     = "us-east-1"
}

variable "app_name" {
  description = "The name of the Amplify application"
  default     = "my-amplify-app"
}

variable "auth_domain" {
  description = "The domain prefix for Cognito"
  default     = "myapp-auth"
}

variable "userpool_name" {
  description = "The name of the Cognito user pool"
  default     = "my-user-pool"
}

variable "identity_pool_name" {
  description = "The name of the Cognito identity pool"
  default     = "my-identity-pool"
}
