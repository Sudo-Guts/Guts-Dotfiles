#!/usr/bin/env bash

# =============================================================================
# install/kitty.sh - Instalación del terminal Kitty
# =============================================================================
# Este script:
#   1. Instala Kitty desde los repositorios de Ubuntu/Debian (apt)
#   2. Opcionalmente, se puede cambiar a la última versión usando el script oficial
#   3. La configuración de Kitty (kitty.conf, themes, etc.) debe estar en
#      ~/.dotfiles/kitty/ y será enlazada por el bootstrap a ~/.config/kitty/
# =============================================================================

set -e
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}🐱 Instalando Kitty terminal...${NC}"

# -----------------------------------------------------------------------------
# 1. Instalar Kitty desde apt (versión estable de Ubuntu/Debian)
# -----------------------------------------------------------------------------
if ! command -v kitty &>/dev/null; then
    sudo apt update -y
    sudo apt install -y kitty
    echo "   Kitty instalado desde apt."
else
    echo -e "${YELLOW}   Kitty ya instalado, saltando.${NC}"
fi

# -----------------------------------------------------------------------------
# 2. Mensaje sobre la configuración
# -----------------------------------------------------------------------------
echo -e "${GREEN}✅ Kitty instalado correctamente.${NC}"
