# Región de AWS donde se desplegarán los recursos
variable "region" {
  description = "The AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "id de la AMI"
  type        = string
  default     = "ami-0c230065b91270bc6"
}

variable "tipo_instancia" {
  description = "tipo de la instancia"
  type        = string
  default     = "t2.micro"
}

variable "nombre_llave" {
  description = "nombre de la llave"
  type        = string
  default     = "mi-primera-llaves-dt"
}

variable "cantidad_instancias" {
  description = "Cantidad de instancias"
  type        = number
  default     = 2
}
