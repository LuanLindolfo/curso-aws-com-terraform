output "bucket-name" {
  value = module.bucket.name # Exibe o nome gerado para o primeiro bucket (uso geral).
}

output "bucket-arn" {
  value = module.bucket.arn # Exibe o ARN (Amazon Resource Name) completo do primeiro bucket.
}

output "bucket-website-name" {
  value = module.website.name # Exibe o nome gerado para o bucket do website.
}

output "bucket-website-url" {
  value = module.website.website # Exibe a URL de endpoint do website estático (se o módulo retornar).
}

output "bucket-website-arn" {
  value = module.website.arn # Exibe o ARN do bucket do website.
}

output "bucket-website-files" {
  value = module.website.files # Exibe o caminho dos arquivos que foram carregados para o bucket do website.
}