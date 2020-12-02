/***************** M A T C H - A C T I O N  *********************/
control Ingress(
    /* User */
    inout ingress_headers_t                       hdr,
    inout ingress_metadata_t                      meta,
    /* Intrinsic */
    in    ingress_intrinsic_metadata_t               ig_intr_md,
    in    ingress_intrinsic_metadata_from_parser_t   ig_prsr_md,
    inout ingress_intrinsic_metadata_for_deparser_t  ig_dprsr_md,
    inout ingress_intrinsic_metadata_for_tm_t        ig_tm_md) {

    action drop() {
        ig_dprsr_md.drop_ctl = 1;
    }

    action forward(PortId_t port) {
        ig_tm_md.ucast_egress_port = port;
    }

    table l2fwd {
        key = {
            hdr.ethernet.dstAddr: exact;
        }
    
        actions = {
            forward;
            NoAction;
        }
        size = 256;
        default_action = NoAction;
    }

    apply {
        l2fwd.apply();
    }

}