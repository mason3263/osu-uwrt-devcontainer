FROM mcr.microsoft.com/vscode/devcontainers/base:jammy

USER vscode
WORKDIR /home/vscode/


COPY ./scripts ./scripts
COPY ./vscode ./vscode

RUN ~/scripts/install_ros.bash

USER root
RUN /home/vscode/scripts/hardware/add_rule.bash

USER vscode
RUN ~/scripts/setup_bashrc.bash