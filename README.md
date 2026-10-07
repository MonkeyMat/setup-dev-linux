# setup-dev-linux

Script d'installation et de configuration d'un environnement de développement web sur Linux Mint.

## 🎯 Objectif

Ce projet permet de reconstruire rapidement un environnement de développement web à partir d'une installation fraîche de Linux Mint.

L'objectif est de rendre l'installation :

* reproductible ;
* compréhensible ;
* idempotente ;
* facilement maintenable.

Le script peut être relancé sans réinstaller inutilement les logiciels déjà présents.

## 💻 Environnement testé

* Linux Mint 22.3 Zena
* Base Ubuntu 24.04 Noble
* Architecture x86_64
* ASUS K53SD
* SSD 120 Go

## 🛠️ Logiciels installés

Le script installe et configure :

* Git
* VS Code
* PHP
* extensions PHP nécessaires à Symfony
* Composer
* NVM
* Node.js LTS
* npm
* Docker Engine
* Docker Compose
* Symfony CLI

## 📁 Structure

```text
setup-dev-linux/
├── install.sh
├── install-v1.sh
└── README.md
```

### install.sh

Version actuelle du script d'installation.

Le script est organisé en fonctions :

```text
install_system()
install_vscode()
install_php()
install_composer()
install_node()
install_docker()
install_symfony()
verify_environment()
```

### install-v1.sh

Première version fonctionnelle conservée comme sauvegarde.

## 🚀 Installation

Depuis une installation fraîche de Linux Mint :

```bash
git clone <URL_DU_DEPOT>
cd setup-dev-linux
chmod +x install.sh
./install.sh
```

## 🔁 Réexécution

Le script vérifie si les principaux outils sont déjà installés.

Par exemple :

```text
VS Code est déjà installé
PHP est déjà installé
Composer est déjà installé
Docker est déjà installé
Symfony CLI est déjà installé
```

Cela permet de relancer le script sans réinstaller inutilement l'environnement.

## 🐳 Docker

Le script ajoute l'utilisateur courant au groupe `docker` afin de permettre l'utilisation de Docker sans `sudo`.

Après une première installation, une nouvelle session utilisateur peut être nécessaire pour appliquer le changement de groupe.

Test :

```bash
docker run hello-world
```

## 🔎 Vérification

À la fin de l'installation, le script affiche les versions des principaux outils :

```text
Git
VS Code
PHP
Composer
NVM
Node.js
npm
Docker
Docker Compose
Symfony CLI
```

## 🧪 Test de reproductibilité

Le script a été testé sur une installation fraîche de Linux Mint 22.3.

Résultat :

1. Installation complète depuis un système vierge : OK
2. Deuxième exécution du script : OK
3. Logiciels déjà installés correctement détectés : OK
4. Docker fonctionnel sans `sudo` après activation du groupe : OK

## 📌 Évolution prévue

Ce projet pourra progressivement intégrer :

* configuration Git ;
* clé SSH GitHub ;
* outils SQL ;
* PostgreSQL / MariaDB ;
* outils réseau Linux ;
* configuration du shell ;
* configuration VS Code ;
* extensions VS Code ;
* configuration Docker ;
* création automatique de dossiers de projets ;
* outils complémentaires pour Symfony.

## 📚 Objectif pédagogique

Ce projet sert également de laboratoire d'apprentissage.

Il permet de pratiquer :

* Linux ;
* Bash ;
* permissions ;
* gestion des paquets ;
* dépôts logiciels ;
* variables ;
* conditions ;
* fonctions ;
* Git ;
* Docker ;
* automatisation ;
* environnement de développement reproductible.

## 🧪 Test Git

Modification effectuée pour comprendre le fonctionnement de Git.
