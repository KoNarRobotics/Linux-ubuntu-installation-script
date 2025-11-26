 #!/bin/bash

if [[ $EUID -eq 0 ]]; then
  echo "This script shouldn't be run as root or with sudo it will ask for sudo password when needed only once"
  echo "Exiting..."
  exit 1
fi

MAIN_FILE_DIR=$(dirname "$(readlink -f "$0")")
echo "Script directory: $MAIN_FILE_DIR"

upd-ugr(){
  sudo apt-get update -y && sudo apt-get upgrade -y
}


upd-ugr


#************************************************************************************************************************************************************************************
#install required packages
sudo apt-get install -y \
    cmake \
    make \
    ninja-build \
    git \
    build-essential \
    gdb \
    wireguard \
    resolvconf \
    nvtop \
    htop \
    net-tools \
    can-utils \
    stlink-tools \
    dfu-util \
    udevadm \
    stty \
    libncursesw5 \
    curl \
    ethtool \
    curl \
    ccache \
    clang \
    clang-format \
    clang-tidy \
    openocd 

#************************************************************************************************************************************************************************************
#install sna[ packages
sudo snap install \
    bashtop


#************************************************************************************************************************************************************************************
#install docker
sudo apt-get update -y 
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
upd-ugr

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo docker run hello-world

# add user to docker group and activate changes
sudo groupadd docker
sudo usermod -aG docker $USER
upd-ugr

#************************************************************************************************************************************************************************************
#install ros2

# sudo apt-get update && sudo apt-get install -y locales
# sudo locale-gen en_US en_US.UTF-8
# sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
# export LANG=en_US.UTF-8

# sudo apt-get install -y software-properties-common
# sudo add-apt-repository universe -y

# sudo apt update && sudo apt install curl -y
# export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\" '{print $4}')
# curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo ${UBUNTU_CODENAME:-${VERSION_CODENAME}})_all.deb"
# sudo dpkg -i /tmp/ros2-apt-source.deb

# upd-ugr
# sudo apt-get install -y ros-jazzy-desktop ros-jazzy-ros-base ros-dev-tools
# source /opt/ros/humble/setup.bash

# ## BASH ALIASES
# echo "alias ros_jazzy="source /opt/ros/jazzy/setup.bash"
# alias ros_local="source install/local_setup.bash"
# alias ros_build="colcon build && ros_local"
# alias can_init="sudo ip link set dev can0 up type can bitrate 1000000"

# alias srj="source /opt/ros/jazzy/setup.bash"
# alias srl="source install/setup.bash"
# alias srr="source /opt/ros/jazzy/setup.bash && source install/setup.bash"
# " >> ~/.bashrc
# ## BASH ALIASES END


#************************************************************************************************************************************************************************************
# install vscode
outfile=$(mktemp)
curl -L -o $outfile "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
sudo dpkg -i $outfile
rm $outfile


#************************************************************************************************************************************************************************************
# install kciad
outfile=$(mktemp)
sudo add-apt-repository ppa:kicad/kicad-9.0-releases
sudo apt update
sudo apt-get install kicad -y



#************************************************************************************************************************************************************************************
# generate ssh-keyrings
if [ ! -d ~/.ssh/id_ed25519.pub ]; then
  ssh-keygen -t ed25519 -N "" -f ~/.ssh/id_ed25519
  echo "Your ssh puiblic key"
  cat ~/.ssh/id_ed25519.pub
fi

# creat eneccessary directioies
mkdir -p ~/.local/bin
mkdir -p ~/.local/share

#************************************************************************************************************************************************************************************
# install discord
outfile=$(mktemp)
curl -L -o $outfile "https://discord.com/api/download?platform=linux&format=deb"
sudo dpkg -i $outfile
rm -rf $outfile


#************************************************************************************************************************************************************************************
upd-ugr
sudo apt-get autoclean -y
sudo apt-get autoremove -y
sudo apt-get autoclean -y


************************************************************************************************************************************************************************************
configure user groups

cd $MAIN_FILE_DIR
wget https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel1/binrel/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz
tar -xf arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz
mv arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi ~/.local/share/arm-gnu-toolchain-14

## PROFILE PATHS
cat <<'PROFILE_APPEND' >> ~/.profile
# Add the arm-none-aebi to the path
if [ -d "$HOME/.local/share/arm-gnu-toolchain-14/bin" ]; then
    PATH="$HOME/.local/share/arm-gnu-toolchain-14/bin:$PATH"
fi
PROFILE_APPEND
## PROFILE PATHS END

source ~/.profile
rm -rf arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz

# add user to dialout group which allows access to serial ports
sudo usermod -aG dialout $USER
newgrp dialout


