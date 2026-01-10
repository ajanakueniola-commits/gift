resource "aws_instance" "web" {
  ami           = var.web-server-ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web.id]

  tags = { Name = "grace-web" }
}

resource "aws_instance" "app" {
  ami           = var.backend-server-ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.app.id]

  tags = { Name = "grace-app" }
}

resource "aws_instance" "db" {
  ami           = var.backend-server-ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.db.id]

  tags = { Name = "grace-postgres" }
}
