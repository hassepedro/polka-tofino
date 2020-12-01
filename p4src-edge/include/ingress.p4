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

    // this time is calculated by subtracting 
    // ig_intr_md.ingress_mac_tstamp from ig_intr_md_from_parser_aux.ingress_global_tstamp.
    action timestamp_r(){
        bit<48> time_a = ig_intr_md.ingress_mac_tstamp;
        bit<48> time_b = ig_prsr_md.global_tstamp;
        bit<32> time_c = eg_intr_md.enq_tstamp;
    }

    apply {
        if (hdr.ipv4.isValid() && hdr.vlan.etherType != TYPE_SRCROUTING) {
            process_tunnel_encap.apply(hdr, meta, ig_intr_md, ig_prsr_md, ig_dprsr_md, ig_tm_md);
        } else if (hdr.vlan.etherType == TYPE_SRCROUTING) {
            hdr.vlan.etherType = TYPE_IPV4;
            hdr.srcRoute.setInvalid();
            // this value is really hard-coded? (Yes)
            send(144);
        }
    }

}
