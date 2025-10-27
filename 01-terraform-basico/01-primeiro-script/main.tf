terraform {
  required_version = ">= 0.14.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.23.0"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
provider "aws" {
  region  = "us-east-1" # Brasil -> us-east-1, tava eu-central-1
  profile = "Terraform" #setando o profile (que eu criei na aws) pra não usar o default que ta setando em outra conta
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#private-bucket-w-tags
resource "aws_s3_bucket" "my-test-bucket" { #nome do bucket
  bucket = "my-tf-test-bucket-123123455745642342342"  #tornando único com o nome
  acl    = "private"

  tags = { #tags que eu coloco (opcionalmente) -> bom para faturamento e exploração de custos
    Name        = "My bucket"
    Environment = "Dev"
    Managedby   = "Terraform"
  }
}
#depois, faz um cd no caminhod ese arquivo no terminal do ubuntu
#depois um terraform init

#como o terraform ta na versão 0.14.4, é importante colocar o terraform na versão desejada
#usando o gerenciador de versão tfenv
#tfenv install 0.14.4
#tfenv use 0.14.4

#ou alterar de required_version = "0.14.4" para required_version = ">= 0.14.4"

#Como especifico o profile Terraform aqui (mesmo user que fiz na aws com permissões de admin) configure no cli  o ubuntu, 
#tem que colcoar o profile  Terraform aws configure --profile Terraform