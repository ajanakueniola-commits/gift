resource "aws_vpc" "grace" {
  cidr_block = "10.0.0.0/16"

  tags = { Name = "grace-vpc" }
}

resource "aws_internet_gateway" "grace" {
  vpc_id = aws_vpc.grace.id
  tags = { Name = "grace-igw" }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.grace.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true
  tags = { Name = "grace-public-sub" }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.grace.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-2b"
  tags = { Name = "grace-private-sub" }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.grace.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.grace.id
  }

  tags = { Name = "grace-public-rt" }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
