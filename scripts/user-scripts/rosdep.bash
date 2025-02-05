#!/bin/bash

rosdep update
rosdep install --from-paths /workspaces/osu-uwrt/ --ignore-src -r -y