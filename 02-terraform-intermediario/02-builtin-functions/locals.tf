locals { #calcula a quantidade de instâncias que vai precisar
  instance_number = lookup(var.instance_number, var.env)#verifica o objeto de numero de instancia
  #e olha o valor da chave baseado na variável de ambiente
  

  file_ext    = "zip"
  object_name = "meu-arquivo-gerado-de-um-template"

  common_tags = {
    "Owner" = "Cleber Gasparoto"
    "Year"  = "2021"
  }
}
