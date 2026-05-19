#!/usr/bin/env bash

# =============================================================================
# install/zsh.sh - Instalación de Zsh, Oh My Zsh y plugins
# =============================================================================
# Este script:
#   1. Instala Zsh y fzf (desde apt)
#   2. Instala Oh My Zsh en modo no interactivo
#   3. Clona los plugins: zsh-autosuggestions, zsh-syntax-highlighting, zsh-history-substring-search
#   4. Instala fzf desde git (última versión) y su utilidad de búsqueda
#   5. Nota: la configuración .zshrc se enlazará desde ~/.dotfiles/zsh/.zshrc mediante el bootstrap
# =============================================================================
#~/.dotfiles/
#├── zsh/
#│   └── .zshrc           <- Archivo de configuración 
#├── install/
#│   ├── bootstrap.sh
#│   ├── common.sh
#│   ├── nvim.sh
#│   ├── zsh.sh           <- este script
#│   └── ...

set -e
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}🐚 Instalando Zsh y Oh My Zsh...${NC}"

# -----------------------------------------------------------------------------
# 1. Instalar Zsh (si no está)
# -----------------------------------------------------------------------------
if ! command -v zsh &>/dev/null; then
    sudo apt install -y zsh
else
    echo -e "${YELLOW}   Zsh ya instalado, saltando.${NC}"
fi

# -----------------------------------------------------------------------------
# 2. Instalar fzf desde apt (opcional, pero lo dejamos)
# -----------------------------------------------------------------------------
if ! command -v fzf &>/dev/null; then
    sudo apt install -y fzf
else
    echo -e "${YELLOW}   fzf (apt) ya instalado.${NC}"
fi

# También instalaremos fzf desde git para tener la última versión (más características)
# Esto se hace más abajo.

# -----------------------------------------------------------------------------
# 3. Instalar Oh My Zsh (no interactivo)
# -----------------------------------------------------------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "   Instalando Oh My Zsh..."
    # RUNZSH=no evita que se ejecute zsh al final
    # CHSH=no evita que cambie el shell automáticamente (lo haremos después)
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo -e "${YELLOW}   Oh My Zsh ya instalado, saltando.${NC}"
fi

# -----------------------------------------------------------------------------
# 4. Clonar plugins de Zsh (en custom)
# -----------------------------------------------------------------------------
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

clone_plugin() {
    local repo="$1"
    local dir="$2"
    if [ ! -d "$dir" ]; then
        echo "   Clonando $repo..."
        git clone --depth 1 "https://github.com/$repo" "$dir"
    else
        echo -e "${YELLOW}   Plugin $repo ya existe, actualizando...${NC}"
        (cd "$dir" && git pull)
    fi
}

clone_plugin "zsh-users/zsh-autosuggestions" "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
clone_plugin "zsh-users/zsh-syntax-highlighting" "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
clone_plugin "zsh-users/zsh-history-substring-search" "${ZSH_CUSTOM}/plugins/zsh-history-substring-search"

# -----------------------------------------------------------------------------
# 5. Instalar fzf desde git (última versión, más completa)
# -----------------------------------------------------------------------------
if [ ! -d "$HOME/.fzf" ]; then
    echo "   Instalando fzf desde git..."
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
    # Instalación automática (responde yes a todo)
    yes | "$HOME/.fzf/install"
else
    echo -e "${YELLOW}   fzf git ya instalado, actualizando...${NC}"
    (cd "$HOME/.fzf" && git pull && yes | ./install)
fi

# -----------------------------------------------------------------------------
# 6. Mensaje final
# -----------------------------------------------------------------------------
echo -e "${GREEN}✅ Zsh y Oh My Zsh instalados correctamente.${NC}"
echo -e "${YELLOW}📌 Recuerda: tu archivo .zshrc debe estar en ~/.dotfiles/zsh/.zshrc y será enlazado por el bootstrap.${NC}"
echo -e "${YELLOW}   Si quieres cambiar el shell por defecto, el bootstrap ya se encargará al final.${NC}"
