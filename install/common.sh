#!/usr/bin/env bash

# common.sh - Dependencias básicas del sistema

set -e
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}🔧 Instalando dependencias comunes...${NC}"

# Actualizar repositorios
sudo apt update -y
sudo apt upgrade -y

# Instalar paquetes esenciales
sudo apt install -y curl git wget unzip

# Instalar tree
sudo apt install tree -yt

# Configurar hora local (para dual boot con Windows)
sudo timedatectl set-local-rtc 1 --adjust-system-clock

echo -e "${GREEN}✅ Dependencias comunes instaladas${NC}"


