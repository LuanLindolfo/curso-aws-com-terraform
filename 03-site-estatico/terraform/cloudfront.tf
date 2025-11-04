resource "aws_cloudfront_origin_access_identity" "this" {
  comment = local.domain      # Identificador de acesso do CloudFront à origem S3.
}

resource "aws_cloudfront_distribution" "this" {
  enabled             = true                 # Distribuição ativa.
  is_ipv6_enabled     = true                 # Suporte IPv6.
  comment             = "Managed by Terraform"
  default_root_object = "index.html"         # Página inicial servida por padrão.
  aliases             = local.has_domain ? [local.domain] : [] # Domínio personalizado (se definido).

  logging_config {
    bucket          = module.logs.domain_name
    prefix          = "cnd/"
    include_cookies = true                   # Armazena logs de acesso, caso ativado.
  }

  default_cache_behavior {
    allowed_methods        = ["HEAD", "GET", "OPTIONS"]  # Métodos permitidos.
    cached_methods         = ["HEAD", "GET"]              # Métodos cacheáveis.
    target_origin_id       = local.regional_domain         # ID do bucket/origem S3.
    viewer_protocol_policy = "redirect-to-https"           # Obriga acesso via HTTPS.
    min_ttl                = 0
    default_ttl            = 3600         # Cache padrão: 1h.
    max_ttl                = 86400        # Cache máximo: 1d.

    forwarded_values {
      query_string = false    # Não encaminha query string.
      headers      = ["Origin"]
      cookies {
        forward = "none"      # Não encaminha cookies.
      }
    }
  }

  origin {
    domain_name = local.regional_domain     # Origem: bucket S3 do site estático.
    origin_id   = local.regional_domain

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
      # CloudFront só acessa o bucket através dessa identidade, aumentando a segurança.
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"             # Disponível globalmente.
    }
  }

  dynamic "viewer_certificate" {
    for_each = local.has_domain ? [] : [0]  # Usar certificado padrão se não houver domínio customizado.
    content {
      cloudfront_default_certificate = true
    }
  }

  dynamic "viewer_certificate" {
    for_each = local.has_domain ? [0] : []  # Usar ACM customizado se houver domínio.
    content {
      acm_certificate_arn = aws_acm_certificate.this[0].arn
      ssl_support_method  = "sni-only"
    }
  }

  tags = local.common_tags                  # Tags comuns do projeto.
}
