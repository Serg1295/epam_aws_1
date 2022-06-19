################################################################
# Security group
################################################################
resource "aws_security_group" "ALB_SG" {
  name        = "ALB_SG"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc.vpc_id

  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = local.tags
}
resource "aws_security_group" "BASTION" {
  name        = "BH_SG"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "TLS from * "
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = local.tags
}
resource "aws_security_group" "SG_EC2_WEB" {
  name   = "SG_EC2_WEB"
  vpc_id      = module.vpc.vpc_id

  dynamic "ingress" {
    for_each = ["80"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      security_groups = [aws_security_group.ALB_SG.id]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "SG_EC2"
  }
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_security_group" "EC2_SSH" {
  name        = "EC2_SSH"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "TLS from * "
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = module.vpc.public_subnets_cidr_blocks
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = module.vpc.public_subnets_cidr_blocks
  }

  tags = local.tags
}