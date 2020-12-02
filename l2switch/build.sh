#!/bin/bash
output="l2-switch"
main="${output}.p4"

bf-p4c --std p4-16 --target tofino --arch tna -o ./${output} --bf-rt-schema ./${output}/bf-rt.json \
        -g --verbose 3 --parser-timing-reports --display-power-budget --create-graphs ${main}