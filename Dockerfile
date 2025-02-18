FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

USER root

COPY scripts /scripts

RUN apt update && apt upgrade -y
RUN apt install -y wget clang nano vim curl libboost-all-dev software-properties-common

# Install LLVM Clang
RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
RUN apt install -y clang-tidy-18

RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

RUN apt update
RUN apt install -y ros-humble-ros-base ros-dev-tools

# Setup script to install ros-humble-desktop seperatly

RUN mkdir -p /workspaces/osu-uwrt/

RUN wget https://raw.githubusercontent.com/osu-uwrt/riptide_setup/humble/setup_scripts/dev_install/riptide.repos

# Make it easy to source packages
RUN echo "alias src=\"source ~/.bashrc\"" >> ~/.bashrc
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
RUN echo "source /workspaces/osu-uwrt/dependencies/install/setup.bash" >> ~/.bashrc
RUN echo "source /workspaces/osu-uwrt/software/install/setup.bash" >> ~/.bashrc

RUN rosdep init

CMD ["bash", "/scripts/entrypoint.bash"]
