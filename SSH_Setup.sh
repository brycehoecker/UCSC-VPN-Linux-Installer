#!/bin/bash
# WARNING Might not be able to run standalone, not tested. -Bryce


#Should check to see if SSH Keys 

# Ask the user for their CruzID
read -p "Enter your CruzID: " CruzID

# Define SSH directory and config file
SSH_DIR="$HOME/.ssh"
CONFIG_FILE="$SSH_DIR/config"

# Check if ~/.ssh directory exists and if it doesn't create it.
if [ ! -d "$SSH_DIR" ]; then
  echo "Creating $SSH_DIR directory..."
  mkdir -p "$SSH_DIR"
  chmod 700 "$SSH_DIR"
fi

# Check if ~/.ssh/config file exists and if it doesnt create it
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Creating $CONFIG_FILE..."
  touch "$CONFIG_FILE"
  chmod 600 "$CONFIG_FILE"
fi

# Append ssh configuration to config file
echo "Appending hb server configuration to $CONFIG_FILE..."

cat <<EOL >> "$CONFIG_FILE"
# Configuration for hb.ucsc.edu
Host hb
  HostName hb.ucsc.edu
  User $CruzID
EOL

echo "Done!"
echo "You should be able to ssh into hummingbird by just typing 'ssh hb' now!
