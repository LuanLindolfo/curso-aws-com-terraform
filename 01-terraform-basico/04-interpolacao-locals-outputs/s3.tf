#arquivo do bucket - mtudo aqui nesse arquivo é relacionado ao s3

#interpolação - avalia a expressão passada entre duas marcas (${}!) vai converter, se necessáreio para string
#pode passar uma variável para concatenar ou chamar uma função
#interpolação é concatenar strings com uma expressão

resource "aws_s3_bucket" "this" {
  bucket = "${random_pet.bucket.id}-${var.environment}"
  #pegando a variavel aleatoria que o random pet gera e concatena com o nome do ambiente
  #terraform sabe exatamente a ordem que ele precisa - vai gerar o nome pra poder setar
  tags   = local.common_tags
}

resource "aws_s3_bucket" "manual" {
  bucket = "meubucketcriadonoconsoledaaws123123"

  tags = {
    Criado    = "14/01/2021"
    Importado = "23/01/2021"
    ManagedBy = "Terraform"
  }
}

resource "aws_s3_bucket_object" "this" {
  bucket       = aws_s3_bucket.this.bucket
  key          = "config/${local.ip_filepath}" #concatenando o valor de um local
  source       = local.ip_filepath #aqui o mesmo, mas não precisa colocar dentro de uma expressão
  etag         = filemd5(local.ip_filepath)
  content_type = "application/json"

  tags = local.common_tags
}

resource "aws_s3_bucket_object" "random" {
  bucket       = aws_s3_bucket.this.bucket
  key          = "config/${random_pet.bucket.id}.json"
  source       = local.ip_filepath
  etag         = filemd5(local.ip_filepath)
  content_type = "application/json"

  tags = local.common_tags
}
