#/bin/bash

mkdir -p /workspaces/osu-uwrt
vcs import < /riptide.repos /workspaces/osu-uwrt --recursive

apt update
rosdep update
apt upgrade -y

if ! [ -f /workspaces/osu-uwrt/.ignored ]; then

  touch /workspaces/osu-uwrt/.ignored
  touch /workspaces/osu-uwrt/dependencies/src/zed_ros2_wrapper/COLCON_IGNORE
  touch /workspaces/osu-uwrt/software/src/riptide_perception/tensor_detector/COLCON_IGNORE

  cp -r /scripts/user-scripts/* /workspaces/osu-uwrt

fi

if ! [ -f /.init ]; then

  ln -s /workspaces/osu-uwrt ~/osu-uwrt

  touch /.init

fi

source /opt/ros/humble/setup.bash

rosdep install --from-paths /workspaces/osu-uwrt/dependencies/src --ignore-src -r -y
cd /workspaces/osu-uwrt/dependencies
colcon build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=1
source ./install/setup.bash


rosdep install --from-paths /workspaces/osu-uwrt/software/src --ignore-src -r -y
cd ../software/
colcon build --packages-select riptide_meshes
source /workspaces/install/setup.bash
colcon build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=1

