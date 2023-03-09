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
  sudo apt-get install -y ripgrep
  sudo apt-get install -y fd
  sudo apt-get install -y bat
  sudo apt-get install -y exa
  sudo apt-get install -y tig
esac
