####################
# AMI Lookup
####################
data "aws_ami" "packer_or_amazon" {
  most_recent = true
  owners      = var.packer_ami_owner != "" ? [var.packer_ami_owner] : ["amazon"]

  filter {
    name   = "name"
    values = var.packer_ami_name_pattern != "" ? [var.packer_ami_name_pattern] : ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "web" {
  ami           = var.web-server-ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web.id]

  tags = { Name = "grace-web-server" }
}

resource "aws_instance" "backend" {
  ami           = var.backend-server-ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.backend.id]

  tags = { 
    Name = "grace-backend-server"
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
resource "aws_instance" "postgres" {
  ami                    = var.ami_id != "" ? var.ami_id : data.aws_ami.packer_or_amazon.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private[0].id
  vpc_security_group_ids = [aws_security_group.grace.id]

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    amazon-linux-extras install -y postgresql13
    systemctl enable postgresql
    systemctl start postgresql
  EOF

  tags = { Name = "postgres-db" }
}
