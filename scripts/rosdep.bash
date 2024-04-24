#!/bin/bash

rosdep update
rosdep install --from-paths /root/osu-uwrt/ --ignore-src -r -y