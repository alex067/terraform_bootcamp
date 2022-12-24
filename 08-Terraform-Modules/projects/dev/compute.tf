module "compute" {
  source = "../modules/compute"

  env                = local.env
  region             = local.region
  private_subnet_ids = module.subnets.private_subnet_ids
  public_subnet_ids  = module.subnets.public_subnet_ids
  vpc_id             = module.vpc.vpc_id
}
