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

## 📂 Estructura del proyecto

~/.dotfiles/
├── README.md                      # Este archivo
├── .gitignore                     # Archivos ignorados por git
├── install/                       # Scripts de instalación
│   ├── bootstrap.sh               # Orquestador principal
│   ├── common.sh                  # Dependencias básicas (curl, git, timedatectl...)
│   ├── nvim.sh                    # Neovim AppImage (última versión estable)
│   ├── zsh.sh                     # Zsh + Oh My Zsh + plugins + fzf
│   ├── kitty.sh                   # Kitty terminal desde apt
│   └── fonts.sh                   # Iosevka Nerd Font mediante getnf
├── nvim/                          # Configuración de Neovim
│   ├── init.lua                   # Punto de entrada (carga lazy.nvim)
│   ├── lazy-lock.json             # Lock de versiones de plugins
│   └── lua/
│       ├── config/                # Configuraciones modulares
│       │   ├── options.lua        # Opciones de Neovim
│       │   ├── keymaps.lua        # Atajos de teclado
│       │   └── lazy.lua           # Configuración de lazy.nvim
│       └── plugins/               # Definiciones de plugins
│           └── alpha.lua          # Ejemplo: plugin alpha-nvim
├── zsh/                           # Configuración de Zsh
│   └── .zshrc                     # Se enlaza a ~/.zshrc
└── kitty/                         # Configuración de Kitty (opcional)
    └── kitty.conf                 # Se enlaza a ~/.config/kitty/

## 🚀 Instalación

```bash
# Clona el repositorio en ~/.dotfiles
git clone https://github.com/Sudo-Guts/Guts-Dotfiles.git ~/.dotfiles

# Entra en la carpeta
cd ~/.dotfiles

# Ejecuta el instalador principal
chmod +x install/*.sh
./install/bootstrap.sh

## 🙏 Agradecimientos

- [shaky.sh – Simple dotfiles](https://shaky.sh/simple-dotfiles/) por la inspiración en el diseño del `bootstrap.sh`.
- [getnf](https://github.com/getnf/getnf) para instalar fuentes Nerd Fonts de forma sencilla.
- [lazy.nvim](https://github.com/folke/lazy.nvim) y [Oh My Zsh](https://ohmyz.sh/) por hacer que mi flujo de trabajo sea más productivo.
