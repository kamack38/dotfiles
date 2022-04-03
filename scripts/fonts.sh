mkdir ~/.fonts -p

Prefix="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode"
Bold="$Prefix/Bold/complete/Fira%20Code%20Bold%20Nerd%20Font%20Complete.ttf"
Light="$Prefix/Light/complete/Fira%20Code%20Light%20Nerd%20Font%20Complete.ttf"
Medium="$Prefix/Medium/complete/Fira%20Code%20Medium%20Nerd%20Font%20Complete.ttf"
Regular="$Prefix/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.ttf"
SemiBold="$Prefix/SemiBold/complete/Fira%20Code%20SemiBold%20Nerd%20Font%20Complete.ttf"
Retina="$Prefix/Retina/complete/Fira%20Code%20Retina%20Nerd%20Font%20Complete.ttf"

FilePrefix="FiraCode NF"

cd ~/.fonts

wget $Bold -O "$FilePrefix Bold.ttf"
wget $Loght -O "$FilePrefix Light.ttf"
wget $Medium -O "$FilePrefix Medium.ttf"
wget $Regular -O "$FilePrefix Regular.ttf"
wget $SemiBold -O "$FilePrefix SemiBold.ttf"
wget $Retina -O "$FilePrefix Retina.ttf"