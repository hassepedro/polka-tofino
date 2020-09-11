#!/bin/bash

sudo tmux -C
tmux neww -d './run_tofino_model.sh -p polka; tmux wait -S model'
tmux neww -d './run_switchd.sh -p polka; tmux wait -S switchd'
