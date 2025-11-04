terraform {
  required_version = "0.14.4"          # Versão mínima requerida do Terraform.

  required_providers {
    aws = {
      source  = "hashicorp/aws"        # Provê o provedor AWS oficial no Terraform Registry.
      version = "3.23.0"               # Versão fixa do provedor AWS para garantir compatibilidade.
    }
  }
}

resource "null_resource" "null" {      # Recurso null_resource que não cria recursos reais na nuvem.
  triggers = {
    time = timestamp()                  # Gatilho que força reexecução do recurso sempre que o timestamp mudar.
  }

  provisioner "local-exec" {            # Provisionador que executa um comando local no host onde o Terraform roda.
    command = "echo $FOO $BAR $BAZ $TIME >> env_vars.txt" # Comando para adicionar variáveis a um arquivo de texto.

    environment = {                    # Define variáveis de ambiente usadas no comando acima.
      FOO = "bar"                     # Exemplo de variável de ambiente string.
      BAR = 1                         # Exemplo de variável de ambiente numérica.
      BAZ = "true"                    # Exemplo de variável booleana em formato string.
      TIME = timestamp()              # Extrai a hora atual para a variável TIME.
    }
  }

  provisioner "local-exec" {           # Segundo provisionador executando comandos locais.
    command = "rm -rf nodejs-app && mkdir nodejs-app && cd nodejs-app && npm init -y && npm install joi"
    # Comandos para apagar a pasta nodejs-app, recriá-la, inicializar um projeto npm e instalar a dependência joi.
  }
}
