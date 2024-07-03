#/bin/bash

vcs import < /riptide.repos /workspaces/osu-uwrt --recursive

if ! [ -f /workspaces/ignored ]; then

  touch /workspaces/ignored
  touch /workspaces/osu-uwrt/dependencies/src/zed_ros2_wrapper/COLCON_IGNORE
  touch /workspaces/osu-uwrt/software/src/riptide_perception/tensor_detector/COLCON_IGNORE

fi

if ! [ -f /init ]; then

  touch /init

  rosdep update
  rosdep install --from-paths /workspaces/osu-uwrt/dependencies/src --ignore-src -r -y
  rosdep install --from-paths /workspaces/osu-uwrt/software/src --ignore-src -r -y

  ln -s /workspaces/osu-uwrt ~/osu-uwrt

fi

source /opt/ros/humble/setup.bash

cd /workspaces/osu-uwrt/dependencies
colcon build
source ./install/setup.bash

cd ../software/
colcon build --packages-select riptide_meshes
source /workspaces/install/setup.bash
colcon build

sleep inf
