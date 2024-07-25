#!/bin/bash

# Définition des variables
TERMUX_COLORS="$HOME/.termux/colors.properties"
THEMES_DIR="$HOME/.termux/themes"

# Fonction pour afficher la bannière
banner() {
    clear
    echo "                                                                  "
    echo "█████╗█████╗█████╗█████╗█████╗█████╗█████╗█████╗█████╗█████╗█████╗"
    echo "╚════╝╚════╝╚════╝╚════╝╚════╝╚════╝╚════╝╚════╝╚════╝╚════╝╚════╝"
    echo "                                                                  "
    echo "    ████████╗███████╗██████╗ ███╗   ███╗██╗   ██╗██╗  ██╗         "
    echo "    ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██║   ██║╚██╗██╔╝         "
    echo "       ██║   █████╗  ██████╔╝██╔████╔██║██║   ██║ ╚███╔╝          "
    echo "       ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║   ██║ ██╔██╗          "
    echo "       ██║   ███████╗██║  ██║██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗         "
    echo "       ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝         "
    echo "                                                                  "
    echo "        ████████╗██╗  ██╗███████╗███╗   ███╗███████╗              "
    echo "        ╚══██╔══╝██║  ██║██╔════╝████╗ ████║██╔════╝              "
    echo "           ██║   ███████║█████╗  ██╔████╔██║█████╗                "
    echo "           ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║██╔══╝                "
    echo "           ██║   ██║  ██║███████╗██║ ╚═╝ ██║███████╗              "
    echo "           ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝              "
    echo "                                                                  "
    echo "███████╗███████╗██╗     ███████╗ ██████╗████████╗ ██████╗ ██████╗ "
    echo "██╔════╝██╔════╝██║     ██╔════╝██╔════╝╚══██╔══╝██╔═══██╗██╔══██╗"
    echo "███████╗█████╗  ██║     █████╗  ██║        ██║   ██║   ██║██████╔╝"
    echo "╚════██║██╔══╝  ██║     ██╔══╝  ██║        ██║   ██║   ██║██╔══██╗"
    echo "███████║███████╗███████╗███████╗╚██████╗   ██║   ╚██████╔╝██║  ██║"
    echo "╚══════╝╚══════╝╚══════╝╚══════╝ ╚═════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝"
    echo "                                                                  "
    echo "█████╗█████╗█████╗█████╗█████╗█████╗█████╗█████╗█████╗█████╗█████╗"
    echo "╚════╝╚════╝╚════╝╚════╝╚════╝╚════╝╚════╝╚════╝╚════╝╚════╝╚════╝"
    echo ""
    echo ""
}

# Fonction pour appliquer un thème
appliquer_theme() {
    local theme_file="$1"
    local theme_name="$2"

    cp "$theme_file" "$TERMUX_COLORS"
    termux-reload-settings

    clear
    banner
    echo "                        ${theme_name^^}"
    echo ""
    echo ""
    echo "                       Appliquer :  Y"
    echo "                      Suivant : Entrée"
    read -p "" reponse
    if [[ $reponse == "Y" || $reponse == "y" ]]; then
        clear
        echo ""
        echo "          Thème ${theme_name^^} conservé. Au revoir !"
        exit 0
    fi
}

# Vérifier si le dossier des thèmes existe, sinon le créer
if [ ! -d "$THEMES_DIR" ]; then
    mkdir -p "$THEMES_DIR"
fi

# Télécharger et extraire les thèmes si le dossier est vide
if [ -z "$(ls -A "$THEMES_DIR")" ]; then
    echo "Téléchargement des thèmes..."
    curl -L -o termux.zip https://github.com/GiGiDKR/termux-theme-manager/raw/main/termux.zip
    unzip -o termux.zip -d "$THEMES_DIR"
    rm termux.zip
    echo "Thèmes téléchargés et extraits."
fi

# Parcourir et appliquer les thèmes
for theme_file in "$THEMES_DIR"/*.properties; do
    theme_name=$(basename "$theme_file" .properties)
    appliquer_theme "$theme_file" "$theme_name"
done

clear
banner
echo ""
echo "Tous les thèmes ont été parcourus sans qu'aucun ne soit choisi."