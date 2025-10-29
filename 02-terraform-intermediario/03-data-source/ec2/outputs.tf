output "id" {
  value = aws_instance.web.id
}

output "ami" {
  value = aws_instance.web.ami
}

output "arn" {
  value = aws_instance.web.arn
}

#pode listar todos esses outputs de uma vez e em json também