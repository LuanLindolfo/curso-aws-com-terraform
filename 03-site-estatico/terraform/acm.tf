resource "aws_acm_certificate" "this" {
  count = local.has_domain ? 1 : 0                 # Cria certificado apenas se um domínio foi definido.

  provider = aws.us-east-1                         # ACM requer criação de certificados sempre na região us-east-1 para uso com CloudFront.

  domain_name               = local.domain          # Domínio principal do certificado (exemplo: meu-dominio.com).
  validation_method         = "DNS"                 # Método de validação rápida via entrada DNS.
  subject_alternative_names = ["*.${local.domain}"] # Também cobre todos os subdomínios com wildcard (*.meu-dominio.com).
}

resource "aws_acm_certificate_validation" "this" {
  count = local.has_domain ? 1 : 0                 # Só valida se o certificado foi criado.

  provider = aws.us-east-1

  certificate_arn         = aws_acm_certificate.this[0].arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
  # Valida o certificado cruzando com os registros DNS criados no Route53.
}
