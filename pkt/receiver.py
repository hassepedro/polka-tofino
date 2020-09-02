#!/usr/bin/env python
import sys

from scapy.all import (
    sniff,
    bind_layers,
)
from scapy.all import Packet
from scapy.all import Ether
from scapy.fields import *


def handle_pkt(pkt):
    pkt.show2()
    sys.stdout.flush()


class SourceRoute(Packet):
    fields_desc = [BitField("nrouteid", 0, 160)]


bind_layers(Ether, SourceRoute, type=0x1234)


def main():
    if len(sys.argv) < 2:
        print("Pass 2 arguments: <interface>")
        exit(1)

    iface = sys.argv[1]
    print(f"Sniffing on {iface}")
    sys.stdout.flush()
    sniff(iface=iface, prn=lambda x: handle_pkt(x))


if __name__ == "__main__":
    main()
