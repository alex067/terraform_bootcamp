module "bucket" {
    source = "./modules/bucket"

    env = local.env
    region = local.region 
    section = local.section
    course = local.course
}