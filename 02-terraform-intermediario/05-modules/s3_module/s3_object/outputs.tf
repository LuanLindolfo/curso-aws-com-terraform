# Output: Nome/chave do objeto criado no bucket S3.
output "key" {
  value = aws_s3_bucket_object.this.key
}

# Output: Caminho do bucket onde o objeto foi criado.
output "bucket" {
  value = aws_s3_bucket_object.this.bucket
}

# Output: ETag do objeto, útil para verificação de integridade.
output "etag" {
  value = aws_s3_bucket_object.this.etag
}

# Output: Content-Type usado no objeto.
output "content_type" {
  value = aws_s3_bucket_object.this.content_type
}
