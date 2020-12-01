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

    action send(PortId_t port) {
        // the ports begins as 128 stepping 8
        // ig_tm_md.ucast_egress_port = (PortId_t) PORT_TRANSLATE(port);
        ig_tm_md.ucast_egress_port = port;
#ifdef BYPASS_EGRESS
        ig_tm_md.bypass_egress = 1;
#endif      // BYPASS_EGRESS
    }

    action srcRoute_nhop() {
        meta.port = (bit<9>)hdr.srcRoutes[0].port;
        hdr.srcRoutes.pop_front(1);
    }

    action srcRoute_finish() {
        hdr.ethernet.etherType = TYPE_IPV4;
    }

    apply {
        if (hdr.srcRoutes[0].isValid()){
            srcRoute_nhop();
            send(meta.port);
        } else {
            drop();
        }
    }
}
