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

source "amazon-ebs" "web-server" {
  region        = var.aws_region
  instance_type = "c7i-flex.large"
  ssh_username  = "ec2-user"

  ami_name      = "grace-web-server-ami-{{timestamp}}"

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
    Name = "grace-web-server-ami"
    Role = "nginx"
  }
}

build {
  sources = ["source.amazon-ebs.web-server"]

  provisioner "shell" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install nginx1 -y",
      "sudo systemctl enable nginx",
      "sudo mkdir -p /usr/share/nginx/html",
      "sudo chown -R nginx:nginx /usr/share/nginx/html",
      "sudo chmod -R 755 /usr/share/nginx/html"
    ]
  }
  
  post-processor "manifest" {
    output = "manifest.json"
  }

  provisioner "file" {
    source      = "nginx.conf"
    destination = "/tmp/default.conf"
  }

  provisioner "shell" {
    inline = [
      "sudo mv /tmp/default.conf /etc/nginx/conf.d/default.conf"
    ]
  }
  
}
