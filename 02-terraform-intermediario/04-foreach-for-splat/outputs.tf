output "extensions" { #arquivo mostrando apenas o retorno do arquivo extensions
  value = local.file_extensions
}

output "extensions_upper" {
  value = local.file_extensions_upper
}

output "instance_arns" {
  value = [for k, v in aws_instance.this : v.arn] #k de key e v de value
  #quer extrair os valores de aws_instance.this
}

output "instance_names" {
  value = { for k, v in aws_instance.this : k => v.tags.Name }
}

output "private_ips" {
  value = [for o in local.ips : o.private]
}

output "public_ips" {
  value = local.ips[*].public
}
