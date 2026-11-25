# Configurar proveedor
provider "aws" {
  region = var.region
}

# Crear grupos de seguridad para instancias
resource "aws_security_group" "mi-sg-instancias-terraform_14" {
  name        = "mi-security-group-instancias-terraform-14"
  description = "Prueba desde terraform"
  vpc_id      = "vpc-0666445141ab6fc0e"
}

# Crear grupos de seguridad para EFS
resource "aws_security_group" "mi-sg-efs-terraform_14" {
  name        = "mi-security-group-efs-terraform-14"
  description = "Prueba desde terraform"
  vpc_id      = "vpc-0666445141ab6fc0e"
}

# Reglas SG Instancias
## ENTRADA SSH
resource "aws_vpc_security_group_ingress_rule" "entrada_ssh_instancias" {
  security_group_id = aws_security_group.mi-sg-instancias-terraform_14.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = "0.0.0.0/0"
}

## SALIDA a EFS 2049
resource "aws_vpc_security_group_egress_rule" "salida_efs" {
  security_group_id            = aws_security_group.mi-sg-instancias-terraform_14.id
  ip_protocol                  = "tcp"
  from_port                    = 2049
  to_port                      = 2049
  referenced_security_group_id = aws_security_group.mi-sg-efs-terraform_14.id
}

## SALIDA A INTERNET all-traffic
resource "aws_vpc_security_group_egress_rule" "salida_internet" {
  security_group_id = aws_security_group.mi-sg-instancias-terraform_14.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

# Reglas SG EFS
## ENTRADA 2049 desde SG Instancias
resource "aws_vpc_security_group_ingress_rule" "entrada_efs" {
  security_group_id            = aws_security_group.mi-sg-efs-terraform_14.id
  ip_protocol                  = "tcp"
  from_port                    = 2049
  to_port                      = 2049
  referenced_security_group_id = aws_security_group.mi-sg-instancias-terraform_14.id
}

# # Declaracion de los recursos de AWS
# resource "aws_instance" "mi_instancia_efs" {
#   ami                    = var.ami_id
#   instance_type          = var.tipo_instancia
#   key_name               = var.nombre_llave
#   vpc_security_group_ids = [aws_security_group.mi-sg-instancias-terraform_14.id]
#   count                  = var.cantidad_instancias
#   tags = {
#     Name = "Mi Instancia EFS - ${count.index}"
#   }
# }
