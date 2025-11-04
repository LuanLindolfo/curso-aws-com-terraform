# Nome do bucket S3.
variable "name" {
  type        = string
  description = "Bucket name"
}

# ACL (política de acesso); padrão é 'private'.
variable "acl" {
  type        = string
  description = "Access control list for the bucket (default: private)"
  default     = "private"
}

# Política personalizada em JSON.
variable "policy" {
  type        = string
  description = "Custom bucket policy in JSON"
  default     = null
}

# Tags para o bucket.
variable "tags" {
  type        = map(string)
  description = "Map of tags to apply to the bucket"
  default     = {}
}

# Prefixo de chave para objetos do S3.
variable "key_prefix" {
  type    = string
  description = "Prefix for object keys inside the buckets (default: empty)"
  default = ""
}

# Caminho do diretório local com os arquivos a enviar para o bucket.
variable "files" {
  type    = string
  description = "Path to local files to upload to the bucket"
  default = ""
}

# Configuração do website estático, pode incluir index, erro, redirecionamento, etc.
variable "website" {
  description = "Map containing website configuration."
  type        = map(string)
  default     = {}
}

# Configuração de versionamento do bucket.
variable "versioning" {
  description = "Map containing versioning configuration."
  type        = map(string)
  default     = {}
}
