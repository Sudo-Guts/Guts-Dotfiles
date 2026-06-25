#!/usr/bin/env bash
# =============================================================================
# install/riscv.sh - Instalación interactiva del entorno RISC-V
# =============================================================================
# Este script instala la toolchain RISC-V (newlib), Spike y Proxy Kernel.
# Se ejecuta solo si el usuario lo solicita explícitamente.
# =============================================================================

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Variables de entorno
export RISCV="/opt/riscv"
export PATH="$RISCV/bin:$PATH"

# Función para preguntar sí/no
ask_yes_no() {
    local prompt="$1 (y/N) "
    local answer
    read -r -p "$prompt" answer
    case "$answer" in
        [yY]|[yY][eE][sS]) return 0 ;;
        *) return 1 ;;
    esac
}

print_step() {
    echo -e "${GREEN}===> $1${NC}"
}

print_error() {
    echo -e "${RED}ERROR: $1${NC}" >&2
    exit 1
}

# Verificar si ya está instalado (verificar gcc)
if command -v riscv64-unknown-elf-gcc &>/dev/null; then
    INSTALLED_VERSION=$(riscv64-unknown-elf-gcc --version | head -1)
    echo -e "${YELLOW}⚠️  RISC-V toolchain ya instalada: $INSTALLED_VERSION${NC}"
    if ! ask_yes_no "¿Reinstalar/actualizar?"; then
        echo "   Saliendo sin cambios."
        exit 0
    fi
fi

# Verificar ejecución con sudo
if [[ $EUID -ne 0 ]]; then
    print_error "Este script debe ejecutarse con sudo: sudo ./install/riscv.sh"
fi

# Directorio temporal
WORKDIR="/tmp/riscv_build"
mkdir -p "$WORKDIR"

# Limpiar posibles residuos de ejecuciones anteriores
rm -rf "$WORKDIR"/*

cd "$WORKDIR"

# 1. Dependencias del sistema
print_step "Instalando dependencias del sistema..."
apt update -y
apt install -y \
    autoconf automake autotools-dev curl python3 python3-pip \
    python3-tomli libmpc-dev libmpfr-dev libgmp-dev gawk \
    build-essential bison flex texinfo gperf libtool patchutils \
    bc zlib1g-dev libexpat-dev ninja-build git cmake \
    libglib2.0-dev libslirp-dev device-tree-compiler \
    libboost-regex-dev libboost-system-dev

# 2. Crear directorio de instalación y asignar permisos al usuario
print_step "Creando directorio $RISCV y asignando permisos..."
mkdir -p "$RISCV"
chown -R "$SUDO_USER":"$SUDO_USER" "$RISCV"

# 3. Clonar y compilar la toolchain (newlib)
print_step "Clonando riscv-gnu-toolchain..."
if [ -d "riscv-gnu-toolchain" ]; then
    echo "   El directorio riscv-gnu-toolchain ya existe. Eliminando..."
    rm -rf riscv-gnu-toolchain
fi
git clone --depth 1 https://github.com/riscv/riscv-gnu-toolchain

cd riscv-gnu-toolchain
print_step "Configurando toolchain para bare-metal (newlib)..."
./configure --prefix="$RISCV" --with-arch=rv64imafdc --with-abi=lp64d
print_step "Compilando toolchain (esto puede tomar 30-60 minutos)..."
make -j$(nproc)
make install

cd "$WORKDIR"

# 4. (Opcional) Toolchain para Linux - se pregunta al usuario
if ask_yes_no "¿Deseas compilar también la toolchain para Linux (soporte para glibc)?"; then
    print_step "Configurando toolchain para Linux..."
    cd riscv-gnu-toolchain
    ./configure --prefix="$RISCV" --with-arch=rv64imafdc --with-abi=lp64d
    make linux -j$(nproc)
    make linux install
    cd "$WORKDIR"
fi

# 5. Clonar y compilar Spike
print_step "Clonando Spike..."
if [ -d "riscv-isa-sim" ]; then
    rm -rf riscv-isa-sim
fi
git clone --depth 1 https://github.com/riscv-software-src/riscv-isa-sim

cd riscv-isa-sim
mkdir -p build
cd build
print_step "Configurando Spike..."
../configure --prefix="$RISCV"
print_step "Compilando Spike..."
make -j$(nproc)
make install

cd "$WORKDIR"

# 6. Clonar y compilar Proxy Kernel (pk)
print_step "Clonando Proxy Kernel (pk)..."
if [ -d "riscv-pk" ]; then
    rm -rf riscv-pk
fi
git clone --depth 1 https://github.com/riscv-software-src/riscv-pk

cd riscv-pk
mkdir -p build
cd build
print_step "Configurando pk (con CFLAGS para Zifencei)..."
CFLAGS="-march=rv64imafdc_zifencei" ../configure --prefix="$RISCV" --host=riscv64-unknown-elf
print_step "Compilando pk..."
make -j$(nproc)
make install

# 7. Añadir variables de entorno al .zshrc del usuario
print_step "Agregando variables de entorno al .zshrc del usuario..."
USER_HOME=$(eval echo ~"$SUDO_USER")
grep -qxF "export RISCV=\"$RISCV\"" "$USER_HOME/.zshrc" || \
    echo "export RISCV=\"$RISCV\"" >> "$USER_HOME/.zshrc"
grep -qxF 'export PATH="$RISCV/bin:$PATH"' "$USER_HOME/.zshrc" || \
    echo 'export PATH="$RISCV/bin:$PATH"' >> "$USER_HOME/.zshrc"

# 8. Limpiar
print_step "Limpiando archivos temporales..."
cd /
rm -rf "$WORKDIR"

# 9. Verificación final
print_step "¡Instalación completada! Verificando herramientas..."
su - "$SUDO_USER" -c "source $USER_HOME/.zshrc && riscv64-unknown-elf-gcc --version"
su - "$SUDO_USER" -c "source $USER_HOME/.zshrc && spike --version"
su - "$SUDO_USER" -c "source $USER_HOME/.zshrc && pk --version" || echo "pk se encuentra en $RISCV/riscv64-unknown-elf/bin/pk"

echo -e "${GREEN}✅ Instalación exitosa.${NC}"
echo -e "${YELLOW}📌 Para usar las herramientas, reinicia tu terminal o ejecuta: source ~/.zshrc${NC}"
