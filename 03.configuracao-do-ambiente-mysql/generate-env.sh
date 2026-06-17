#!/bin/bash
# generate-env.sh
# Gera o arquivo .env com usuário, senha e nome do banco de dados
# para ser usado pelo docker-compose.yml

set -e

ENV_FILE=".env"

# Função para gerar senha aleatória forte
gen_password() {
  openssl rand -base64 18 | tr -d '/+=' | cut -c1-20
}

# Se já existir um .env, pergunta antes de sobrescrever
if [ -f "$ENV_FILE" ]; then
  read -p "Arquivo $ENV_FILE já existe. Sobrescrever? [s/N]: " resp
  resp=${resp,,} # minúsculas
  if [[ "$resp" != "s" && "$resp" != "sim" ]]; then
    echo "Operação cancelada. O .env atual foi mantido."
    exit 0
  fi
fi

# Você pode customizar esses valores antes de rodar o script,
# ou deixar em branco para gerar automaticamente.
DB_NAME="${DB_NAME:-meu_banco}"
DB_USER="${DB_USER:-meu_usuario}"
DB_PASSWORD="${DB_PASSWORD:-$(gen_password)}"
DB_ROOT_PASSWORD="${DB_ROOT_PASSWORD:-$(gen_password)}"

cat > "$ENV_FILE" <<EOF
# Arquivo gerado automaticamente em $(date '+%Y-%m-%d %H:%M:%S')
# Não compartilhe este arquivo nem o adicione ao controle de versão (git)

MYSQL_DATABASE=${DB_NAME}
MYSQL_USER=${DB_USER}
MYSQL_PASSWORD=${DB_PASSWORD}
MYSQL_ROOT_PASSWORD=${DB_ROOT_PASSWORD}
EOF

chmod 600 "$ENV_FILE"

echo "Arquivo $ENV_FILE criado com sucesso!"
echo ""
echo "  Banco de dados : ${DB_NAME}"
echo "  Usuário        : ${DB_USER}"
echo "  Senha          : ${DB_PASSWORD}"
echo "  Senha root     : ${DB_ROOT_PASSWORD}"
echo ""
echo "Agora você pode rodar: docker compose up -d"