resource "aws_instance" "web-server" {
  ami           = var.web-server-ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web-server.id]

  tags = { Name = "grace-web-server" }
}

resource "aws_instance" "backend-server" {
  ami           = var.backend-server-ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.backend-server.id]

  tags = { Name = "grace-backend-server" }
}

resource "aws_instance" "db" {
  ami           = var.backend-server-ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.db.id]

  tags = { Name = "grace-postgres" }
}
