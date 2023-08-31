#!/bin/bash -i

# create python virtual environment:
echo "Creating virtual environment..."
python3 -m venv .venv
source .venv/bin/activate

pip3 install --no-cache-dir --use-deprecated=legacy-resolver -U wheel pip==22.* ipython ipykernel -r docker/datascience/requirements.txt

ipython kernel install --name $PROJECT_NAME --user

echo "--------------------------------------------------"
echo "Installation completed..."
echo "--------------------------------------------------"
