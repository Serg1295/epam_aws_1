################################################################################
# variables
################################################################################

variable "region" {
  type    = string
  default = "eu-west-1"
}
variable "name" {
  type    = string
  default = "EPAM"
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}