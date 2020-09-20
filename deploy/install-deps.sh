#!/usr/bin/env bash
export SDE=/extra/bf-sde-9.2.0
export SDE_INSTALL=$SDE/install
export PATH=$PATH:$SDE_INSTALL/bin
POLKA_PATH=/home/vagrant/polka-tofino/p4src

if [ $EUID -ne 0 ]; then
    echo "Please run as sudo."
    exit 1
fi
 
if [ ! -f ~/runonce ]
then 
    # Configure the environment
    sudo cat <<EOF > /etc/profile.d/barefoot.sh
export SDE=/extra/bf-sde-9.2.0
export SDE_INSTALL=$SDE/install
export PATH=$PATH:$SDE_INSTALL/bin
EOF

    ### Install the P4 Studio 9.2.0
    # UNpack bf-sde and br-tools files 
    tar xvf ~/p4studio/bf-sde-9.2.0.tar -C /extra/
    tar xvf ~/p4studio/ba-tools.tar -C /extra/

    # Check and wait until dpkg system to be unlocked
    while sudo fuser /var/{lib/{dpkg,apt/lists},cache/apt/archives}/lock >/dev/null 2>&1; do
        sleep 1
    done
    # Install based on switch_p4_16 profile 
    cd $SDE/p4studio_build && ./p4studio_build.py --use-profile switch_p416_profile
    
    # Creating virtual interfaces
    /extra/tools/veth_setup.sh

    # ONCE RUN CODE HERE
    touch ~/runonce
    # Install requirements 
    # sudo apt install iperf3 jq -y
fi



