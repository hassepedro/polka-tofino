/**********************  T U N N E L   E N C A P   ************************/
control process_tunnel_encap(
    /* User */
    inout ingress_headers_t                       hdr,
    inout ingress_metadata_t                      meta,
    /* Intrinsic */
    in    ingress_intrinsic_metadata_t               ig_intr_md,
    in    ingress_intrinsic_metadata_from_parser_t   ig_prsr_md,
    inout ingress_intrinsic_metadata_for_deparser_t  ig_dprsr_md,
    inout ingress_intrinsic_metadata_for_tm_t        ig_tm_md) {

    action tdrop() {
        ig_dprsr_md.drop_ctl = 1;
    }

    action send(PortId_t port) {
        ig_tm_md.ucast_egress_port = port;
        #ifdef BYPASS_EGRESS
        ig_tm_md.bypass_egress = 1;
        #endif
    }


    action add_sourcerouting_header (egressSpec_t port, bit<1> sr, macAddr_t dmac,
                                     routeid_t routeIdPacket){

        send(port);
        meta.apply_sr = sr;
        hdr.ethernet.dstAddr = dmac;
        hdr.srcRoute.setValid();
        hdr.srcRoute.routeId = routeIdPacket;
    }

    table tunnel_encap_process_sr {
        key = {
            hdr.ipv4.dstAddr: lpm;
        }
        actions = {
            add_sourcerouting_header;
            tdrop;
        }
        size = 1024;
        default_action = tdrop();
    }

    apply {
        tunnel_encap_process_sr.apply();
        if (meta.apply_sr != 1) {
            hdr.srcRoute.setInvalid();
        } else {
            hdr.ethernet.etherType = TYPE_SRCROUTING;
        }
    }

}
