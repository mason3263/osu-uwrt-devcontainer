#/bin/bash

export ROS_DISTRO="humble"

sudo apt update
sudo apt upgrade -y
sudo apt install python3-pip --yes
python3 -m pip install --upgrade pip
sudo python3 -m pip install vcstool
sudo python3 -m pip install transforms3d

# add ros key to keyring
sudo apt update && sudo apt install curl gnupg lsb-release -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg

# add ros2 repos to the sources.list
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] \
 http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" \
 | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

sudo apt update
sudo apt install ros-${ROS_DISTRO}-desktop -y

sudo apt install python3-rosdep python3-colcon-common-extensions python3-colcon-clean -y

sudo rosdep init
rosdep update

echo "Downloading Pico utils"
sudo apt install -y cmake gcc-arm-none-eabi libnewlib-arm-none-eabi build-essential

# install vision msgs
sudo apt install ros-humble-vision-msgs -y