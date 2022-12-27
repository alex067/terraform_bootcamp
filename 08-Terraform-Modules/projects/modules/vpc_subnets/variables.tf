variable "env" {
  description = "The AWS environment"
  type        = string

}

variable "region" {
  description = "The AWS region"
  type        = string
}

variable "subnets" {
  type = list(object({
    name              = string
    cidr_block        = string
    is_public         = bool
    availability_zone = string
  }))
}

variable "vpc_id" {
  description = "The VPC ID where the Subnets belong to"
  type        = string
}

variable "private_route_table_id" {
  description = "The Route Table ID for private routing"
  type        = string
}

variable "public_route_table_id" {
  description = "The Route Table ID for public routing"
  type        = string
}