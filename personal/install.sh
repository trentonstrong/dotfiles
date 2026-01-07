# Custom actions to take on initial install of dotfiles.
# This runs after default install actions, so you can overwrite changes it makes if you want.

ZSH_HOST_OS=$(uname | awk '{print tolower($0)}')

case $ZSH_HOST_OS in
  darwin*)

  BREW_EXECUTABLE=$(command -v brew || true)

  if [[ -x $BREW_EXECUTABLE ]]; then
    $BREW_EXECUTABLE install ripgrep
    $BREW_EXECUTABLE install fd
    $BREW_EXECUTABLE install bat
    $BREW_EXECUTABLE install eza
    $BREW_EXECUTABLE install tig
    $BREW_EXECUTABLE install nvm
  else
    echo "Homebrew not found; skipping brew installs."
  fi
;;

  linux*)
  HOST_OS_ID=$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release | tr -d '"')
  case $HOST_OS_ID in
    ubuntu)
      ;&
    debian)
      sudo apt-get install -y ripgrep
      sudo apt-get install -y fd-find
      sudo apt-get install -y bat
      sudo apt-get install -y eza
      sudo apt-get install -y tig
      if [[ -z ${NVM_DIR:-} ]]; then
        export NVM_DIR="$HOME/.nvm"
      fi
      if [[ ! -d $NVM_DIR ]]; then
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
      fi
      ;;
    arch)
      sudo pacman -S --noconfirm ripgrep
      sudo pacman -S --noconfirm fd
      sudo pacman -S --noconfirm bat
      sudo pacman -S --noconfirm eza
      sudo pacman -S --noconfirm tig
      sudo pacman -S --noconfirm nvm
      ;;
    *)
      echo "Unsupported Linux distribution: $HOST_OS_ID"
      exit 1
      ;;
  esac
esac
