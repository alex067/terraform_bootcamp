variable "env" {
  type        = string
  description = "The AWS environment"
}

variable "region" {
  description = "The AWS region"
  type        = string
}

variable "private_subnet_ids" {
  description = "Collection of Private Subnet Ids to deploy EC2 instances"
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_ids) >= 2
    error_message = "Must provide at least two private subnet Ids"
  }
}

variable "public_subnet_ids" {
  description = "Collection of Public Subnet Ids to deploy Load Balancer"
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_ids) >= 2
    error_message = "Must provide at least two public subnet Ids"
  }
}

variable "vpc_id" {
  description = "The VPC Id to deploy resources in"
  type        = string
}