FROM pohzhiee/cudagl_ros2_gazebo:latest

ARG DEBIAN_FRONTEND=noninteractive
USER defaultuser
SHELL ["/bin/bash", "-c"]

# Build biped_ros2
RUN git clone https://github.com/siw-engineering/biped_ros2 /home/defaultuser/biped_ros2

WORKDIR /home/defaultuser/biped_ros2
RUN mkdir src
RUN vcs import --recursive src < main.repos
RUN vcs import src < optional.repos

RUN . /opt/ros/dashing/setup.bash \
    && colcon build

# Install anaconda
WORKDIR /home/defaultuser
RUN wget https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh
RUN /bin/bash Anaconda3-2019.10-Linux-x86_64.sh -b

# # Set path to conda
ENV PATH /home/defaultuser/anaconda3/bin:$PATH

# Updating Anaconda packages
RUN conda update conda
RUN conda update anaconda
RUN conda update --all

# Create conda virtual environment
RUN conda create -n conda_env python=3.6 tensorflow-gpu=1.14.0

# Clone spinning up
RUN git clone https://github.com/pohzhiee/spinningup /home/defaultuser/spinningup

# Run spinning up
WORKDIR /home/defaultuser
COPY run.sh .
RUN source activate conda_env \
    && cd /home/defaultuser/spinningup && pip install -e . \
    && pip install pybullet catkin-pkg pyyaml==3.12 empy==3.3.2 lark-parser==0.7.2
    
ENTRYPOINT ["/bin/bash", "/home/defaultuser/run.sh"]