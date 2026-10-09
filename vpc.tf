resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.virginia_cidr
  #cidr_block = lookup(var.virginia_cidr, terraform.workspace)
  tags = {
    "Name" = "vpc_virginia-${local.sufix}"
  }

}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc_virginia.id
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  tags = {
    "Name" = "public_subnet-${local.sufix}"
  }


}
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc_virginia.id
  cidr_block        = var.subnets[1]
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "private_subnet_1-${local.sufix}"
  }
  depends_on = [aws_subnet.public_subnet]

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_virginia.id

  tags = {
    Name = "igw_vpc virginia-${local.sufix}"
  }
}
#Tabla de enrutameinto
resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.vpc_virginia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public crt-${local.sufix}"
  }
}
#Asociacion de la tabla de enrutamiento con la subred publica
resource "aws_route_table_association" "crta_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_crt.id
}
#Grupo de seguridad para permitir el trafico entrante y saliente
resource "aws_security_group" "sg_public_instance" {
  name        = "Public instance SG"
  description = "Allow TLS inbound traffic and all egress traffic"
  vpc_id      = aws_vpc.vpc_virginia.id

dynamic "ingress"{
      for_each = var.ingres_port_list
      content {
        from_port = ingress.value
        to_port = ingress.value
        protocol = "tcp"
        cidr_blocks = [var.sg_ingress_cidr]
      }
  }

egress {
  from_port         = 0
  protocol       = "-1"
  to_port           = 0
  cidr_blocks        = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
}


  tags = {
    Name = "Public instance SG - ${local.sufix}"
  }
}

module "mybucket" {
    source = "./modulos/s3"
    bucket_name = "nombreunico123"
}


