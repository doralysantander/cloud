variable "instancias"{
  description = "Nombre de las instancias"
  type = list(string)
  default = ["apache"]
}
resource "aws_instance" "mywebserver" {
 #for_each = var.instancias #por cada elemento de la lista se crea una instancia
  for_each = toset(var.instancias)# convietirndo lista a un set
   ami                                  = var.ec2_specs.ami
   instance_type                        = var.ec2_specs.instance_type
   key_name                             = data.aws_key_pair.key.key_name
   vpc_security_group_ids               = [aws_security_group.sg_public_instance.id]
   user_data = file("scripts/userdata.sh")
   subnet_id                            = aws_subnet.public_subnet.id
    tags                                 = {
        "Name" = "${each.value}-${local.sufix}"
    }
}


resource "aws_instance" "monitoring_instance" {
  count = var.enable_monitoring == 1 ? 1 : 0 # si da true toma valor 1 y crea la instancia, si es false no crea la instancia
   ami                                  = var.ec2_specs.ami
   instance_type                        = var.ec2_specs.instance_type
   key_name                             = data.aws_key_pair.key.key_name
   vpc_security_group_ids               = [aws_security_group.sg_public_instance.id]
   user_data = file("scripts/userdata.sh")
   subnet_id                            = aws_subnet.public_subnet.id
    tags                                 = {
        "Name" = "Monitoreo"
    }
}



