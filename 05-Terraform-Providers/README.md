# Terraform Providers

Providers are plugins, exposing a set of resources objects for you to interact with in Terraform. For example, the AWS Provider exposes AWS resource objects, to provision and manage resources within AWS.

Providers enable Terraform to be extremely extensible and flexible; develop your own custom Providers to fit specific usecases, and enabling your Terraform environment to utilize multi-cloud platforms with ease.

List of officially provided providers:
* https://registry.terraform.io/browse/providers 

Provider configurations are done using the required_providers block, which is nested inside your global terraform block.
```
terraform {
  requried_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
```