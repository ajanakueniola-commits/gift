packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.2.0"
    }
  }
}

variable "aws_region" {
  default = "us-east-2"
}

source "amazon-ebs" "backend" {
  region        = var.aws_region
  instance_type = "c7i-flex.large"
  ssh_username  = "ec2-user"

  ami_name      = "grace-backend-ami-{{timestamp}}"

  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-*-x86_64-gp2"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    owners      = ["amazon"]
    most_recent = true
  }

  tags = {
    Name = "grace-backend-ami"
    Role = "app"
  }
}

build {
  sources = ["source.amazon-ebs.backend"]

  provisioner "shell" {
    inline = [
      "sudo yum update -y",
      "sudo yum install java-17-amazon-corretto -y",
      "sudo yum install git -y",
      "sudo useradd appuser",
      "sudo mkdir -p /opt/app",
      "sudo chown appuser:appuser /opt/app"
    ]
  }
}
