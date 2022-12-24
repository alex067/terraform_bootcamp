module "vpc" {
  source = "../modules/vpc"

  env        = local.env
  region     = local.region
  cidr_block = "10.8.0.0/16"
}

module "subnets" {
  source = "../modules/vpc_subnets"

  env                    = local.env
  region                 = local.region
  vpc_id                 = module.vpc.vpc_id
  private_route_table_id = module.vpc.private_route_table_id
  public_route_table_id  = module.vpc.public_route_table_id

  subnets = [
    {
      is_public         = true
      name              = "publicA"
      cidr_block        = "10.8.1.0/24"
      availability_zone = "us-east-1a"
    },
    {
      is_public         = true
      name              = "publicB"
      cidr_block        = "10.8.2.0/24"
      availability_zone = "us-east-1b"
    },
    {
      is_public         = false
      name              = "privateA"
      cidr_block        = "10.8.3.0/24"
      availability_zone = "us-east-1a"
    },
    {
      is_public         = false
      name              = "privateB"
      cidr_block        = "10.8.4.0/24"
      availability_zone = "us-east-1b"
    }
  ]
}