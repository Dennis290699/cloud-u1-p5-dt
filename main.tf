# Configuracion del proveedorde AWS
provider "aws" {
  region = "us-east-1" # Region donde se desplegaran los recursos
}

#Crear SecurityGroup
resource "aws_security_group" "mi-sg-terraform" {
  name = "mi-security-group-windows"
  description = "Prueba"
  vpc_id = "vpc-0666445141ab6fc0e"
  #Regla de entrada SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Regla de salida para HTTP
  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# Declaracion de los recursos de AWS
resource "aws_instance" "mi_instancia_2" {
  ami = "ami-0b5f645abc199e666" #ID de la imagen de Amazon Linux
  instance_type = "t3.medium" #Tipo de la instancia
  key_name = "mi-primera-llaves-dt" #Nombre del archivo de par de llaves de seguridad
  tags = {
    Name = "MiInstanciaTerraformWindows"
  }
  vpc_security_group_ids = [ aws_security_group.mi-sg-terraform.id ] # Asignar security group a la instancia
}