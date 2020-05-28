#!/bin/bash
#! -*- coding: utf-8 -*-
sudo apt update
sudo apt install -y \
	curl \
	gnupg2 \
	lsb-release

curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo sh -c 'echo "deb http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'

sudo apt update
sudo apt install -y \
	build-essential \
	cmake \
	git \
	libbullet-dev \
	python3-colcon-common-extensions \
	python3-flake8 \
	python3-pip \
	python3-pytest-cov \
	python3-rosdep \
	python3-setuptools \
	python3-vcstool \
	wget

python3 -m pip install -U \
	argcomplete \
	flake8-blind-except \
	flake8-builtins \
	flake8-class-newline \
	flake8-comprehensions \
	flake8-deprecated \
	flake8-docstrings \
	flake8-import-order \
	flake8-quotes \
	pytest-repeat \
	pytest-rerunfailures \
	pytest

sudo apt install --no-install-recommends -y \
	libasio-dev \
	libtinyxml2-dev \
	libcunit1-dev

mkdir -p $HOME/ros2_foxy/src
cd $HOME/ros2_foxy

wget https://raw.githubusercontent.com/ros2/ros2/master/ros2.repos
vcs import src < ros2.repos

sudo rosdep init
rosdep update
rosdep install --from-paths src --ignore-src --rosdistro foxy -y --skip-keys "console_bridge fastcdr fastrtps rti-connext-dds-5.3.1 urdfdom_headers"

cd $HOME/ros2_foxy
colcon build --symlink-install

echo "source `$HOME`/ros2_foxy/install/setup.bash" >> $HOME/.bashrc
