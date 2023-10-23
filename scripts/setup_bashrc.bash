#!/bin/bash

s1="source /opt/ros/humble/setup.bash"
s2="source ~/osu-uwrt/development/dependencies/install/setup.bash"
s3="source ~/osu-uwrt/development/software/install/setup.bash"


echo "$s1" >> ~/.bashrc
echo "$s2" >> ~/.bashrc
echo "$s3" >> ~/.bashrc
