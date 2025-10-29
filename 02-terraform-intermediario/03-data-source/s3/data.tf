data "terraform_remote_state" "server" { #consumindo informações do remote state
  backend = "s3"

  config = { #usando variáveis pois não tá no bloco de terraform
  #especificando o s3 que vai ser consumido
    bucket  = "tfstate-968339500772"
    key     = "dev/03-data-sources-s3/terraform.tfstate"
    region  = var.aws_region
    profile = var.aws_profile
  }
}
