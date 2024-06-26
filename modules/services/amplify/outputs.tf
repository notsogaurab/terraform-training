output "amplify_app_id" {
  value = aws_amplify_app.example.id
}

output "cognito_user_pool_id" {
  value = aws_cognito_user_pool.example.id
}

output "cognito_user_pool_client_id" {
  value = aws_cognito_user_pool_client.example.id
}

output "cognito_identity_pool_id" {
  value = aws_cognito_identity_pool.example.id
}
