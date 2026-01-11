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

variable "db_name" {
  description = "Name of the database"
}

variable "base-server-ami_id" {
  description = "Base server AMI ID created by Packer"
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

# variable "aws_subnet.grace-private-sub.id" {
#   description = "ID of private subnet"
# }

# variable "aws_subnet.private_b.id" {
#   description = "ID of private subnet B"
# }
variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-2a", "us-east-2b"]
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}