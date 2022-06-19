################################################################################
# VPC Module
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.11.3"

  name = local.name
  cidr = "172.20.0.0/16"

  azs             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  private_subnets = ["172.20.32.0/19", "172.20.64.0/19", "172.20.96.0/19"]
  public_subnets  = ["172.20.0.0/22", "172.20.4.0/22", "172.20.8.0/22"]

  enable_vpn_gateway = true
  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false

  tags = local.tags
}
                      