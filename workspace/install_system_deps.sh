#!/bin/bash -i

echo "Installing system dependencies..."
apt-get -o Acquire::https::Verify-Peer=false update -yqq \
&& apt-get -o Acquire::https::Verify-Peer=false install -y --no-install-recommends \
    nano \
&& apt-get autoremove -yqq --purge \
&& apt-get clean

echo "--------------------------------------------------"
echo "Installation completed..."
echo "--------------------------------------------------"