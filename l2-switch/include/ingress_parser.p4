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
        transition verify_ethernet;
    }

   state verify_ethernet {
        packet.extract(hdr.ethernet);
        transition accept;
    }
    
}