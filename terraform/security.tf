resource "aws_security_group" "web" {
  vpc_id = aws_vpc.grace.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "backend" {
  name   = "grace-backend-sg"
  vpc_id = aws_vpc.grace.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "db" {
  name   = "grace-db-sg"
  vpc_id = aws_vpc.grace.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # PostgreSQL (private access only)
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  tags = { Name = "grace-sg" }
}

resource "aws_subnet" "public" {
  count                   = 1
  vpc_id                  = aws_vpc.grace.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true
  tags = { Name = "grace-public-sub-${count.index}" }
}

resource "aws_subnet" "private" {
  count             = 1
  vpc_id            = aws_vpc.grace.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.azs[count.index]
  tags = { Name = "grace-private-sub-${count.index}" }
}






# resource "aws_security_group" "backend" {
#   vpc_id = aws_vpc.grace.id

#   ingress {
#     from_port       = 5000
#     to_port         = 5000
#     protocol        = "tcp"
#     security_groups = [aws_security_group.backend.id]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# resource "aws_security_group" "db" {
#   vpc_id = aws_vpc.grace.id

#   ingress {
#     from_port       = 5432
#     to_port         = 5432
#     protocol        = "tcp"
#     security_groups = [aws_security_group.db.id]
#   }

#     egress {
#         from_port   = 0
#         to_port     = 0
#         protocol    = "-1"
#         cidr_blocks = ["0.0.0.0/0"]
#   }
# }

resource "aws_db_subnet_group" "grace" {
  name = "grace-db-subnet-group"

  subnet_ids = [
    aws_subnet.grace_private_subnet_a.id,

  ]

  tags = {
    Name = "Grace DB subnet group"
  }
}
