locals { #passando as informações que ta consumindoo o remote state
  instance = {
    id  = data.terraform_remote_state.server.outputs.id
    ami = data.terraform_remote_state.server.outputs.ami
    arn = data.terraform_remote_state.server.outputs.arn
  }
}
