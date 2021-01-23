# This script is used to launch jupyter notebook on remote Linux machine.
# Please load your environment (e.g. python virtual environment)
# and drivers (e.g. CUDA and CUDNN) before running this script. 
# Usage: 
#       bash ./launch_jupyter.sh [port]

# source /data2/cardiovascular/env/cv_venv/bin/activate

module load cuda/10.0
module load cudnn-7.4/10.0

PORT=${1:-8016}

jupyter notebook --no-browser --ip=$(curl ifconfig.me) --port=$PORT
