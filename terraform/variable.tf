variable "aws_region" {
  default = "us-east-2"
}

variable "web-server-ami_id" {
  description = "AMI ID created by Packer"
}

variable "backend-server-ami_id" {
  description = "AMI ID created by Packer"
}

variable "postgres-server-ami_id" {
  description = "AMI ID created by Packer"
}

variable "instance_type" {
  default = "c7i-flex.large"
}

  variable "postgres_ami" {
    description = "Postgres AMI ID created by Packer"
  }

variable "db_name" {
  description = "Name of the database"
}

variable "db_username" {
  description = "Username for the database"
}
variable "db_password" {
  description = "Password for the database"
}

variable "ami_id" {
  description = "Optional explicit AMI ID to use"
  default     = ""
}

variable "packer_ami_name_pattern" {
  description = "AMI name pattern if using a Packer-built AMI"
  default     = ""
}

variable "packer_ami_owner" {
  description = "AMI owner ID if using Packer-built AMI"
  default     = ""
}