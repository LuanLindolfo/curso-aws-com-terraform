#arquivo específico para variáveis de terraform

aws_region    = "eu-central-1"
aws_profile   = "tf014"
instance_ami  = "ami-03c3a7e4263fd998c"
instance_type = "t3.micro"

#usa terraform fmt pra formatar

#a extensão .tfvars o terraform lê automaticamente, não precisa passar pro comando

#aqui pode sobrescrever os valores para máquinas específicas (pode sobrescrever a do ambiente prod.vars)
#basta rodar usando terraform plan -var-file="terraform.tfvars"
#terraform apply -var-file="terraform.tfvars"
#ou terraform apply -var-file="terraform.tfvars" -auto-approve

#para destruir
#terraform destroy -var-file="terraform.tfvars"
#ou terraform destroy -var-file="terraform.tfvars" -auto-approve

