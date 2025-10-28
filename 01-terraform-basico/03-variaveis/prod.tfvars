instance_type = "t3.medium"
environment   = "prod"
instance_tags = {
  Name    = "Ubuntu"
  Project = "Curso AWS com Terraform"
  Env     = "Prod"
}


#aqui pode sobrescrever os valores para máquinas específicas (pode sobrescrever a do ambiente terraform.vars)
#basta rodar usando terraform plan -var-file="prod.tfvars"
#terraform apply -var-file="prod.tfvars"
#ou terraform apply -var-file="prod.tfvars" -auto-approve

#para destruir
#terraform destroy -var-file="prod.tfvars"
#ou terraform destroy -var-file="prod.tfvars" -auto-approve

