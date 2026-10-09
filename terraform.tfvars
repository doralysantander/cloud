virginia_cidr = "10.10.0.0/16"
# public_subnet =  "10.10.0.0/24"
# private_subnet = "10.10.1.0/24"
# virginia_cidr = {
#   "prod" = "10.10.0.0/16"
#   "dev" = "172.16.0.0/16"

# }


subnets = ["10.10.0.0/24", "10.10.1.0/24"]
tags = {
  "env"         = "dev"
  "owner"       = "Doraly"
  "cloud"       = "AWS"
  "IAC"         = "Terraform"
  "AIC_Version" = "v1.14.8"
  "project" = "cerberus"
  region = "virginia"
}
sg_ingress_cidr = "0.0.0.0/0"

ec2_specs = {
  "ami" = "ami-0332d564d76dbd8d6"
  "instance_type" = "t3.micro"

}
enable_monitoring = 0
ingres_port_list = [22, 80, 443]