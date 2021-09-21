
resource "aws_vpc" "apprentice_vpc" {
  cidr_block            = "172.31.0.0/16"
  enable_dns_support    = "true"
  enable_dns_hostnames  = "true"

  tags =  {
      "Name" = "apprentice-gw-${random_id.random.hex}"
    }
}

resource "random_id" "random" {
  byte_length = 4
}

resource "aws_internet_gateway" "apprentice_gw" {
  vpc_id = aws_vpc.apprentice_vpc.id

  tags = {
      "Name" = "apprentice-gw-${random_id.random.hex}"
    }
}

resource "aws_route" "apprentice_default_route" {
  route_table_id         = aws_vpc.apprentice_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.apprentice_gw.id
}

////////////////////////////
// Subnets

resource "aws_subnet" "apprentice_subnet_a" {
  vpc_id                  = aws_vpc.apprentice_vpc.id
  cidr_block              = "172.31.54.0/24"
  map_public_ip_on_launch = true
  availability_zone = "${var.aws_region}a"

  tags = {
      "Name" = "apprentice-subnet-a-${random_id.random.hex}"
    }
}

resource "aws_security_group" "apprentice" {
  name   = "apprentice-sg-${random_id.random.hex}"
  vpc_id = aws_vpc.apprentice_vpc.id

  tags = {
      "Name" = "apprentice-sg-${random_id.random.hex}"
    }
}

#SSH

resource "aws_security_group_rule" "apprentice_ingress_allow_22_tcp" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.apprentice.id
}

resource "aws_security_group_rule" "apprentice_ingress_allow_80_tcp" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.apprentice.id
}

resource "aws_security_group_rule" "apprentice_ingress_allow_443_tcp" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.apprentice.id
}

resource "aws_security_group_rule" "apprentice_egress_allow_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.apprentice.id
}
