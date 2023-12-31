# ------------------- Terminal Intial Install ------------------- #

# Guake Terminal
echo "Installing Guake Terminal..."
sudo apt install -y guake

# ZSH
echo "Installing Zsh..."
sudo apt install -y zsh

# Zsh as the default shell
echo "Setting Zsh as the default shell..."
chsh -s $(which zsh)

# Installing Tmux
echo "Installing Tmux..."
sudo apt install -y tmux

echo "Initial Terminal setup completed."

# Oh My Zsh
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Cloning Zsh plugins
echo "Cloning Zsh plugins..."
plugins_directory=~/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git $plugins_directory/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $plugins_directory/zsh-syntax-highlighting

# Editing ~/.zshrc to include the plugins
echo "Editing ~/.zshrc to include the plugins..."
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

# Activating the changes
echo "Activating the changes..."
source ~/.zshrc

# TODO: TMUX plugins/configurations
echo "Terminal setup completed."
