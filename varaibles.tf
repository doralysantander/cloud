variable "virginia_cidr" {
  description = "CIDR Virginia"
  type        =string
  sensitive   = false


}

# variable "public_subnet"{
#     description = "CIRD public Subnet"
#     type = string
# }
# variable "private_subnet"{
#     description = " CIRD Private Subnet"
#     type = string
# }

variable "subnets" {
  description = "Lista de subnets"
  type        = list(string)
}

variable "tags" {
  description = "Tags del proyecto"
  type        = map(string)

}  
variable "sg_ingress_cidr" {
  description = "cidr for ingress traffic"
  type        = string

}
variable "ec2_specs"{
  description = "Paramentros de la instancia"
  type = map(string)
}

variable "enable_monitoring" {
  description = "Habilitar el despliegue de un servidor de monitoreo monitoreo"
  type        = number
 
}

variable "ingres_port_list"{
  description = "Lista de puertos para el grupo de seguridad"
  type        = list(number)

}
 variable "acess_key"{

 }

  variable "secret_key"{

 }