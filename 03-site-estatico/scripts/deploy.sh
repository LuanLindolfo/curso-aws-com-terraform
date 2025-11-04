#!/bin/sh

set -e                                 # Faz o script parar se qualquer comando falhar.

cd "${0%/*}" || return                 # Garante que o script execute a partir de seu próprio diretório.

DOMAIN=""                              # Inicializa variável DOMAIN.

if [ "$1" != "" ]; then
  DOMAIN="$1"                          # Se passado como argumento, usa o domínio informado.
fi

echo "----------------------------------------"
echo "Creating an optimized production React App build..."

cd ../website || return                # Entra no diretório do site React.
npm ci                                 # Instala dependências usando package-lock.json para build reprodutível.
npm run build                          # Executa o build otimizado de produção do React.

echo "----------------------------------------"

cd ../terraform || return              # Volta para o diretório Terraform.
echo "Formatting terraform files"
terraform fmt -recursive               # Formata todos os arquivos Terraform recursivamente.

echo "----------------------------------------"

echo "terraform init -backend=true -backend-config=backend.hcl"
terraform init -backend=true -backend-config="backend.hcl"     # Inicializa o backend remoto do Terraform.

echo "----------------------------------------"

echo "Validating terraform files"
terraform validate                     # Valida todos os arquivos Terraform.

echo "----------------------------------------"

echo "Planning..."
terraform plan -var="domain=$DOMAIN" -out="plan.tfout"         # Gera um plano Terraform com a variável de domínio.

echo "----------------------------------------"

echo "Applying..."
terraform apply plan.tfout              # Aplica o plano gerado acima.

echo "----------------------------------------"

echo "Cleaning up plan file"
rm -rf plan.tfout                       # Remove o arquivo do plano após uso.

echo "----------------------------------------"
