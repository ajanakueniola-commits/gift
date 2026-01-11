# packer {
#   required_version = ">= 1.9.0"

#   required_plugins {
#     amazon = {
#       source  = "github.com/hashicorp/amazon"
#       version = ">= 1.2.8"
#     }
#   }
# }

# variable "region" {
#   default = "us-east-2"
# }

# variable "db_name" {
#   default = "appdb"
# }

# variable "db_user" {
#   default = "appuser"
# }

# variable "db_password" {
#   default = "StrongPassword123!"
# }

# source "amazon-ebs" "postgres" {
#   region        = var.region
#   instance_type = "c7i-flex.large"
#   ssh_username  = "ec2-user"

#   ami_name      = "grace-postgres-{{timestamp}}"

#   source_ami_filter {
#     filters = {
#       name                = "al2023-ami-*-x86_64"
#       root-device-type    = "ebs"
#       virtualization-type= "hvm"
#     }
#     owners      = ["137112412989"]
#     most_recent = true
#   }
# }

# build {
#   name    = "postgres-db"
#   sources = ["source.amazon-ebs.postgres"]

#   provisioner "shell" {
#     inline = [
#       "sudo dnf update -y",
#       "sudo dnf install -y postgresql15-server postgresql15",

#       "sudo postgresql-setup --initdb",
#       "sudo systemctl enable postgresql",
#       "sudo systemctl start postgresql",

#       # Enable remote connections
#       "sudo sed -i \"s/#listen_addresses = 'localhost'/listen_addresses = '*'/' /var/lib/pgsql/data/postgresql.conf",

#       # Allow network auth
#       "echo \"host all all 0.0.0.0/0 md5\" | sudo tee -a /var/lib/pgsql/data/pg_hba.conf",

#       "sudo systemctl restart postgresql",

#       # Create DB and user
#       "sudo -u postgres psql -c \"CREATE USER ${var.db_user} WITH PASSWORD '${var.db_password}';\"",
#       "sudo -u postgres psql -c \"CREATE DATABASE ${var.db_name} OWNER ${var.db_user};\"",

#       "sudo systemctl restart postgresql"
#     ]
#   }
# }
#     post-processor "manifest" {
#         output = "manifest.json"
#     }
# }

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

variable "db_name" {
  default = "appdb"
}

variable "db_user" {
  default = "appuser"
}

variable "db_password" {
  default = "StrongPassword123!"
}

source "amazon-ebs" "postgres" {
  region        = var.region
  instance_type = "c7i-flex.large"
  ssh_username  = "ec2-user"

  ami_name      = "grace-postgres-{{timestamp}}"

  source_ami_filter {
    filters = {
      name                 = "al2023-ami-*-x86_64"
      root-device-type     = "ebs"
      virtualization-type  = "hvm"
    }
    owners      = ["amazon"]
    most_recent = true
  }
}

build {
  name    = "postgres-db"
  sources = ["source.amazon-ebs.postgres"]

  provisioner "shell" {
    inline = [
      "sudo dnf update -y",
      "sudo dnf install -y postgresql15-server postgresql15",
      "sudo postgresql-setup --initdb",
      "sudo systemctl enable postgresql",
      "sudo systemctl start postgresql",

      # Enable remote connections
      "sudo sed -i \"s/#listen_addresses = 'localhost'/listen_addresses = '*'/' /var/lib/pgsql/data/postgresql.conf",

      # Allow network auth
      "echo \"host all all 0.0.0.0/0 md5\" | sudo tee -a /var/lib/pgsql/data/pg_hba.conf",

      "sudo systemctl restart postgresql",

      # Create DB and user
      "sudo -u postgres psql -c \"CREATE USER ${var.db_user} WITH PASSWORD '${var.db_password}';\"",
      "sudo -u postgres psql -c \"CREATE DATABASE ${var.db_name} OWNER ${var.db_user};\"",

      "sudo systemctl restart postgresql"
    ]
  }

  # Post-processor must be INSIDE build
  post-processor "manifest" {
    output = "manifest.json"
  }
}

    