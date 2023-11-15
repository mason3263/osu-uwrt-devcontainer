#/bin/bash

if [ ! -d ~/osu-uwrt/development ]; then
    bash ~/scripts/install_dev/install_dev.bash
    sudo rm -r ~/osu-uwrt/.vscode
    sudo mv ~/vscode ~/osu-uwrt/.vscode
fi