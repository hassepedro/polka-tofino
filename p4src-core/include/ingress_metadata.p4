/******  G L O B A L   I N G R E S S   M E T A D A T A  *********/

struct polka_t_top {
    macAddr_t dstAddr;
    macAddr_t srcAddr;
    bit<16>   etherType;
    routeid_t routeId;
}

struct ingress_metadata_t {
    routeid_t routeId;
    bit<16> etherType;
    bit<1> apply_sr;
    bit<1> apply_decap;
    egressSpec_t port;
}