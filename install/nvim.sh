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
set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo -e "${GREEN}📦 Instalando Neovim (última versión estable)...${NC}"

# -----------------------------------------------------------------------------
# 1. Instalar Neovim desde AppImage (última versión estable)
# -----------------------------------------------------------------------------
if command -v nvim &>/dev/null; then
    CURRENT_VERSION=$(nvim --version | head -1 | cut -d' ' -f2)
    echo -e "${YELLOW}   Neovim ya instalado (versión $CURRENT_VERSION), saltando.${NC}"
    echo -e "${YELLOW}   Para forzar reinstalación, elimina /usr/local/bin/nvim y vuelve a ejecutar.${NC}"
else
    echo "   Descargando la última versión estable de Neovim..."
    sudo mkdir -p /opt/nvim
    
    # Descargar AppImage
    sudo wget -O /opt/nvim/nvim.appimage https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
    sudo chmod +x /opt/nvim/nvim.appimage
    
    # Crear enlace simbólico en /usr/local/bin
    sudo ln -sf /opt/nvim/nvim.appimage /usr/local/bin/nvim
    
    echo "   Neovim instalado correctamente."
fi

# -----------------------------------------------------------------------------
# 2. Verificar la instalación
# -----------------------------------------------------------------------------
echo -e "${GREEN}✅ Neovim instalado: $(nvim --version | head -1)${NC}"

# -----------------------------------------------------------------------------
# 3. Crear directorio de configuración y enlazar archivos
# -----------------------------------------------------------------------------
NVIM_CONFIG_TARGET="${HOME}/.config/nvim"
NVIM_CONFIG_SOURCE="${DOTFILES}/nvim"

if [[ ! -d "$NVIM_CONFIG_SOURCE" ]]; then
    echo -e "${YELLOW}⚠️  No se encuentra la configuración en ${NVIM_CONFIG_SOURCE}${NC}"
    echo "   Asegúrate de tener tus archivos (init.lua, lua/, etc.) en ~/.dotfiles/nvim/"
    exit 1
fi

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
# 4. Mensaje final
# -----------------------------------------------------------------------------
echo -e "${GREEN}✅ Neovim configurado correctamente.${NC}"
echo -e "${YELLOW}📌 Nota: La primera vez que abras nvim, lazy.nvim se instalará automáticamente.${NC}"
