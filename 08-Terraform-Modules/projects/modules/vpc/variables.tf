variable "env" {
  type        = string
  description = "The AWS environment"
}

variable "enable_igw" {
  type        = bool
  description = "Flag to create and attach an internet gateway to the VPC"
  default     = true
}

variable "region" {
  type        = string
  description = "The AWS region"
}

variable "cidr_block" {
  type        = string
  description = "The cidr block for the VPC"
}