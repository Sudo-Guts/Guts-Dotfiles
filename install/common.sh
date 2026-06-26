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
sudo apt install tree -y

# Configurar hora local (para dual boot con Windows)
sudo timedatectl set-local-rtc 1 --adjust-system-clock

echo -e "${GREEN}✅ Dependencias comunes instaladas${NC}"

# -----------------------------------------------------------------------------
# Configurar atajo de teclado para Kitty (Ctrl+T)
# -----------------------------------------------------------------------------
echo -e "${GREEN}⌨️  Configurando atajo de teclado para Kitty (Ctrl+T)...${NC}"

# Verificar si estamos en GNOME (entorno gráfico)
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]] || [[ "$XDG_SESSION_TYPE" == "x11" && "$DESKTOP_SESSION" == *"gnome"* ]]; then
    # Definir el atajo
    KEY_NAME="Abrir Kitty"
    KEY_COMMAND="kitty"
    KEY_BINDING="<Control>t"
    KEY_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/"

    # Obtener lista actual de atajos personalizados
    CURRENT_LIST=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings 2>/dev/null || echo "@as []")

    # Si la lista está vacía, inicializarla
    if [[ "$CURRENT_LIST" == "@as []" ]]; then
        gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "[]"
        CURRENT_LIST="[]"
    fi

    # Verificar si ya existe un atajo con el mismo comando o nombre
    if echo "$CURRENT_LIST" | grep -q "$KEY_NAME" || echo "$CURRENT_LIST" | grep -q "$KEY_COMMAND"; then
        echo -e "${YELLOW}   Atajo para Kitty ya existe. Saltando.${NC}"
    else
        # Encontrar el siguiente índice disponible
        MAX_INDEX=0
        for i in $(seq 0 100); do
            if echo "$CURRENT_LIST" | grep -q "custom$i"; then
                MAX_INDEX=$((i + 1))
            else
                break
            fi
        done

        NEW_KEY_PATH="${KEY_PATH}custom${MAX_INDEX}/"

        # Añadir el nuevo atajo a la lista
        if [[ "$CURRENT_LIST" == "[]" ]]; then
            NEW_LIST="['$NEW_KEY_PATH']"
        else
            NEW_LIST=$(echo "$CURRENT_LIST" | sed "s/]$/, '$NEW_KEY_PATH']/")
        fi

        # Aplicar la configuración
        gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$NEW_LIST"
        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$NEW_KEY_PATH" name "$KEY_NAME"
        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$NEW_KEY_PATH" command "$KEY_COMMAND"
        gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$NEW_KEY_PATH" binding "$KEY_BINDING"

        echo -e "${GREEN}   Atajo '${KEY_NAME}' (${KEY_BINDING}) configurado correctamente.${NC}"
    fi
else
    echo -e "${YELLOW}   No se detectó un entorno GNOME, omitiendo configuración de atajo.${NC}"
fi
