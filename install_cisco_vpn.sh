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
