#!/bin/bash
set -e

# setup ros2 environment
source "/home/defaultuser/biped_ros2/install/setup.bash"
source activate conda_env
python -m spinup.run td3 --env LobotArmContinuous-v2 --exp_name random_goal_1