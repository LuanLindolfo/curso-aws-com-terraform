# Cria o bucket S3 principal, utilizando valores das variáveis do módulo.
resource "aws_s3_bucket" "this" {
  bucket = var.name           # Define o nome do bucket pelo valor recebido na variável.
  acl    = var.acl            # Define a política de acesso (ACL), recebida via variável.
  policy = var.policy         # Aplica uma política personalizada no bucket (JSON).
  tags   = var.tags           # Adiciona tags ao bucket.

  # Bloco dinâmico para configuração de website estático, caso o mapa 'website' tenha valores.
  dynamic "website" {
    for_each = length(keys(var.website)) == 0 ? [] : [var.website] # Só cria o bloco se a variável não estiver vazia.
    content {
      index_document           = lookup(website.value, "index_document", null)           # Nome do arquivo index.
      error_document           = lookup(website.value, "error_document", null)           # Nome do arquivo de erro.
      redirect_all_requests_to = lookup(website.value, "redirect_all_requests_to", null) # Redirecionamento global (se definido).
      routing_rules            = lookup(website.value, "routing_rules", null)            # Regras de roteamento (opcional).
    }
  }

  # Bloco dinâmico para configuração de versionamento do bucket.
  dynamic "versioning" {
    for_each = length(keys(var.versioning)) == 0 ? [] : [var.versioning] # Só cria se houver configuração.
    content {
      enabled    = lookup(versioning.value, "enabled", null)    # Ativa/desativa o versionamento.
      mfa_delete = lookup(versioning.value, "mfa_delete", null) # (Opcional) Requer MFA para deletar versões.
    }
  }
}

# Cria objetos dentro do bucket para cada arquivo encontrado no diretório passado em 'files'.
module "objects" {
  source = "./s3_object"  # Usa módulo interno para criação dos objetos S3.

  for_each = var.files != "" ? fileset(var.files, "**") : [] # Percorre todos os arquivos do diretório passado.

  bucket = aws_s3_bucket.this.bucket # Nome do bucket onde arquivos serão criados.
  key    = "${var.key_prefix}/${each.value}" # Caminho (key) do arquivo dentro do bucket.
  src    = "${var.files}/${each.value}"     # Caminho local do arquivo a ser enviado.
}
