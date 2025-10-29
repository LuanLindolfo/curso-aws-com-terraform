resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id #referenciando o data sendo consumido
  instance_type = var.instance_type
}
