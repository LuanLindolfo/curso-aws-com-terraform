data "template_file" "s3-public-policy" {
  template = file("policy.json")                         # Carrega template JSON de política.
  vars = {
    bucket_name = local.domain                           # Substitui variável pelo nome do bucket.
    cdn_oai     = aws_cloudfront_origin_access_identity.this.id # Substitui pelo Origin Access Identity do CloudFront.
  }
}

module "logs" {
  source        = "github.com/chgasparoto/terraform-s3-object-notification" # Reutiliza módulo para bucket de logs.
  name          = "${local.domain}-logs"
  acl           = "log-delivery-write"
  force_destroy = !local.has_domain
  tags          = local.common_tags
}

module "website" {
  source        = "github.com/chgasparoto/terraform-s3-object-notification" # Módulo para bucket do site estático.
  name          = local.domain
  acl           = "public-read"
  policy        = data.template_file.s3-public-policy.rendered              # Aplica política para acesso pelo CloudFront.
  force_destroy = !local.has_domain
  tags          = local.common_tags

  versioning = {
    enabled = true
  }

  filepath = "${local.website_filepath}/build"              # Caminho dos arquivos do build React.
  website = {
    index_document = "index.html"
    error_document = "index.html"
  }

  logging = {
    target_bucket = module.logs.name
    target_prefix = "access/"
  }
}

module "redirect" {
  source        = "github.com/chgasparoto/terraform-s3-object-notification" # Módulo para redirecionamento www.
  name          = "www.${local.domain}"
  acl           = "public-read"
  force_destroy = !local.has_domain
  tags          = local.common_tags

  website = {
    redirect_all_requests_to = local.has_domain ? var.domain : module.website.website
  }
}
