output "website-url" {
  value = local.has_domain ? var.domain : module.website.website   # URL do website estático: domínio customizado ou gerado.
}

output "cdn-url" {
  value = aws_cloudfront_distribution.this.domain_name             # URL gerada pelo CloudFront para CDN do site.
}

output "distribution-id" {
  value = aws_cloudfront_distribution.this.id                      # ID da distribuição CloudFront.
}
