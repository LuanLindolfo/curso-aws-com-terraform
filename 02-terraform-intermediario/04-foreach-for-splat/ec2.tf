data "aws_ami" "ubuntu" {
  owners      = ["amazon"]
  most_recent = true
  name_regex  = "ubuntu"

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "this" {
  #cada um é uma instância cada uma com sua particularidade, for each permite a criação vasta em um único bloco de código
  for_each = {
    web = { #each.key
    #each.value abaixo
      name = "Web server"
      type = "t3.medium"
    }
    ci_cd = { #each.key
    #each.value abaixo
      name = "CI/CD server"
      type = "t3.micro"
    }
  }

  ami           = data.aws_ami.ubuntu.id
  instance_type = lookup(each.value, "type", null)

  tags = {
    Project = "Curso AWS com Terraform"
    Name    = "${each.key}: ${lookup(each.value, "name", null)}"
    Lesson  = "Foreach, For, Splat"
  }
}
