#!/bin/bash
# WARNING Might not be able to run standalone, not tested. -Bryce


#TODO: Should check to see if SSH Keys are already generated first

# 
# Loop asking the user for their CruzID until the user confirms their CruzID
while true; do
  # Ask the user for their CruzID
  read -p "Enter your CruzID: " CruzID
  
  # Show the entered CruzID and ask for confirmation
  read -p "You entered '$CruzID'. Is this correct? [y/n]: " confirm
  
  # Check if the user confirmed
  if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
    break
  elif [[ "$confirm" == "n" || "$confirm" == "N" ]]; then
    echo "Please re-enter your CruzID."
  else
    echo "Invalid option. Please re-enter your CruzID."
  fi
done

# Define SSH directory and config file
# THIS MAY NEED TO BE CHANGED IF YOUR .SSH IS NOT IN DEFAULT LOCATION
SSH_DIR="$HOME/.ssh"
CONFIG_FILE="$SSH_DIR/config"

# Check if ~/.ssh directory exists and if it doesn't create it.
if [ ! -d "$SSH_DIR" ]; then
  echo "Creating $SSH_DIR directory..."
  mkdir -p "$SSH_DIR"
else
  echo "Current permissions for $SSH_DIR:"
  stat -c '%A %a %n' "$SSH_DIR"
fi

# Ensure correct permissions for ~/.ssh directory
chmod 700 "$SSH_DIR"		#Give read write & execute permissions to directory

# Check if ~/.ssh/config file exists and if it doesnt create it
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Creating $CONFIG_FILE..."
  touch "$CONFIG_FILE"
else
  echo "Current permissions for $CONFIG_FILE:"
  stat -c '%A %a %n' "$CONFIG_FILE"
fi

# Ensure correct permissions for ~/.ssh/config file
chmod 600 "$CONFIG_FILE"	#Give read & write permissions to the config file

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
