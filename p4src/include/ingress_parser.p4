/***********************  P A R S E R  **************************/
parser IngressParser(packet_in        packet,
    /* User */
    out ingress_headers_t          hdr,
    out ingress_metadata_t         meta,
    /* Intrinsic */
    out ingress_intrinsic_metadata_t  ig_intr_md)
{

    state start {
        /* Mandatory code required by Tofino Architecture */
        packet.extract(ig_intr_md);
        packet.advance(PORT_METADATA_SIZE);
        transition init_meta;
    }

    state init_meta {
        meta.routeId = 0;
        meta.etherType = 0;
        meta.apply_sr = 0;
        meta.apply_decap = 0;
        meta.port = 0;
        transition verify_ethernet;
    }

   state verify_ethernet {
        packet.extract(hdr.ethernet);
        transition select(hdr.ethernet.etherType) {
#ifdef POLKA_EDGE
            TYPE_IPV4: parse_ipv4;
#endif  // POLKA_EDGE
            TYPE_SRCROUTING: parse_srcRouting;
            default: accept;
        }
    }

    state parse_srcRouting {
        packet.extract(hdr.srcRoute);
#ifndef POLKA_EDGE
        // get routeId
        meta.apply_sr = 1;
        meta.routeId = hdr.srcRoute.routeId;
#endif  // POLKA_EDGE
        transition accept;
    }

#ifdef POLKA_EDGE
    state parse_ipv4 {
        packet.extract(hdr.ipv4);
        transition accept;
    }
#endif  // POLKA_EDGE

}