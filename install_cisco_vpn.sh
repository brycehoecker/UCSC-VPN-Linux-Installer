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

# TODO: ADD THE COMMAND TO RUN THE NEXT SSH SETUP SCRIPT
