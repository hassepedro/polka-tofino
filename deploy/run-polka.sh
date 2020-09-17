#!/usr/bin/env bash
export SDE=/extra/bf-sde-9.2.0
export SDE_INSTALL=$SDE/install
export PATH=$PATH:$SDE_INSTALL/bin
POLKA_PATH=/home/vagrant/polka-tofino/p4src

if [ $EUID -ne 0 ]; then
    echo "Please run as sudo."
    exit 1
fi

L_IRPOLY=("0x002d" "0x002d" "0x002b" "0x0039" "0x003f")

# Configuring PolKA
cd $POLKA_PATH && git pull
sed -i "s/${L_IRPOLY[0]}/${L_IRPOLY[$1]}/g" $POLKA_PATH/include/ingress.p4
# Compiling PolKA solution
cd $POLKA_PATH && ./build.sh && ./p4_build.sh polka.p4
sleep 2
./run_terminals.sh &