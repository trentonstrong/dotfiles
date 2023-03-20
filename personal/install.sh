# Custom actions to take on initial install of dotfiles.
# This runs after default install actions, so you can overwrite changes it makes if you want.

ZSH_HOST_OS=$(uname | awk '{print tolower($0)}')

case $ZSH_HOST_OS in
  darwin*)

  BREW_EXECUTABLE=/opt/homebrew/bin/brew

  $BREW_EXECUTABLE install ripgrep
  $BREW_EXECUTABLE install fd
  $BREW_EXECUTABLE install bat
  $BREW_EXECUTABLE install exa
  $BREW_EXECUTABLE install tig
;;

  linux*)
  HOST_OS_ID=$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release | tr -d '"')
  case $HOST_OS_ID in
    ubuntu)
      PKG_INSTALL_COMMAND="sudo apt-get install -y"
      ;;
    debian)
      PKG_INSTALL_COMMAND="sudo apt-get install -y"
      ;;
    arch)
      PKG_INSTALL_COMMAND="sudo pacman -S --noconfirm"
      ;;
    *)
      echo "Unsupported Linux distribution: $HOST_OS_ID"
      exit 1
      ;;
  esac

  $PKG_INSTALL_COMMAND ripgrep
  $PKG_INSTALL_COMMAND fd
  $PKG_INSTALL_COMMAND bat
  $PKG_INSTALL_COMMAND exa
  $PKG_INSTALL_COMMAND tig
esac
