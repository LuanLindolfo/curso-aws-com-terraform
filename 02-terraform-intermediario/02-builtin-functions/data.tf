data "template_file" "json" { #gerando o template
  template = file("template.json.tpl") #lê o arquivo

  vars = { #passa esses valores pra dentro do arquivo tipo uma interpolação 
    age    = 33
    eye    = "Brown"
    name   = "Cleber"
    gender = "Male"
  }
}

data "archive_file" "json" {
  type        = local.file_ext
  output_path = "${path.module}/files/${local.object_name}.${local.file_ext}"

  source {
    content  = data.template_file.json.rendered
    filename = "${local.object_name}.json"
  }
}
