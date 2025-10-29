resource "aws_instance" "server" {
  count = local.instance_number <= 0 ? 0 : local.instance_number #contando o numero de instâncias
  #nesse caso, o bloco define a quantidade de instâncias que quer criar

  ami           = var.instance_ami
  instance_type = lookup(var.instance_type, var.env)

  tags = merge(
    local.common_tags,
    {
      Project = "Curso AWS com Terraform"
      Env     = format("%s", var.env)
      Name    = format("Instance %d", count.index + 1)
    }
  )
}
