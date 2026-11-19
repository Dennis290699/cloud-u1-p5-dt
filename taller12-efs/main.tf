#Configurar proveedor
provider "aws" {
  region = var.region
}

#crear grupos de seguridad para instancias
resource "aws_security_group" "mi-sg-instancias-terraform" {
  name        = "mi-security-group-instancias-terraform"
  description = "Prueba desde terraform"
  vpc_id      = "vpc-0666445141ab6fc0e"
  #Regla de entrada SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Regla de salida para HTTP
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

#crear grupos de seguridad para EFS
resource "aws_security_group" "mi-sg-efs-terraform" {
  name        = "mi-security-group-efs-terraform"
  description = "Prueba desde terraform"
  vpc_id      = "vpc-0666445141ab6fc0e"

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    security_groups = [aws_security_group.mi-sg-instancias-terraform.id]
  }
}

# Declaracion de los recursos de AWS
resource "aws_instance" "mi_instancia_efs" {
  ami                    = var.ami_id                                             #ID de la imagen de Amazon Linux
  instance_type          = var.tipo_instancia                                     #Tipo de la instancia
  key_name               = var.nombre_llave                                       #Nombre del archivo de par de llaves de seguridad
  vpc_security_group_ids = [aws_security_group.mi-sg-instancias-terraform.id] # Asignar security group a la instancia
  count                  = var.cantidad_instancias
  tags = {
    Name = "Mi Instancia EFS - ${count.index}"
  }
}
