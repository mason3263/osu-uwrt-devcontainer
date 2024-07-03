#/bin/bash

 mv /scripts/rosdep.bash /workspaces/osu-uwrt

 source /opt/ros/humble/setup.bash

 cd /workspaces/osu-uwrt/dependencies
 colcon build
 source ./install/setup.bash

 cd ../software/
 colcon build --packages-select riptide_meshes
 source /workspaces/install/setup.bash
 colcon build
