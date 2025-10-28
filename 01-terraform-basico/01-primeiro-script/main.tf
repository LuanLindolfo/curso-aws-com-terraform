terraform { #deixando fixa a versão do terraform
  required_version = ">= 0.14.4"

  required_providers { #informando o provedor que ta usando
    aws = {
      source  = "hashicorp/aws"
      version = "3.23.0"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
provider "aws" {
  region  = "us-east-1" # Brasil -> us-east-1, tava eu-central-1
  profile = "Terraform" #setando o profile (que eu criei na aws) pra não usar o default que ta setando em outra conta
}
#Pode setar aqui o acess_key e o secret_key junto com o profile
#ou pode setar no terminal com AWS_ACESS_KEY_ID = (valor) AWS_SECRET_ACESS_KEY = (valor)

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#private-bucket-w-tags
resource "aws_s3_bucket" "my-test-bucket" { #nome do bucket
  bucket = "my-tf-test-bucket-123123455745642342342"  #tornando único com o nome
  acl    = "private"

  tags = { #tags que eu coloco (opcionalmente) -> bom para faturamento e exploração de custos
    Name        = "My bucket"
    Environment = "Dev"
    Managedby   = "Terraform"
  }
}
#depois, faz um cd no caminho desse arquivo no terminal do ubuntu
#depois um terraform init

#como o terraform ta na versão 0.14.4, é importante colocar o terraform na versão desejada
#usando o gerenciador de versão tfenv
#tfenv install 0.14.4
#tfenv use 0.14.4

#ou alterar de required_version = "0.14.4" para required_version = ">= 0.14.4"

#Como especifico o profile Terraform aqui (mesmo user que fiz na aws com permissões de admin) configure no cli  o ubuntu, 
#tem que colcoar o profile  Terraform aws configure --profile Terraform

#terraform init (no diretoirio do arquivo pra iniciar)
#terraform plan (pra ver o mapa de planos que vai executar)
#terraform apply (pra aplicar as configurações de criação)

#tfstate é o arquivo responsável por guardar todas as informações de todos os recursos que foram criados nessa pasta
#e sempre que o terraform quiser alterar, configurar ou destruir algo, ele vai analisar esse arquivo e a aws pra alterar, configurar ou destruir
#inclui a arvore de dependência pra saber o que vai rodar primeiro e o que vai rodar depois

#terraform console -> entra no modo interativo podendo pesquisar o valor dos atributos e recursos
#nome_do_recurso.this -> vais listar os atributos do this
#nome_do_recurso.this.nome_do_atributo -> ver um atributo em específico

#content_type -> baixa o arquivo pra ver
#json -> vê no navegador o arquivo