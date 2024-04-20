FROM ros:humble

USER 0:0

COPY scripts /scripts

RUN apt update && apt upgrade -y
RUN apt install -y wget ros-humble-desktop

RUN mkdir -p /osu-uwrt/

RUN wget https://raw.githubusercontent.com/osu-uwrt/riptide_setup/humble/setup_scripts/dev_install/riptide.repos
RUN vcs import < /riptide.repos /osu-uwrt --recursive

RUN touch /osu-uwrt/dependencies/src/zed_ros2_wrapper/COLCON_IGNORE
RUN touch /osu-uwrt/software/src/riptide_perception/tensor_detector/COLCON_IGNORE

RUN rosdep update
RUN rosdep install --from-paths /osu-uwrt/dependencies/src --ignore-src -r -y
RUN rosdep install --from-paths /osu-uwrt/software/src --ignore-src -r -y

RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
RUN echo "source /root/osu-uwrt/dependencies/install/setup.bash" >> ~/.bashrc
RUN echo "source /root/osu-uwrt/software/install/setup.bash" >> ~/.bashrc

CMD ["bash", "/scripts/entrypoint.bash"]