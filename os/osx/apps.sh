#
# Application installer (via brew-cask)
#

set -e

# Apps
apps=(
  alfred
  dropbox
  google-chrome
  qlcolorcode
  slack
  appcleaner
  firefox
  seil
  vagrant
  iterm2
  shiori
  sublime-text3
  virtualbox
  atom
  flux
  sketch
  vlc
  keepassx
  quicklook-json
  skype
  transmission
  teamspeak-client
  filezilla
  evernote
  gpgtools
  pycharm
  steam
  spectacle
  caffeine
  teamviewer
  mactex
)

# fonts
fonts=(
  font-clear-sans
  font-roboto
  font-anonymous-pro
  font-inconsolata-dz
)

# Specify the location of the apps
appdir="/Applications"

# Check for Homebrew
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

main() {

  # Ensure homebrew is installed
  homebrew

  # Install homebrew-cask
  echo "installing cask..."
  brew tap phinze/homebrew-cask
  brew install brew-cask

  # Tap alternative versions
  brew tap caskroom/versions

  # Tap the fonts
  brew tap caskroom/fonts

  # install apps
  echo "installing apps..."
  brew cask install --appdir=$appdir ${apps[@]}

  # install fonts
  echo "installing fonts..."
  brew cask install ${fonts[@]}

  # link with alfred
  alfred
  cleanup
}

homebrew() {
  if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

alfred() {
  brew cask alfred link
}

cleanup() {
  brew cleanup
}

main "$@"
exit 0
