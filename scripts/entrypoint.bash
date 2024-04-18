#/bin/bash

if [ ! -d ~/osu-uwrt/software ]; then
    mv /osu-uwrt/* ~/osu-uwrt
    source /opt/ros/humble/setup.bash

    cd ~/osu-uwrt/dependencies
    colcon build
    source ./install/setup.bash

    cd ../software/
    colcon build --packages-select riptide_meshes
    source ./install/setup.bash
    colcon build
fi