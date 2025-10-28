terraform {
  required_version = "0.14.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.23.0"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs#environment-variables
provider "aws" {
  region  = "eu-central-1" # Recomendo a região us-east-1 se você estiver no Brasil
  profile = "tf014"        # Usar este atributo somente se não for o profile "default" no arquivo ~/.aws/credentials
}

# terraform validate
# terraform fmt
# terraform plan -out="tfplan.out"
# terraform destroy
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#private-bucket-w-tags
resource "aws_s3_bucket" "my-test-bucket" {
  bucket = "my-tf-test-bucket-123123455745642342342"
  acl    = "private"

  tags = {
    Name        = "My first Terraform bucket"
    Environment = "Dev"
    ManagedBy   = "Terraform"
    Owner       = "Cleber Gasparoto" #adicionado
    CreatedAt   = "2021-01-14" #adicionado
  }
}

#alterando primeiro as tags e o bucket vai ser alterado sem ser recriado
#adicionou as tags
#no terminal entrou na pasta atual - para ver se a reconfiguração é válida usa:
#terraform validate

#terraform fmt -> formata para a validação

#no plan passa uma flag -> terraform plan -out"tfplan.out"
#terraform escreve nesse arquivo o output do terraform plan
#pode executar utilizando esse arquivo com o apply
