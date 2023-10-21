#!/bin/bash

if [[ $UID != 0 ]]; then
	echo "Please start the script as root or sudo!"
	exit 1
fi

# add group and user
groupadd uwrt
adduser $SUDO_USER uwrt

# add video and serial permissions
usermod -a -G video $SUDO_USER
usermod -a -G dialout $SUDO_USER

# addudev rule
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # get directory where this script is stored
cp $DIR/riptide.rules /etc/udev/rules.d/
cp $DIR/rp2040.rules /etc/udev/rules.d/

#reload udev
udevadm control --reload-rules

echo "Successfully added hardware rules"
