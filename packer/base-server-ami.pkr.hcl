packer {
  required_version = ">= 1.9.0"

  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.2.8"
    }
  }
}

variable "region" {
  default = "us-east-2"
}

source "amazon-ebs" "base" {
  region        = var.region
  instance_type = "c7i-flex.large"
  ssh_username  = "ec2-user"

  ami_name      = "grace-base-ami-{{timestamp}}"

  source_ami_filter {
    filters = {
      name                 = "amzn2-ami-hvm-*-x86_64-gp2"
      root-device-type     = "ebs"
      virtualization-type = "hvm"
    }
    owners      = ["amazon"]
    most_recent = true
  }

  tags = {
    Name = "grace-base-ami"
    Role = "base"
  }
}

build {
  name    = "grace-base-build"
  sources = ["source.amazon-ebs.base"]

  provisioner "shell" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y python3 git",
      "sudo amazon-linux-extras enable docker",
      "sudo yum install -y docker",
      "sudo systemctl enable docker",
      "sudo systemctl start docker"
    ]
  }

  # Terraform will read this
  post-processor "manifest" {
    output = "manifest.json"
  }
}
