resource "aws_vpc" "grace" {
  cidr_block = "10.0.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "grace-vpc"
  }
}

resource "aws_internet_gateway" "grace" {
  vpc_id = aws_vpc.grace.id

  tags = {
    Name = "grace-igw"
  }
}

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.grace.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "grace-public-sub"
  }
}

# Private Subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.grace.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-2b"

  tags = {
    Name = "grace-private-sub"
  }
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.grace.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.grace.id
  }

  tags = {
    Name = "grace-public-rt"
  }
}

# Attach public subnet to public route table
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.grace.id

  tags = {
    Name = "grace-private-rt"
  }   
}
# Attach private subnet to private route table
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}   

