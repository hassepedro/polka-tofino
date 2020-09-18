#!/bin/bash

tmux -C &
sleep 2
if [ $(hostname) == "frankfurt" ];then
    tmux neww -d './run_tofino_model.sh -p polka -f ./ports2.json; tmux wait -S model' &
elif [ $(hostname) == "amsterdam" ];then
    tmux neww -d './run_tofino_model.sh -p polka -f ./ports2.json; tmux wait -S model' &
else
    tmux neww -d './run_tofino_model.sh -p polka -f ./ports.json; tmux wait -S model' &
sleep 10
tmux neww -d './run_switchd.sh -p polka; tmux wait -S switchd' &
