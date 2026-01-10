variable "aws_region" {
  default = "us-east-2"
}

variable "nginx_ami_id" {}
variable "java_ami_id" {}
variable "python_ami_id" {}

variable "instance_type" {
  default = "c7i-flex.large"
}
variable "admin_ip" {}
variable "vpc_id" {}
variable "public_subnet_id" {}
variable "private_subnet_id" {}
variable "db_username" {
  default = "adminuser"
}
variable "db_password" {}
variable "db_name" {
  default = "giftdb"
}
variable "db_instance_class" {
  default = "db.t4g.micro"
}
variable "db_allocated_storage" {
  default = 20
}
variable "db_engine" {
  default = "mysql"
}
variable "db_engine_version" {
  default = "8.0"
}
