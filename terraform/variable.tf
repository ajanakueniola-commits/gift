variable "aws_region" {
  default = "us-east-2"
}

variable "web-server-ami_id" {
  description = "AMI ID created by Packer"
}

variable "backend-server-ami_id" {
  description = "AMI ID created by Packer"
}
variable "instance_type" {
  default = "c7i-flex.large"
}

variable "postgres_ami" {
  description = "Postgres AMI ID created by Packer"
}