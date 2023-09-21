#!/bin/bash

#***********************************************************************
# !!!! WARNING !!!! WARNING !!!! WARNING !!!! WARNING !!!! WARNING !!!!
# When the VPN client is updated this script will NOT work
# If there are any problems check the download URL first
#***********************************************************************

# Bash script to automate Cisco Secure Client installation

# Download the tarball
wget https://www2.ucsc.edu/its2/software/CiscoSecureClient/cisco-secure-client-linux64-5.0.03072-predeploy-k9.tar.gz

# Extract the tarball
tar -xvzf cisco-secure-client-linux64-5.0.03072-predeploy-k9.tar.gz

# Change directory
cd cisco-secure-client-linux64-5.0.03072/vpn/

# Install openssh-clients if not already installed
sudo dnf install -y openssh-clients

# Run the installation script
sudo ./vpn_install.sh

# Pause the script and ask if the user is connected to the VPN
while true; do
    echo "Please take the time to go connect to the campusVPN, once you have connected we can continue connecting."
    read -r -p "Have you connected to the VPN? [y]: " response
    case $response in
        [yY]|[yY][eE][sS])
            echo "Continuing with the rest of the script..."
            break
            ;;
        *)
            echo "Invalid input. Please enter 'yes' or 'y' to confirm you have connected to the VPN."
            ;;
    esac
done


#Now checking for SSH keys, and creating them if they are not present. Hopefully
#WARNING This script assumes that the user's SSH keys are stored in the default location (~/.ssh). Change the script accordingly if a different path is used.

# Initialize an empty array to hold the names of SSH key files
ssh_keys=()

# Check the ~/.ssh directory for key files and add them to the array
for filename in $HOME/.ssh/id_*; do
  [ -e "$filename" ] || continue
  if [[ ! "$filename" =~ \.pub$ ]]; then
    ssh_keys+=($(basename $filename))
  fi
done

# Check if we found any keys
if [ ${#ssh_keys[@]} -eq 0 ]; then
  echo "No existing SSH keys found."
else
  echo "Found the following SSH keys:"
  for i in "${!ssh_keys[@]}"; do
    echo "$((i+1)). ${ssh_keys[i]}"
  done

  # Ask if the user wants to display a public key
  read -r -p "Would you like to display the public key for any of these? [y/n]: " response
  if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    if [ ${#ssh_keys[@]} -gt 1 ]; then
      read -r -p "Which one would you like to display? (Enter the number): " choice
      key_to_display=${ssh_keys[$((choice-1))]}
    else
      key_to_display=${ssh_keys[0]}
    fi

    if [ -f "$HOME/.ssh/$key_to_display.pub" ]; then
      echo "Displaying public key for $key_to_display:"
      cat "$HOME/.ssh/$key_to_display.pub"
    else
      echo "Public key file for $key_to_display not found."
    fi
  fi
fi

