
terraform {
  required_version = "0.14.4" # Define a versão mínima do Terraform necessária.

  required_providers {
    aws = {
      source  = "hashicorp/aws" # Especifica a fonte (HashiCorp Registry) do provedor AWS.
      version = "3.23.0"        # Define a versão específica do provedor AWS a ser usada.
    }
  }
}

provider "aws" {
  region  = "eu-central-1" # Define a região da AWS onde os recursos serão provisionados (Frankfurt).
  profile = "tf014"        # Especifica o perfil (configurado no seu arquivo AWS CLI) a ser usado para autenticação.
}

# Primeiro bucket (uso geral)

resource "random_pet" "this" {
  length = 5 # Cria um nome aleatório legível (por exemplo, "quick-mouse") com 5 palavras para o primeiro bucket.
}

module "bucket" {
  source = "./s3_module"          # Chama o módulo S3, assumindo que ele está em um diretório chamado "s3_module".
  name   = random_pet.this.id    # Define o nome do bucket com o valor gerado pelo recurso 'random_pet.this'.

  versioning = {
    enabled = true # Configura o versionamento do S3 para ser ativado no bucket.
  }
}

# Segundo bucket (para website estático)

resource "random_pet" "website" {
  length = 5 # Cria um segundo nome aleatório legível para o bucket do website.
}

module "website" {
  source = "./s3_module" # Chama o mesmo módulo S3, reutilizando a lógica.

  name  = random_pet.website.id # Define o nome do bucket com o segundo valor gerado.
  acl   = "public-read"         # Define a Lista de Controle de Acesso para permitir leitura pública dos objetos.
  files = "${path.root}/website" # Indica um caminho local de onde os arquivos serão copiados para o bucket.

  website = {
    index_document = "index.html" # Configura o arquivo de índice para hospedagem de website estático.
    error_document = "error.html" # Configura o arquivo de erro para hospedagem de website estático.
  }

  policy = <<EOT # Define uma política de bucket AWS em formato JSON para acesso público de leitura.
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*", # Permite acesso a qualquer entidade (público).
            "Action": [
                "s3:GetObject" # Ação permitida: ler objetos.
            ],
            "Resource": [
                "arn:aws:s3:::${random_pet.website.id}/*" # O recurso afetado: todos os objetos dentro do bucket recém-criado.
            ]
        }
    ]
}
EOT
}