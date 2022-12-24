module "vpc" {
  source = "../modules/vpc"

  env        = local.env
  region     = local.region
  cidr_block = "10.1.0.0/16"
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
      cidr_block        = "10.1.1.0/24"
      availability_zone = "us-west-2a"
    },
    {
      is_public         = true
      name              = "publicB"
      cidr_block        = "10.1.2.0/24"
      availability_zone = "us-west-2b"
    },
    {
      is_public         = false
      name              = "privateA"
      cidr_block        = "10.1.3.0/24"
      availability_zone = "us-west-2a"
    },
    {
      is_public         = false
      name              = "privateB"
      cidr_block        = "10.1.4.0/24"
      availability_zone = "us-west-2b"
    }
  ]
}