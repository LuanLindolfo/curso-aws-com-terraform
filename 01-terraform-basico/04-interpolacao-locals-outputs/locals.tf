#inputs values -> argumentos da função
#outúts values -> retorno da função
#locals values -> para escrever alguma variavel, expressão ou concatenação

locals {
  ip_filepath = "ips.json"

  common_tags = { #locals de tags comuns
    Service     = "Curso Terraform"
    ManagedBy   = "Terraform"
    Environment = var.environment
    Owner       = "Cleber Gasparoto"
  }
}

#pra usar -> local.nome
#pra definir -> locals