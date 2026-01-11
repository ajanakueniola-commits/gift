####################
# AMI Lookup
####################
data "local_file" "base_manifest" {
  filename = "${path.module}/../packer/manifest.json"
}

locals {
  base_ami_raw = jsondecode(data.local_file.base_manifest.content).builds[0].artifact_id
  base_ami_id  = split(":", local.base_ami_raw)[1]
}


resource "aws_instance" "web" {
  ami           = local.base_ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web.id]

  tags = { Name = "grace-web-server" }
}

resource "aws_instance" "backend" {
  ami           = local.base_ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.app.id]

  tags = {
    Name = "grace-backend-server"
  }
}

resource "aws_instance" "postgres" {
  ami           = local.base_ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.postgres.id]

user_data = <<-EOF
    #!/bin/bash
    yum update -y
    amazon-linux-extras install -y postgresql13
    systemctl enable postgresql
    systemctl start postgresql

  EOF
  tags = { 
    Name = "grace-postgres-db"
  }
}

# resource "aws_instance" "db" {
#   ami           = var.postgres_ami
#   instance_type = "c7i-flex.large"
#   subnet_id     = aws_subnet.private.id
#   vpc_security_group_ids = [aws_security_group.db.id]

#   tags = {
#     Name = "grace-postgres-db"
#   }
# }

####################
# PostgreSQL Instance (Private)
####################
# resource "aws_instance" "postgres" {
#   ami                    = var.ami_id != "" ? var.ami_id : data.aws_ami.packer_or_amazon.id
#   instance_type          = var.instance_type
#   subnet_id              = aws_subnet.private[0].id
#   vpc_security_group_ids = [aws_security_group.grace.id]

#   user_data = <<-EOF
#     #!/bin/bash
#     yum update -y
#     amazon-linux-extras install -y postgresql13
#     systemctl enable postgresql
#     systemctl start postgresql
#   EOF

#   tags = { Name = "postgres-db" }
# }
