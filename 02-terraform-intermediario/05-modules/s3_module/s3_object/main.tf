# Cria um objeto dentro de um bucket S3 usando as configurações fornecidas como variáveis.
resource "aws_s3_bucket_object" "this" {
  bucket       = var.bucket # Nome do bucket onde o objeto será criado (recebido como variável).
  key          = var.key    # Caminho/chave do objeto dentro do bucket (recebido como variável).
  source       = var.src    # Caminho do arquivo local que será enviado para o bucket.
  etag         = filemd5(var.src) # Gera o ETag usando o hash MD5 do arquivo local (para controle de integridade).
  content_type = lookup(var.file_types, regex("\\.[^\\.]+\\z", var.src), var.default_file_type) 
  # Define o Content-Type do objeto enviado de acordo com a extensão do arquivo.
  # Busca na variável file_types pelo tipo correspondente à extensão.
  # Caso não encontre, usa o default_file_type fornecido.
}
