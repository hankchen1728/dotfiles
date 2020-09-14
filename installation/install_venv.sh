# Shell script for virtual environment installation
# bash install_venv.sh [venv_name] [requirements.txt]
VIRTUALVENV_NAME=${1:-"ml_venv"}
Requirements=${2:-"requirements.txt"}
PYTHON3="python3/3.6.8"

module load $PYTHON3

# Create virualenv
virtualenv $VIRTUALVENV_NAME --no-site-packages

# Unload python3
module rm $PYTHON3

# source the virtaul env
source ${VIRTUALVENV_NAME}/bin/activate
pip3 install -r $Requirements

deactivate
