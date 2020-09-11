#!/bin/bash

sudo tmux -C &
sudo tmux neww -d 'cd /home/vagrant/polka-tofino/p4src; ./run_tofino_model.sh -p polka -f ./ports.json; tmux wait -S model' &
sudo tmux neww -d 'cd /home/vagrant/polka-tofino/p4src; ./run_switchd.sh -p polka; tmux wait -S switchd' &
