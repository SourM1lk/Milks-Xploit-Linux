#!/bin/bash

# -----------------------------------------------------------------------------
# MX Linux Penetration Testing Setup Script
# This script automates the setup of essential tools and configurations for
# penetration testing, red teaming, and CTF activities on MX Linux.
# -----------------------------------------------------------------------------

# Update the package list and upgrade existing packages
echo "Updating package list and upgrading existing packages..."
sudo apt update
sudo apt full-upgrade -y

# ------------------- Terminal Install ------------------- #

# Guake Terminal
echo "Installing Guake Terminal..."
sudo apt install -y guake

# ZSH
echo "Installing Zsh..."
sudo apt install -y zsh

# Zsh as the default shell
echo "Setting Zsh as the default shell..."
chsh -s $(which zsh)

# Oh My Zsh
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

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

# Installing Tmux
echo "Installing Tmux..."
sudo apt install -y tmux

# TODO: TMUX plugins/configurations

echo "Terminal setup completed."

# ------------------- Kali Repository Install ------------------- #

# Update the package list to ensure it's current
sudo apt update

# Add Kali Linux repository to sources.list.d
echo "Adding Kali Linux repository..."
sudo sh -c "echo 'deb https://http.kali.org/kali kali-rolling main non-free contrib' > /etc/apt/sources.list.d/kali.list"

# Update the package list again to include the new repository
echo "Updating package list..."
sudo apt update

# Install gnupg package required for key addition
echo "Installing gnupg package..."
sudo apt install -y gnupg

# Download Kali Linux archive key
echo "Downloading Kali Linux archive key..."
wget 'https://archive.kali.org/archive-key.asc'

# Add the Kali Linux archive key to the system
echo "Adding Kali Linux archive key..."
sudo apt-key add archive-key.asc

# Update the package list once more to include Kali Linux packages
echo "Updating package list with Kali Linux packages..."
sudo apt update

# Set package preferences to avoid conflicts
echo "Setting package preferences for Kali Linux..."
sudo sh -c "echo 'Package: *'>/etc/apt/preferences.d/kali.pref; echo 'Pin: release a=kali-rolling'>>/etc/apt/preferences.d/kali.pref; echo 'Pin-Priority: 50'>>/etc/apt/preferences.d/kali.pref"

# Update the package list a final time
echo "Final update of the package list..."
sudo apt update

echo "Kali Linux repository and packages are configured."

# ------------------- Tool Installs ------------------- #

# Define a list of tools to install from default repositories
default_tools=(
    smbclient
    netcat-traditional
    nmap
)

# Install tools from default repositories
for tool in "${default_tools[@]}"; do
    sudo apt install -y "$tool"
done

echo "Tools installed from default repositories."

# Define a list of Kali tools to install
kali_tools=(
    nmap-common
    john
    python3-impacket
    impacket-scripts
    wordlists
    seclists
    dirsearch
    metasploit-framework
    bloodhound
    bloodhound.py
    sqlmap
    ffuf
    wfuzz
    dnsrecon
    crackmapexec
    evil-winrm
    hashcat
)

# Install the tools from the Kali Repository
for tool in "${kali_tools[@]}"; do
    sudo apt install -y "$tool" -t kali-rolling
done

echo "Kali tools from the Kali Repository are installed."


# Additional configurations and cleanup

# Gunzip the rockyou wordlist if necessary
echo "Checking and gunzipping the rockyou wordlist..."
if [ -f /usr/share/wordlists/rockyou.txt.gz ]; then
    sudo gunzip /usr/share/wordlists/rockyou.txt.gz
fi

# Reminders
echo "Don't forget to install the following tools manually:"
echo "Choose your poison: Burp Suite, ZAP, or Caido"

echo "Install any additional tools via the 'sudo apt install TOOL -y -t kali-rolling' command."

echo "Setup completed. Happy hacking!"
