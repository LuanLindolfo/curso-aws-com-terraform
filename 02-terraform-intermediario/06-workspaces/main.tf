terraform {
  required_version = "0.14.4"          # Versão mínima do Terraform necessária para executar o código.

  required_providers {
    aws = {
      source  = "hashicorp/aws"        # Fonte oficial do provedor AWS no Terraform Registry.
      version = "3.23.0"               # Versão exata do provedor AWS especificada para garantir compatibilidade.
    }
  }

  backend "s3" {                      # Configuração do backend remoto para armazenar o estado do Terraform.
    bucket         = "tfstate-968339500772"           # Nome do bucket S3 onde o estado será salvo.
    key            = "05-workspaces/terraform.tfstate" # Caminho dentro do bucket onde o arquivo de estado será armazenado.
    region         = "eu-central-1"                    # Região AWS onde o bucket S3 está localizado.
    profile        = "tf014"                            # Perfil AWS CLI usado para autenticação.
    dynamodb_table = "tflock-tfstate-968339500772"     # Tabela DynamoDB usada para gerenciamento de lock do estado.
  }
}

provider "aws" {
  region  = lookup(var.aws_region, local.env) # Define a região AWS com base na variável aws_region e ambiente local.
  profile = "tf014"                           # Perfil AWS CLI para autenticação.
}

locals {
  env = terraform.workspace == "default" ? "dev" : terraform.workspace
  # Define a variável local "env" baseada no workspace ativo do Terraform.
  # Se o workspace for "default", usa "dev", senão usa o nome do workspace.
}

resource "aws_instance" "web" {
  count = lookup(var.instance, local.env)["number"] 
  # Cria múltiplas instâncias EC2 com base na quantidade definida para o ambiente atual.

  ami           = lookup(var.instance, local.env)["ami"]         # AMI para a instância, definida por ambiente.
  instance_type = lookup(var.instance, local.env)["type"]        # Tipo da instância AWS, por ambiente.

  tags = {
    Name = "Minha máquina web ${local.env}" # Tag "Name" personalizada com o ambiente.
    Env  = local.env                        # Tag "Env" para indicar o ambiente.
  }
}
