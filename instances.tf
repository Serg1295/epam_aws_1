###############################################################
# WEB Instaces
###############################################################

resource "aws_instance" "EC2_BASTION" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = local.instance_type
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.BASTION.id]
  key_name               = data.aws_key_pair.eu_west_1_key.key_name
  tags = {
    Name = "BASTION"
  }
}
#---------------------------------------------------------------

resource "aws_instance" "EC2_WEB" {
  count = 2
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = local.instance_type
  subnet_id              = module.vpc.private_subnets[count.index + 1]
  vpc_security_group_ids = [aws_security_group.SG_EC2_WEB.id,aws_security_group.EC2_SSH.id]
  user_data              = file("UserData.sh")
  key_name               = data.aws_key_pair.eu_west_1_key.key_name
  tags = {
    Name = "WEB_${count.index + 1}"
  }
}