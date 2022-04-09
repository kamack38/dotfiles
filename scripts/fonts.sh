#!/bin/bash

# .fonts dir is now deprecated
# // Create .fonts directory
# // mkdir ~/.fonts -p
# // DirPrefix="$HOME/.fonts"

mkdir -p ~/.local/share/fonts
DirPrefix="$HOME/.local/share/fonts"

installFiraCodeNF() {
    Prefix="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode"
    Bold="$Prefix/Bold/complete/Fira%20Code%20Bold%20Nerd%20Font%20Complete.ttf"
    Light="$Prefix/Light/complete/Fira%20Code%20Light%20Nerd%20Font%20Complete.ttf"
    Medium="$Prefix/Medium/complete/Fira%20Code%20Medium%20Nerd%20Font%20Complete.ttf"
    Regular="$Prefix/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.ttf"
    SemiBold="$Prefix/SemiBold/complete/Fira%20Code%20SemiBold%20Nerd%20Font%20Complete.ttf"
    Retina="$Prefix/Retina/complete/Fira%20Code%20Retina%20Nerd%20Font%20Complete.ttf"

    FilePrefix="FiraCode NF"

    wget $Bold -O "$DirPrefix/$FilePrefix Bold.ttf"
    wget $Loght -O "$DirPrefix/$FilePrefix Light.ttf"
    wget $Medium -O "$DirPrefix/$FilePrefix Medium.ttf"
    wget $Regular -O "$DirPrefix/$FilePrefix Regular.ttf"
    wget $SemiBold -O "$DirPrefix/$FilePrefix SemiBold.ttf"
    wget $Retina -O "$DirPrefix/$FilePrefix Retina.ttf"
}

installFiraCodeMonoNF() {
    Prefix="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode"
    Bold="$Prefix/Bold/complete/Fira%20Code%20Bold%20Nerd%20Font%20Complete%20Mono.ttf"
    Light="$Prefix/Light/complete/Fira%20Code%20Light%20Nerd%20Font%20Complete%20Mono.ttf"
    Medium="$Prefix/Medium/complete/Fira%20Code%20Medium%20Nerd%20Font%20Complete%20Mono.ttf"
    Regular="$Prefix/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete%20Mono.ttf"
    SemiBold="$Prefix/SemiBold/complete/Fira%20Code%20SemiBold%20Nerd%20Font%20Complete%20Mono.ttf"
    Retina="$Prefix/Retina/complete/Fira%20Code%20Retina%20Nerd%20Font%20Complete%20Mono.ttf"

    FilePrefix="FiraCodeMono NF"

    wget $Bold -O "$DirPrefix/$FilePrefix Bold.ttf"
    wget $Loght -O "$DirPrefix/$FilePrefix Light.ttf"
    wget $Medium -O "$DirPrefix/$FilePrefix Medium.ttf"
    wget $Regular -O "$DirPrefix/$FilePrefix Regular.ttf"
    wget $SemiBold -O "$DirPrefix/$FilePrefix SemiBold.ttf"
    wget $Retina -O "$DirPrefix/$FilePrefix Retina.ttf"
}

installFiraCodeNF
installFiraCodeMonoNF

read -p "Do you want to refresh font cache? [y/N] " refresh

if [[ $refresh == "y*" ]]; then
    echo "Refreshing font cache..."
    sudo fc-cache -fv
fi
