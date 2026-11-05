module "compute" {
  source             = "./modules/compute"
  instance_type      = var.instance_type
  ami_id             = var.ami_id
  name               = var.name
  private_subnet_ids = module.network.private_subnet_ids
  vpc_id             = module.network.vpc_id
  alb_sg_id          = module.alb.alb_sg_id
  target_group_arn   = module.alb.alb_target_group_arn
}

module "network" {
  source             = "./modules/network"
  name               = var.network_name
  single_nat_gateway = var.environment == "dev"
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
  asg_sg_id         = module.compute.asg_sg_id
}