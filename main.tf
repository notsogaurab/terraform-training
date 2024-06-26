module "static_website" {
  source = "./modules/services/static_website"
  s3_name = "example.com"
}


module "amplify" {
  source = "./modules/services/amplify"
  identity_pool_name = "example"
  
}

module "lambda" {
  source = "./modules/services/lambda"
}