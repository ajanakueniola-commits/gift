variable "aws_region" {
  default = "us-east-2"
}

variable "nginx_ami_id" {}
variable "python_ami_id" {}

variable "instance_type" {
  default = "c7i-flex.large"
}
