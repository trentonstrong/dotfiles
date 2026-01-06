# Custom actions to take on initial install of dotfiles.
# This runs after default install actions, so you can overwrite changes it makes if you want.

ZSH_HOST_OS=$(uname | awk '{print tolower($0)}')

case $ZSH_HOST_OS in
  darwin*)

  BREW_EXECUTABLE=/opt/homebrew/bin/brew

  $BREW_EXECUTABLE install ripgrep
  $BREW_EXECUTABLE install fd
  $BREW_EXECUTABLE install bat
  $BREW_EXECUTABLE install eza
  $BREW_EXECUTABLE install tig
;;

  linux*)
  HOST_OS_ID=$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release | tr -d '"')
  case $HOST_OS_ID in
    ubuntu)
      ;&
    debian)
      PKG_INSTALL_COMMAND="apt-get install -y"
        sudo apt-get install -y ripgrep
        sudo apt-get install -y fd
        sudo apt-get install -y bat
        sudo apt-get install -y eza
        sudo apt-get install -y tig
      ;;
    arch)
      sudo pacman -S --noconfirm ripgrep
      sudo pacman -S --noconfirm fd
      sudo pacman -S --noconfirm bat
      sudo pacman -S --noconfirm eza
      sudo pacman -S --noconfirm tig
      ;;
    *)
      echo "Unsupported Linux distribution: $HOST_OS_ID"
      exit 1
      ;;
  esac
esac
