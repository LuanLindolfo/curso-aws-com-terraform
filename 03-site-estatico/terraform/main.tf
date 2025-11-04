terraform {
  required_version = "0.14.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"    # Provedor AWS.
      version = "3.32.0"
    }
    random = {
      source  = "hashicorp/random" # Provedor random para gerar nomes únicos.
      version = "3.1.0"
    }
    template = {
      source  = "hashicorp/template" # Provedor para manipular templates/dados.
      version = "2.2.0"
    }
  }
  backend "s3" {}                  # Usa o backend remoto, configurado via backend.hcl.
}

provider "aws" {
  region  = var.aws_region         # Região padrão (exemplo: eu-central-1).
  profile = var.aws_profile        # Perfil AWS CLI.
}

provider "aws" {
  region  = "us-east-1"            # Região sempre necessária para ACM usado pelo CloudFront.
  profile = var.aws_profile
  alias   = "us-east-1"
}

resource "random_pet" "website" {
  length = 5                       # Gera nome aleatório se não houver domínio customizado.
}
