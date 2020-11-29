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

#ifndef POLKA_EDGE
    CRCPolynomial<bit<16>>(0x002d, false, false, false, 16w0x0000, 16w0x0000) crc16d;
    Hash<bit<16>>(HashAlgorithm_t.CUSTOM, crc16d) hash3;
#endif      // POLKA_EDGE

    action drop() {
        ig_dprsr_md.drop_ctl = 1;
    }

    action send(PortId_t port) {
        // the ports begins as 128 stepping 8
        ig_tm_md.ucast_egress_port = (PortId_t) PORT_TRANSLATE(port);
#ifdef BYPASS_EGRESS
        ig_tm_md.bypass_egress = 1;
#endif      // BYPASS_EGRESS
    }

#ifndef POLKA_EDGE
    action srcRoute_nhop() {

        bit<16> nbase=0;
        bit<64> ncount=4294967296*2;
        bit<16> nresult;
        bit<16> nport;

        routeid_t routeid = meta.routeId;
        //routeid = 57851202663303480771156315372;

        routeid_t ndata = routeid >> 16;
        bit<16> dif = (bit<16>) (routeid ^ (ndata << 16));

        nresult = (bit<16>) hash3.get((bit<16>) ndata);
        nport = nresult ^ dif;

        meta.port = (bit<9>) nport;
    }
#endif      // POLKA_EDGE

    apply {
#ifdef POLKA_EDGE
        if (hdr.ipv4.isValid() && hdr.vlan.etherType != TYPE_SRCROUTING) {
            process_tunnel_encap.apply(hdr, meta, ig_intr_md, ig_prsr_md, ig_dprsr_md, ig_tm_md);
        } else if (hdr.vlan.etherType == TYPE_SRCROUTING) {
            hdr.vlan.etherType = TYPE_IPV4;
            hdr.srcRoute.setInvalid();
            // this value is really hard-coded? (Yes)
            send(1);
        }
#else
        if (meta.apply_sr == 1) {
            srcRoute_nhop();
            send(meta.port);
        } else {
            drop();
        }
#endif      // POLKA_EDGE
    }

}
