# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

# Subnets Públicas
resource "aws_subnet" "subrede-publica1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    Name                                    = "subrede-publica1"
    "kubernetes.io/role/elb"                = "1"
    "kubernetes.io/cluster/EKS-AQUARELA-01" = "owned"
  }
}

resource "aws_subnet" "subrede-publica2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = true

  tags = {
    Name                                    = "subrede-publica2"
    "kubernetes.io/role/elb"                = "1"
    "kubernetes.io/cluster/EKS-AQUARELA-01" = "owned"
  }
}

# Route Table para Subnets Públicas
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Associação Route Table - Subnet Pública 1
resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.subrede-publica1.id
  route_table_id = aws_route_table.public.id
}

# Associação Route Table - Subnet Pública 2
resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.subrede-publica2.id
  route_table_id = aws_route_table.public.id
}

# Subnets Privadas (mantidas para uso futuro)
resource "aws_subnet" "subrede-privada1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name                                    = "subrede-privada1"
    "kubernetes.io/role/internal-elb"       = "1"
    "kubernetes.io/cluster/EKS-AQUARELA-01" = "owned"
  }
}

resource "aws_subnet" "subrede-privada2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-2b"

  tags = {
    Name                                    = "subrede-privada2"
    "kubernetes.io/role/internal-elb"       = "1"
    "kubernetes.io/cluster/EKS-AQUARELA-01" = "owned"
  }
}
