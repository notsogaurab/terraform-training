resource "aws_amplify_app" "example" {
  name              = var.app_name
  repository        = "https://github.com/notsogaurab/frontend"  # Update with your repository URL

  environment_variables = {
    ENV = "dev"
  }
}

### Cognito User Pool

# Cognito User Pool
resource "aws_cognito_user_pool" "example" {
  name = var.userpool_name
}

# Cognito User Pool Client
resource "aws_cognito_user_pool_client" "example" {
  name         = "${var.userpool_name}-client"
  user_pool_id = aws_cognito_user_pool.example.id
  generate_secret = false
}

# Cognito Identity Pool
resource "aws_cognito_identity_pool" "example" {
  identity_pool_name               = var.identity_pool_name
  allow_unauthenticated_identities = false

  cognito_identity_providers {
    client_id   = aws_cognito_user_pool_client.example.id
    provider_name = aws_cognito_user_pool.example.endpoint
  }
}

# IAM Roles for Cognito Identity Pool
resource "aws_iam_role" "unauthenticated" {
  name = "${var.identity_pool_name}-unauthenticated"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = "cognito-identity.amazonaws.com"
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          "StringEquals" = {
            "cognito-identity.amazonaws.com:aud" = aws_cognito_identity_pool.example.id
          }
          "ForAnyValue:StringLike" = {
            "cognito-identity.amazonaws.com:amr" = "unauthenticated"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role" "authenticated" {
  name = "${var.identity_pool_name}-authenticated"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = "cognito-identity.amazonaws.com"
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          "StringEquals" = {
            "cognito-identity.amazonaws.com:aud" = aws_cognito_identity_pool.example.id
          }
          "ForAnyValue:StringLike" = {
            "cognito-identity.amazonaws.com:amr" = "authenticated"
          }
        }
      }
    ]
  })
}

resource "aws_cognito_identity_pool_roles_attachment" "example" {
  identity_pool_id = aws_cognito_identity_pool.example.id

  roles = {
    unauthenticated = aws_iam_role.unauthenticated.arn
    authenticated   = aws_iam_role.authenticated.arn
  }
}
