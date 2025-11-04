bucket         = "tfstate-968339500772"                      # Nome do bucket S3 para armazenar o state do Terraform.
key            = "03-static-website/terraform.tfstate"       # Caminho/arquivo do state.
region         = "eu-central-1"                              # Região do bucket.
profile        = "tf014"                                     # Perfil AWS CLI para autenticação do Terraform.
dynamodb_table = "tflock-tfstate-968339500772"               # Tabela DynamoDB para gerenciar lock do state.
