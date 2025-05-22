#!/bin/bash

# Impede execução como root
if [[ $EUID -eq 0 ]]; then
   echo "Por favor, NÃO execute este script como root. Apenas: ./update.sh"
   exit 1
fi

# Função para verificar se um pacote já está instalado
is_installed() {
    pacman -Qi "$1" &>/dev/null
}

echo "Atualizando o sistema..."
sudo pacman -Syu --noconfirm

echo "Instalando pacotes oficiais: Git, Vim..."
sudo pacman -S --noconfirm git vim

# Instalando yay, se não estiver instalado
if ! command -v yay &> /dev/null; then
    echo "yay não encontrado. Instalando yay..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
fi

echo "Instalando pacotes via yay: VSCode, Postman, ChatGPT, Chrome..."

# Lista de pacotes AUR (sem o Teams)
AUR_PACKAGES=(
    visual-studio-code-bin
    postman-bin
    chatgpt-desktop-bin
    google-chrome
)

for package in "${AUR_PACKAGES[@]}"; do
    if is_installed "$package"; then
        echo "$package já está instalado."
    else
        yay -S --noconfirm "$package"
    fi
done

echo "Todos os pacotes foram instalados com sucesso!"
