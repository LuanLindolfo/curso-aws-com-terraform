data "aws_ami" "ubuntu" { #consumindo o recurso da ami com o data
  owners      = ["amazon"]
  most_recent = true
  name_regex  = "ubuntu"
}
