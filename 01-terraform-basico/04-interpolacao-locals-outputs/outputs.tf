#pode usar quando tiver usando um módulo 
#quando quer acessar algo da tela - ex: output do apply
#ou quando acessar algo do remote state

output "bucket_name" {
  value = aws_s3_bucket.this.bucket
}

#arn -> valor de identificação dentro da aws
output "bucket_arn" {
  value       = aws_s3_bucket.this.arn
  description = ""
}

output "bucket_domain_name" {
  value = aws_s3_bucket.this.bucket_domain_name
}

output "ips_file_path" {
  #exibindo o caminho todo, vai usar a interpolação com dois valores
  value = "${aws_s3_bucket.this.bucket}/${aws_s3_bucket_object.this.key}"
}

#quando, por exemplo, usar o apply com o output, vai gerar as informações acima, sendo necessárei
#saber quando criar (vai fazer o ouput do valor)