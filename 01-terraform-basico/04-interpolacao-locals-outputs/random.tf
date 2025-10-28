#gera nome aleatório pra criar o bucket
#length -> argumento de tamanho

resource "random_pet" "bucket" {
  length = 5
}
