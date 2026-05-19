#!/usr/bin/env bash

# =============================================================================
# install/fonts.sh - Instalación de Nerd Fonts con getnf
# =============================================================================
# Instala getnf (instalador de fuentes) y luego Iosevka Nerd Font

set -e
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}🔤 Instalando Iosevka Nerd Font...${NC}"

# Instalar getnf si no está presente
if ! command -v getnf &> /dev/null; then
    echo "   📦 Instalando getnf..."
    curl -fsSL https://raw.githubusercontent.com/getnf/getnf/main/install.sh | bash
    # Añadir al PATH para esta sesión
    export PATH="$HOME/.local/bin:$PATH"
else
    echo "   ✅ getnf ya instalado"
fi

# Instalar Iosevka (el nombre exacto en getnf es "Iosevka")
echo "   ⬇️  Descargando e instalando Iosevka..."
~/.local/bin/getnf -i Iosevka

# Refrescar caché de fuentes
fc-cache -fv 2>/dev/null || true

echo -e "${GREEN}✅ Iosevka Nerd Font instalada correctamente${NC}"
