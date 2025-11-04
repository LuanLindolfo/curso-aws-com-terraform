# Mapa de regiões AWS para diferentes ambientes.
# Usado para definir a região onde os recursos serão criados conforme o workspace.
variable "aws_region" {
  type = map(string)                         # Tipo: mapa com chaves string e valores string.
  description = "Mapa de regiões da AWS para diferentes ambientes"
  default = {
    dev  = "eu-central-1"                    # Região padrão para o ambiente de desenvolvimento.
    prod = "eu-central-1"                    # Região padrão para o ambiente de produção.
  }
}

# Mapa contendo configurações para instâncias AWS EC2, separado por ambiente.
variable "instance" {
  type = map(object({                        # Tipo complexo para definir número, AMI e tipo da instância.
    number = number                         # Quantidade de instâncias a criar.
    ami    = string                         # ID da AMI a ser usada.
    type   = string                         # Tipo da instância (exemplo: t2.micro).
  }))
  description = "Configurações das instâncias por ambiente"
  default = {
    dev = {
      number = 1                            # Um servidor na dev.
      ami    = "ami-0abcdef1234567890"     # Exemplo de AMI para dev.
      type   = "t2.micro"                   # Tipo pequeno para dev.
    }
    prod = {
      number = 3                            # Três servidores na prod.
      ami    = "ami-0abcdef1234567890"     # Mesma AMI (ou diferente) para prod.
      type   = "t3.medium"                  # Tipo maior para produção.
    }
  }
}
