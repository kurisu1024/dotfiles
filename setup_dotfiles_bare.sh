#!/bin/bash

# === Settings ===
GIT_REPO="$HOME/.dotfiles"
ALIAS_NAME="dotfiles"
WORK_TREE="$HOME"
INIT_VIM_PATH=".config/nvim/init.vim"
LINT_VERSION="v1.64.6"

# Installing font
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font

# === Clone or initialize bare repo ===
if [ ! -d "$GIT_REPO" ]; then
  echo "Initializing bare dotfiles repo in $GIT_REPO"
  git init --bare "$GIT_REPO"
fi

# === Define alias temporarily (can be added to .zshrc/.bashrc) ===
# alias $ALIAS_NAME='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles() {
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME "$@"
}
# === Configure repo to hide untracked files ===
dotfiles config --local status.showUntrackedFiles no

# === Prepare dotfile location ===
mkdir -p "$HOME/.config/nvim"
cp init.vim "$HOME/$INIT_VIM_PATH"

# === Add and commit to bare repo ===
dotfiles add "$INIT_VIM_PATH"
dotfiles commit -m "Add Neovim config"

# === Install Neovim Plugin Manager ===
echo "Installing vim-plug for Neovim..."
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# === Install Go dependencies ===
echo "Installing Go tools..."
go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest
curl -sfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b go $LINT_VERSION

# === Install Node (if not already installed) for CoC.nvim ===
if ! command -v node &> /dev/null; then
  echo "Node.js not found. Installing via Homebrew..."
  brew install node
fi

# === Reminder to install plugins in Neovim ===
echo ""
echo "Dotfiles repo initialized, Neovim config committed, and Go tools installed."
echo "Open Neovim and run :PlugInstall to install plugins."
echo ""
echo "To persist your alias, add this to your shell config:"
echo "  alias dotfiles='/usr/bin/git --git-dir=\$HOME/.dotfiles/ --work-tree=\$HOME'"
