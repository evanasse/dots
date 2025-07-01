# dotfiles
## First install
- Install git
- Clone this repo
```
git clone https://github.com/evanasse/dots.git && cd dots
```
- Install Nix implementation (Lix)
```
curl -sSf -L https://install.lix.systems/lix | sh -s -- install
```
- Change computer name
```
NAME=newname; sudo scutil --set ComputerName $NAME && sudo scutil LocalHostName $NAME
```
- Install flake
```
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake ./nix
```
> A reboot is necessary for the macOS dark theme to be applied

- If Librewolf is damaged
```
brew reinstall librewolf --no-quarantine
```
- Stow config
```
stow .
```
- Download colorscheme
```
cd ~
mkdir git && cd git && git clone https://github.com/evanasse/chalet.git
```
