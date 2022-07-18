# apt
echo "deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse">/etc/apt/sources.list

apt update

apt install build-essential wget tmux vim openssh-server software-properties-common

# tmux
echo "set -g mouse on">>~/.tmux.conf

# pip
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# conda
echo "channels:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/
ssl_verify: true">~/.condarc

echo "# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/mnt/gaodawei.gdw/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/mnt/gaodawei.gdw/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/mnt/gaodawei.gdw/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/mnt/gaodawei.gdw/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<" >> ~/.bashrc

# enable remote debug
echo "s/#AddressFamily any/AddressFamily any/g" > ssh.sed
echo "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g" >> ssh.sed
echo "s/#PasswordAuthentication yes/PasswordAuthentication yes/g" >> ssh.sed
sed -i -f ssh.sed /etc/ssh/sshd_config
rm ssh.sed

# cuda
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin

mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600

wget https://developer.download.nvidia.com/compute/cuda/11.4.0/local_installers/cuda-repo-ubuntu1804-11-4-local_11.4.0-470.42.01-1_amd64.deb

dpkg -i cuda-repo-ubuntu1804-11-4-local_11.4.0-470.42.01-1_amd64.deb
apt-key add /var/cuda-repo-ubuntu1804-11-4-local/7fa2af80.pub
apt-get update
apt-get -y install cuda

export LD_LIBRARY_PATH=/usr/local/cuda-11.7/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
