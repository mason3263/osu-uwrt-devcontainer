FROM mcr.microsoft.com/vscode/devcontainers/base:jammy

USER vscode
WORKDIR /home/vscode/


COPY ./scripts ./scripts

#RUN ~/scripts/install_ros.bash
#RUN ~/scripts/install_dev/install_dev.bash

#USER root
#RUN /home/vscode/scripts/hardware/add_rule.bash

#USER vscode
#RUN ~/scripts/setup_bashrc.bash

#RUN mv ~/osu-uwrt ~/osu-uwrt-template
#RUN mkdir ~/osu-uwrt