#/bin/bash

PROG=`dirname $0`/l2-switch.p4

/extra/tools/p4_build.sh -DUSE_ALPM      --with-suffix=.alpm          $PROG
/extra/tools/p4_build.sh -DONE_STAGE     --with-suffix=.one_stage     $PROG
/extra/tools/p4_build.sh -DBYPASS_EGRESS --with-suffix=.bypass_egress $PROG
/extra/tools/p4_build.sh $PROG
