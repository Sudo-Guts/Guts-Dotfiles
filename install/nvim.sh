#!/usr/bin/env bash

# =============================================================================
# install/nvim.sh - Instalación de Neovim y enlace de configuración
# =============================================================================
# Este script:
#   1. Instala Neovim desde los repositorios de Ubuntu/Debian (apt)
#   2. Crea el enlace simbólico de ~/.dotfiles/nvim -> ~/.config/nvim
#   3. lazy.nvim se instalará automáticamente la primera vez que ejecutes nvim
#      (gracias a la configuración en tu init.lua)
# =============================================================================
# ~/.dotfiles/
#├── install/
#│   ├── bootstrap.sh
#│   └── nvim.sh          <--- este script
#├── nvim/
#│   ├── init.lua
#│   ├── lazy-lock.json
#│   └── lua/
#│       ├── plugins/
#│       │   ├── ...
#│       │   └── alpha.lua
#│       └── config/
#│           ├── options.lua
#│           ├── keymaps.lua
#│           └── lazy.lua
# =============================================================================

set -e  # Detener si hay error

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Detectar directorio raíz de los dotfiles (el que contiene la carpeta install/)
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo -e "${GREEN}📦 Instalando Neovim (desde apt)...${NC}"

# -----------------------------------------------------------------------------
# 1. Instalar Neovim desde repositorios
# -----------------------------------------------------------------------------

if command -v nvim &>/dev/null; then
    echo -e "${YELLOW}   Neovim ya instalado, saltando instalación.${NC}"
else
    sudo apt update -y
    sudo apt install -y neovim
    echo "   Neovim instalado correctamente."
fi

# -----------------------------------------------------------------------------
# 2. Crear enlace simbólico de la configuración
# -----------------------------------------------------------------------------

NVIM_CONFIG_TARGET="${HOME}/.config/nvim"
NVIM_CONFIG_SOURCE="${DOTFILES}/nvim"

# Verificar que la fuente existe
if [[ ! -d "$NVIM_CONFIG_SOURCE" ]]; then
    echo -e "${YELLOW}⚠️  No se encuentra la configuración en ${NVIM_CONFIG_SOURCE}${NC}"
    echo "   Asegúrate de tener tus archivos (init.lua, lua/, etc.) en ~/.dotfiles/nvim/"
    exit 1
fi

# Función segura para enlazar
safe_link() {
    local src="$1"
    local dst="$2"

    if [[ -e "$dst" ]] || [[ -L "$dst" ]]; then
        echo "   📁 Respaldo: $dst → ${dst}.backup"
        mv "$dst" "${dst}.backup" 2>/dev/null || true
    fi

    mkdir -p "$(dirname "$dst")"
    ln -sf "$src" "$dst"
    echo "   ✅ Enlace creado: $src → $dst"
}

echo -e "${GREEN}🔗 Enlazando configuración de Neovim...${NC}"
safe_link "$NVIM_CONFIG_SOURCE" "$NVIM_CONFIG_TARGET"

# -----------------------------------------------------------------------------
# 3. Mensaje final sobre lazy.nvim
# -----------------------------------------------------------------------------
echo -e "${GREEN}✅ Neovim configurado correctamente.${NC}"
echo -e "${YELLOW}📌 Nota: La primera vez que abras nvim, lazy.nvim se instalará automáticamente y descargará tus plugins. Ten paciencia.${NC}"
