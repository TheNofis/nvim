# Neovim 0.10.0 By TheNofis

## Installation guide
### 1. Install NeoVim in guthub Release
   ```bash
   wget https://github.com/neovim/neovim/releases/download/v0.10.1/nvim-linux64.tar.gz
   tar -xf nvim-linux64.tar.gz
   sudo cp -r nvim-linux64/bin/* /usr/bin
   sudo cp -r nvim-linux64/lib/* /usr/lib
   sudo cp -r nvim-linux64/share/* /usr/share
   ```
<br/>

### 2. Remove old NeoVim dots
   ```bash
   rm -rf ~/.config/nvim ~/.local/share/nvim ~/.cache/nvim
   ```
<br/>

### 3. Install all package
   1. Yay
      ```bash
      yay -S ripgrep unzip
      ```
   2. NodeJs + Npm
      ```bash
      wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
      export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh";nvm install 20.1;npm install -g vscode-langservers-extracted
      ```
<br/>

### 4. Install new dots
   ```bash
   git clone https://github.com/TheNofis/nvim ~/.config/nvim && rm -rf ~/.config/nvim/.git && nvim
   ```
