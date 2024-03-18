/*
  Name:   Question 2: AWS Network with Terraform
  Author: Oliver Collins
*/

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.6.0"

  name = "fortis"
  cidr = "10.0.0.0/16"
  azs  = ["us-east-1a", "us-east-1b"]

  private_subnet_names = ["frontend-private-a, frontend-private-b"]
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]

  public_subnet_names = ["dmz-public-a", "dmz-public-b"]
  public_subnets      = ["10.0.101.0/24", "10.0.102.0/24"]

  database_subnet_names = ["backend-private-a", "backend-private-b"]
  database_subnets      = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway                 = true
  single_nat_gateway                 = true
  create_database_subnet_group       = true
  create_database_subnet_route_table = true
}

module "webapp" {
  source                     = "./modules/webapp"
  vpc_id                     = module.vpc.vpc_id
  public_subnet_ids          = module.vpc.public_subnets
  private_subnet_ids         = module.vpc.private_subnets
  database_subnet_ids        = module.vpc.database_subnets
  database_subnet_group_name = module.vpc.database_subnet_group_name
}
