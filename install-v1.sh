#!/usr/bin/env bash

set -euo pipefail

echo "======================================"
echo " Installation environnement Dev Linux"
echo "======================================"

echo
echo "[1/8] Préparation du système"
echo

echo "Mise à jour de la liste des paquets..."
sudo apt update

echo "Mise à jour du système..."
sudo apt upgrade -y

echo "Installation des outils de base..."
sudo apt install -y git curl build-essential ca-certificates

echo
echo "[1/8] Préparation du système terminée."

echo
echo "[2/8] Installation de VS Code"
echo

if command -v code >/dev/null 2>&1; then
    echo "VS Code est déjà installé : $(code --version | head -n 1)"
else
    echo "VS Code n'est pas installé."
    echo "Installation du dépôt Microsoft..."

    sudo apt install -y wget gpg

    wget -qO- https://packages.microsoft.com/keys/microsoft.asc \
        | gpg --dearmor \
        | sudo tee /usr/share/keyrings/microsoft-archive-keyring.gpg > /dev/null

    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/code stable main" \
        | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

    sudo apt update
    sudo apt install -y code

    echo "VS Code installé : $(code --version | head -n 1)"
fi

echo
echo "[2/8] VS Code terminé."

echo
echo "[3/8] Installation de PHP"
echo

if command -v php >/dev/null 2>&1; then
    echo "PHP est déjà installé : $(php -v | head -n 1)"
else
    echo "PHP n'est pas installé."
    echo "Installation de PHP et des extensions..."

    sudo apt install -y \
        php-cli \
        php-mbstring \
        php-xml \
        php-curl \
        php-zip \
        php-intl \
        unzip

    echo "PHP installé : $(php -v | head -n 1)"
fi

echo
echo "[3/8] PHP terminé."

echo
echo "[4/8] Installation de Composer"
echo

if command -v composer >/dev/null 2>&1; then
    echo "Composer est déjà installé : $(composer --version)"
else
    echo "Composer n'est pas installé."
    echo "Installation de Composer..."

    cd /tmp

    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

    sudo php composer-setup.php \
        --install-dir=/usr/local/bin \
        --filename=composer

    rm composer-setup.php

    echo "Composer installé : $(composer --version)"
fi

echo
echo "[4/8] Composer terminé."

echo
echo "[5/8] Installation de NVM et Node.js"
echo

export NVM_DIR="$HOME/.nvm"

if [ -s "$NVM_DIR/nvm.sh" ]; then
    echo "NVM est déjà installé."

    source "$NVM_DIR/nvm.sh"

    echo "NVM : $(nvm --version)"

else
    echo "NVM n'est pas installé."
    echo "Installation de NVM..."

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

    export NVM_DIR="$HOME/.nvm"
    source "$NVM_DIR/nvm.sh"

    echo "NVM installé : $(nvm --version)"
fi

if command -v node >/dev/null 2>&1; then
    echo "Node.js est déjà installé : $(node --version)"
else
    echo "Node.js n'est pas installé."
    echo "Installation de Node.js LTS..."

    nvm install --lts
    nvm alias default 'lts/*'

    echo "Node.js installé : $(node --version)"
    echo "npm installé : $(npm --version)"
fi

echo
echo "[5/8] NVM et Node.js terminés."

echo
echo "[6/8] Installation de Docker"
echo

if command -v docker >/dev/null 2>&1; then
    echo "Docker est déjà installé : $(docker --version)"
else
    echo "Docker n'est pas installé."
    echo "Installation de Docker..."

    sudo apt install -y ca-certificates curl

    sudo install -m 0755 -d /etc/apt/keyrings

    sudo curl -fsSL \
        https://download.docker.com/linux/ubuntu/gpg \
        -o /etc/apt/keyrings/docker.asc

    sudo chmod a+r /etc/apt/keyrings/docker.asc

    sudo tee /etc/apt/sources.list.d/docker.sources > /dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: noble
Components: stable
Architectures: amd64
Signed-By: /etc/apt/keyrings/docker.asc
EOF

    sudo apt update

    sudo apt install -y \
        docker-ce \
        docker-ce-cli \
        containerd.io \
        docker-buildx-plugin \
        docker-compose-plugin

    echo "Docker installé : $(docker --version)"
fi

echo
echo "Configuration des permissions Docker..."

if getent group docker >/dev/null 2>&1; then
    echo "Le groupe docker existe."
else
    sudo groupadd docker
    echo "Groupe docker créé."
fi

if id -nG "$USER" | grep -qw docker; then
    echo "L'utilisateur $USER appartient déjà au groupe docker."
else
    sudo usermod -aG docker "$USER"
    echo "L'utilisateur $USER a été ajouté au groupe docker."
    echo "Une nouvelle connexion sera nécessaire pour appliquer ce changement."
fi

echo
echo "[6/8] Docker terminé."

echo
echo "[7/8] Installation de Symfony CLI"
echo

if command -v symfony >/dev/null 2>&1; then
    echo "Symfony CLI est déjà installé : $(symfony -v | head -n 1)"
else
    echo "Symfony CLI n'est pas installé."
    echo "Installation du dépôt Symfony..."

    curl -1sLf \
        'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' \
        | sudo -E bash

    sudo apt install -y symfony-cli

    echo "Symfony CLI installé : $(symfony -v | head -n 1)"
fi

echo
echo "[7/8] Symfony CLI terminé."

echo
echo "======================================"
echo "[8/8] Vérification de l'environnement"
echo "======================================"
echo

echo "Git       : $(git --version)"
echo "VS Code   : $(code --version | head -n 1)"
echo "PHP       : $(php -v | head -n 1)"
echo "Composer  : $(composer --version)"
echo "NVM       : $(nvm --version)"
echo "Node.js   : $(node --version)"
echo "npm       : $(npm --version)"
echo "Docker    : $(docker --version)"
echo "Compose   : $(docker compose version)"
echo "Symfony   : $(symfony -v | head -n 1)"

echo
echo "======================================"
echo " Environnement Dev prêt !"
echo "======================================"
