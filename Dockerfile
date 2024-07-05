FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

USER root

COPY scripts /scripts

RUN apt update && apt upgrade -y
RUN apt install -y wget clang nano vim curl

RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

RUN apt update
RUN apt install ros-humble-base ros-dev-tools

# Setup script to install ros-humble-desktop seperatly

RUN mkdir -p /workspaces/osu-uwrt/

RUN wget https://raw.githubusercontent.com/osu-uwrt/riptide_setup/humble/setup_scripts/dev_install/riptide.repos

# Move Commands to Save Space
#RUN vcs import < /riptide.repos /workspaces/osu-uwrt --recursive

#RUN touch /workspaces/osu-uwrt/dependencies/src/zed_ros2_wrapper/COLCON_IGNORE
#RUN touch /workspaces/osu-uwrt/software/src/riptide_perception/tensor_detector/COLCON_IGNORE

#RUN rosdep update
#RUN rosdep install --from-paths /workspaces/osu-uwrt/dependencies/src --ignore-src -r -y
#RUN rosdep install --from-paths /workspaces/osu-uwrt/software/src --ignore-src -r -y

RUN echo "CC=\"/usr/bin/clang\"" >> ~/.bashrc
RUN echo "CXX=\"/usr/bin/clang++\"" >> ~/.bashrc
RUN echo "alias src=\"source ~/.bashrc\"" >> ~/.bashrc

RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
RUN echo "source /workspaces/osu-uwrt/dependencies/install/setup.bash" >> ~/.bashrc
RUN echo "source /workspaces/osu-uwrt/software/install/setup.bash" >> ~/.bashrc

CMD ["bash", "/scripts/entrypoint.bash"]
