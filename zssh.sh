#!/bin/bash

# Função para exibir mensagens
info() {
  echo -e "\033[1;34m[INFO]\033[0m $1"
}

erro() {
  echo -e "\033[1;31m[ERRO]\033[0m $1"
  exit 1
}

# Atualiza pacotes e instala Zsh, Git, Curl
info "Atualizando pacotes..."
if command -v apt >/dev/null; then
  sudo apt update && sudo apt install -y zsh git curl
elif command -v dnf >/dev/null; then
  sudo dnf install -y zsh git curl
elif command -v pacman >/dev/null; then
  sudo pacman -Sy --noconfirm zsh git curl
else
  erro "Gerenciador de pacotes não suportado!"
fi

# Instala Oh My Zsh
info "Instalando Oh My Zsh..."
export RUNZSH=no
export CHSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Instala tema Spaceship
info "Instalando tema Spaceship..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -sf "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

# Define o tema Spaceship no .zshrc
info "Configurando tema Spaceship..."
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="spaceship"/' ~/.zshrc

# Define Zsh como shell padrão
info "Alterando shell padrão para Zsh..."
chsh -s "$(which zsh)"

info "Instalação concluída!"
echo -e "\nAbra um novo terminal ou execute 'zsh' para começar a usar o Zsh com o tema Spaceship."

