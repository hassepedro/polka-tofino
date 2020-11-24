#!/bin/bash
main="polka.p4"
output="polka"

if [ "${POLKA_TYPE}" == "" ]; then
    POLKA_TYPE="POLKA_CORE"
    ## Uncoment this to compile the edge version
    #POLKA_TYPE="POLKA_EDGE"
fi
bf-p4c -D ${POLKA_TYPE} --std p4-16 --target tofino --arch tna -o ./${output} --bf-rt-schema ./${output}/bf-rt.json -g --verbose 3 --parser-timing-reports --display-power-budget --create-graphs ${main}
