locals {
  has_domain       = var.domain != ""      # Indica se foi informado um domínio customizado.
  domain           = local.has_domain ? var.domain : random_pet.website.id # Usa domínio customizado ou gera aleatoriamente.
  regional_domain  = module.website.regional_domain_name # Endereço do bucket S3 principal.
  website_filepath = "${path.module}/../website"         # Caminho local para arquivos do site.

  common_tags = {
    Project   = "Curso AWS com Terraform"  # Tag de projeto.
    Service   = "Static Website"           # Tag de serviço.
    CreatedAt = "2020-03-14"               # Data de criação.
    Module    = "3"                        # Módulo identificador.
  }
}
