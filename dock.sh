#!/bin/bash

# Instalação do Plank
echo "Instalando Plank..."
sudo apt update
sudo apt install -y plank

# Diretório de configuração
PLANK_DOCK_DIR="$HOME/.config/plank/dock1/launchers"

echo "Configurando Plank..."

# Remove configurações anteriores
rm -rf "$PLANK_DOCK_DIR"
mkdir -p "$PLANK_DOCK_DIR"

# Função para criar lançadores
create_launcher() {
    local app=$1
    local desktop_file=$(find /usr/share/applications ~/.local/share/applications -name "${app}.desktop" | head -n 1)

    if [ -z "$desktop_file" ]; then
        echo "Arquivo .desktop para $app não encontrado!"
    else
        cp "$desktop_file" "$PLANK_DOCK_DIR"
        echo "Adicionado $app ao Plank."
    fi
}

# Aplicativos desejados
create_launcher "google-chrome"
create_launcher "chat-gpt"
create_launcher "code"
create_launcher "org.gnome.Console"
create_launcher "org.gnome.Nautilus"

# Configura Plank para iniciar automaticamente
AUTOSTART_DIR="$HOME/.config/autostart"
mkdir -p "$AUTOSTART_DIR"

PLANK_AUTOSTART_FILE="$AUTOSTART_DIR/plank.desktop"

cat > "$PLANK_AUTOSTART_FILE" <<EOL
[Desktop Entry]
Type=Application
Exec=plank
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Plank
Comment=Start Plank dock at login
EOL

echo "Plank configurado para iniciar automaticamente ao fazer login."

# Mensagem final
echo "Configuração concluída! Agora inicie o Plank com o comando: plank & ou reinicie o sistema."
