# Output: Nome (id) do bucket provisionado.
output "name" {
  value = aws_s3_bucket.this.id
}

# Output: ARN (Amazon Resource Name) do bucket provisionado.
output "arn" {
  value = aws_s3_bucket.this.arn
}

# Output: Endpoint de website estático, se configurado no bucket.
output "website" {
  value = aws_s3_bucket.this.website_endpoint
}

# Output: Nome regional do domínio do bucket.
output "regional_domain_name" {
  value = aws_s3_bucket.this.bucket_regional_domain_name
}

# Output: Nome do domínio global do bucket.
output "domain_name" {
  value = aws_s3_bucket.this.bucket_domain_name
}

# Output: Domínio do website público do bucket.
output "website_domain" {
  value = aws_s3_bucket.this.website_domain
}

# Output: Hosted zone ID usado pelo bucket para DNS.
output "hosted_zone_id" {
  value = aws_s3_bucket.this.hosted_zone_id
}

# Output: Lista dos arquivos que foram enviados para o bucket.
output "files" {
  value = [for filename, data in module.objects : filename]
}
