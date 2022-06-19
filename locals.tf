################################################################################
# Locals
################################################################################

locals {
  name               = var.name
  region             = var.region
  instance_type      = var.instance_type

  tags = {
    Name = local.name
  }
}     