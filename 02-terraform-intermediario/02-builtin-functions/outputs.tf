output "instance_public_ips" {
  value = aws_instance.server.*.public_ip #* pra acessar o array pro terraform conseguir acessar os valores que foram gerados
}

output "instance_names" {
  value = join(", ", aws_instance.server.*.tags.Name)
}
