#!/bin/bash

# === Settings ===
LINT_VERSION="v1.64.6"

# === Check and install Homebrew ===
if ! command -v brew &> /dev/null; then
  echo "Homebrew not found. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# === Check and install Python 3 ===
if ! command -v python3 &> /dev/null; then
  echo "Python 3 not found. Installing via Homebrew..."
  brew install python
fi

# === Check and install Pygments ===
if ! python3 -c "import pygments" &> /dev/null; then
  echo "Pygments not found. Installing via pip..."
  pip3 install pygments
fi

# Installing font
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font

# === Symlink config directory ===
cp -R "$HOME/.config/nvim" "$HOME/.config/nvim-backup"
ln -s "$(pwd)/.config/nvim" "$HOME/.config/nvim"

# === Install Neovim Plugin Manager ===
echo "Installing vim-plug for Neovim..."
brew install neovim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# === Install Go dependencies ===
echo "Installing Go tools..."
brew install go
go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest
curl -sfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $HOME/go/bin $LINT_VERSION

# === Install Node (if not already installed) for CoC.nvim ===
if ! command -v node &> /dev/null; then
  echo "Node.js not found. Installing via Homebrew..."
  brew install node
fi

# === Install iTerm2 ===
if ! brew list --cask iterm2 &> /dev/null; then
  echo "Installing iTerm2..."
  brew install --cask iterm2
fi

# === Install Fish ===
if ! command -v fish &> /dev/null; then
  echo "Installing Fish shell..."
  brew install fish
fi

# === Install Oh My Zsh ===
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# === Add aliases ===
if ! grep -q 'alias vim="nvim"' ~/.zshrc; then
  echo 'alias vim="nvim"' >> ~/.zshrc
fi

if ! grep -q 'alias zshrc=' ~/.zshrc; then
  echo 'alias zshrc="nvim ~/.zshrc && source ~/.zshrc"' >> ~/.zshrc
fi

# === Update PATH ===
if ! grep -q 'Library/Python/3.9/bin' ~/.zshrc; then
  echo 'export PATH="$HOME/Library/Python/3.9/bin:$PATH"' >> ~/.zshrc
fi

if ! grep -q '$HOME/go/bin' ~/.zshrc; then
  echo 'export PATH="$HOME/go/bin:$PATH"' >> ~/.zshrc
fi

# === Reminder to install plugins in Neovim ===
echo ""
echo "Dotfiles repo initialized, Neovim config committed, and Go tools installed."
echo "Open Neovim and run :PlugInstall to install plugins."
echo "Run 'source ~/.zshrc' to update your PATH."
