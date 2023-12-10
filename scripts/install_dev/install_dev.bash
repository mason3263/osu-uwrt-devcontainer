#!/bin/bash

export ROS_DISTRO="humble"

sudo apt update

# make all the directories
mkdir -p ~/osu-uwrt/development
cd ~/osu-uwrt/development

echo "Starting ROSDEP"
rosdep update

echo "Importing repositories"
vcs import < ~/scripts/install_dev/riptide.repos . --recursive
vcs pull

touch ~/osu-uwrt/development/titan_firmware/COLCON_IGNORE

python3 ~/scripts/install_dev/package_disable.py zed
python3 ~/scripts/install_dev/package_disable.py tensor_detector

cd ~/osu-uwrt/development/dependencies

rosdep install --from-paths src --ignore-src --rosdistro $ROS_DISTRO -y -r
source /opt/ros/$ROS_DISTRO/setup.bash
colcon build

# build development software (this should pass)
echo "Building riptide software"
cd ~/osu-uwrt/development/software
rosdep install --from-paths src --ignore-src --rosdistro $ROS_DISTRO -y -r
source /opt/ros/$ROS_DISTRO/setup.bash
source ~/osu-uwrt/development/dependencies/install/setup.bash
colcon build