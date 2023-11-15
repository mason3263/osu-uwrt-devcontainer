#/bin/bash

if [ ! -d ~/osu-uwrt/development ]; then
    mv ~/osu-uwrt-template/* ~/osu-uwrt
fi

if [ ! -d ~/osu-uwrt/.vscode ]; then
    mv ~/.vscode ~/osu-uwrt/.vscode
fi