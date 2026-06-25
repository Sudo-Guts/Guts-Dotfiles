#!/usr/bin/env bash
# =============================================================================
# install/docker.sh - Instalación de Docker Engine y Docker Compose
# =============================================================================
# Este script:
#   1. Añade el repositorio oficial de Docker
#   2. Instala Docker Engine, CLI y Containerd
#   3. Instala Docker Compose Plugin (opcional)
#   4. Agrega el usuario actual al grupo docker (para no usar sudo)
#   5. Inicia y habilita el servicio Docker
# =============================================================================

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}🐳 Instalando Docker...${NC}"

# -----------------------------------------------------------------------------
# 1. Verificar si Docker ya está instalado
# -----------------------------------------------------------------------------
if command -v docker &>/dev/null; then
    DOCKER_VERSION=$(docker --version | cut -d' ' -f3 | tr -d ',')
    echo -e "${YELLOW}   Docker ya instalado (versión $DOCKER_VERSION), saltando instalación.${NC}"
    echo -e "${YELLOW}   Para forzar reinstalación, ejecuta: sudo apt remove docker-ce docker-ce-cli containerd.io -y${NC}"
    exit 0
fi

# -----------------------------------------------------------------------------
# 2. Instalar dependencias necesarias
# -----------------------------------------------------------------------------
echo "   Instalando dependencias para Docker..."
sudo apt update -y
sudo apt install -y ca-certificates curl gnupg lsb-release

# -----------------------------------------------------------------------------
# 3. Añadir la clave GPG oficial de Docker
# -----------------------------------------------------------------------------
echo "   Añadiendo clave GPG de Docker..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# -----------------------------------------------------------------------------
# 4. Añadir el repositorio de Docker
# -----------------------------------------------------------------------------
echo "   Añadiendo repositorio de Docker..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# -----------------------------------------------------------------------------
# 5. Instalar Docker Engine, CLI y Containerd
# -----------------------------------------------------------------------------
echo "   Instalando Docker Engine..."
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# -----------------------------------------------------------------------------
# 6. Iniciar y habilitar Docker
# -----------------------------------------------------------------------------
echo "   Iniciando y habilitando el servicio Docker..."
sudo systemctl enable docker --now

# -----------------------------------------------------------------------------
# 7. Agregar usuario al grupo docker (para evitar sudo)
# -----------------------------------------------------------------------------
echo "   Agregando usuario $USER al grupo docker..."
sudo usermod -aG docker $USER

# -----------------------------------------------------------------------------
# 8. Verificar instalación
# -----------------------------------------------------------------------------
echo -e "${GREEN}✅ Docker instalado correctamente: $(docker --version)${NC}"
echo -e "${YELLOW}📌 IMPORTANTE: Para usar docker sin sudo, cierra sesión y vuelve a entrar (o usa 'newgrp docker').${NC}"

# Mostrar información de Docker Compose
if command -v docker compose &>/dev/null; then
    echo -e "${GREEN}✅ Docker Compose instalado: $(docker compose version)${NC}"
fi
