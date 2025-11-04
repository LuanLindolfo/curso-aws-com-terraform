variable "aws_region" {
  type        = string
  description = "Região padrão da AWS"
  default     = "eu-central-1"
}

variable "aws_profile" {
  type        = string
  description = "Perfil AWS CLI para executar comandos Terraform"
  default     = "tf014"
}

variable "domain" {
  type        = string
  description = "Domínio customizado do site. Se vazio, um nome é gerado aleatoriamente."
  default     = ""
}
