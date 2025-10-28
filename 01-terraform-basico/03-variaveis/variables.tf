#código pra aceitar variáveis
#adotando valores (igual ao cloudformation)

variable "environment" {
  type        = string
  description = ""
}

variable "aws_region" {
  type        = string
  description = ""
}

variable "aws_profile" {
  type        = string
  description = ""
  #default = "" -> pra deixar um perfil como default
  #caso não coloque, coloca lá na hora, da pra setar o ambiente de acordo com a aplicação
}

variable "instance_ami" {
  type        = string
  description = ""
}

variable "instance_type" {
  type        = string
  description = ""
}

variable "instance_tags" {
  type        = map(string) #tipo map, já ta no formato esperado das tags
  description = ""
  default = {
    Name    = "Ubuntu"
    Project = "Curso AWS com Terraform"
  }
}

#se usar o -auto-approve ele já roda direto, nao pergunta se quer aplicar

#outra forma de passar variável é passar a variável na frente, ele lê a variável por meio da variável de ambiente
#exemplo: TF_VAR_aws_profile=tf014

#ou com flag, com o exemplo:
#terraform plan -var ="aws_profile=tf014" pode colocar várias
#e nesse caso, sobrescreve o valor que colocou primeiro
#se passar a mesma variável várias vezes, o último sobrescreve o anterior