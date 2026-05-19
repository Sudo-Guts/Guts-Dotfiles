# Guts Dotfiles

Mis dotfiles personales para configurar rápidamente un entorno de desarrollo en Ubuntu/Debian con:
- **Neovim** (configuración en Lua con lazy.nvim)
- **Zsh** + Oh My Zsh + plugins útiles
- **Kitty** terminal (opcional)
- **Nerd Fonts** (Iosevka vía getnf)

## ✨ Características

- **Instalación totalmente automática**: un solo comando y listo.
- **Idempotente**: puedes ejecutarlo múltiples veces sin romper nada.
- **Modular**: cada componente tiene su propio script.
- **Enlaces simbólicos**: todas las configuraciones se sincronizan automáticamente con tu `$HOME`.

## 📋 Requisitos previos

- Sistema: **Ubuntu/Debian** (o derivados como Linux Mint, Pop!_OS)
- Tener instalado `git` y `curl` (se instalan automáticamente con `common.sh` si no existen)
- Conexión a Internet para descargar paquetes y fuentes

## 🚀 Instalación

```bash
# Clona el repositorio en ~/.dotfiles
git clone https://github.com/Sudo-Guts/Guts-Dotfiles.git ~/.dotfiles

# Entra en la carpeta
cd ~/.dotfiles

# (Opcional) Revisa lo que va a hacer
cat install/bootstrap.sh

# Ejecuta el instalador principal
chmod +x install/*.sh
./install/bootstrap.sh
