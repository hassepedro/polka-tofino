#!/usr/bin/env python
import argparse
import sys
import socket
import random
import struct

from scapy.all import sendp, send, get_if_list, get_if_hwaddr, bind_layers
from scapy.all import Packet
from scapy.all import Ether, IP, UDP
from scapy.fields import *
import readline

#s1->s2->s3
#CROUTEID = 57851202663303480771156315372
#s1->s2
#CROUTEID = 16602069756962392158

veth_iface="veth1"

def get_if():
    ifs=get_if_list()
    iface=None # "h1-eth0"
    for i in get_if_list():
        if veth_iface in i:
            iface=i
            break
    if not iface:
        print("Cannot find %s interface" % (veth_iface))
        exit(1)
    return iface

class SourceRoute(Packet):
   # fields_desc = [ BitField("bos", 0, 1),
   #                 BitField("port", 0, 15)]
   fields_desc = [BitField("nrouteid", 0, 160)]

bind_layers(Ether, SourceRoute, type=0x1234)
#bind_layers(SourceRoute, IP, nrouteid=CROUTEID)
# bind_layers(SourceRoute, SourceRoute, bos=0)
#bind_layers(SourceRoute, IP, bos=1)

def main():

    if len(sys.argv)<2:
        print("Pass 2 arguments: <destination>")
        exit(1)

    addr = socket.gethostbyname(sys.argv[1])
    iface = veth_iface
    print("Sending on interface %s to %s" % (iface, str(addr)))

    while(True):
        print
        # s = str(raw_input('Type space separated port nums '
        #                   '(example: "2 3 2 2 1") or "q" to quit: '))
        s = str(raw_input('Type "1" for h0->s1->h1, "2" for h0->s1->s2->h2, ..., "10" for h0->s1->s2->s3->s4->s5->s6->s7->s8->s9->s10->h10, or "q" to quit: '))
        if s == "q":
            break;
        print

        if s == "1":
            option = 1
        elif s == "2":
            option = 2
        elif s == "3":
            option = 3
        elif s == "4":
            option = 4
        elif s == "5":
            option = 5
        elif s == "6":
            option = 6
        elif s == "7":
            option = 2194656173762523641939709652656780
        elif s == "8":
            option = 32763471027773366297233451711039667216
        elif s == "9":
            option = 16050698998725239657676330566116710828499122
        elif s == "10":
            option = 160687435443535944735989196096996536051477558113
        else:
            continue

        pkt =  Ether(src=get_if_hwaddr(iface), dst='ff:ff:ff:ff:ff:ff');
        try:
            # pkt = pkt / SourceRoute(nrouteid=int(p))
            pkt = pkt / SourceRoute(nrouteid=option)
        except ValueError:
            pass

        pkt = pkt / IP(dst=addr) / UDP(dport=4321, sport=1234)
        pkt.show2()
        sendp(pkt, iface=iface, verbose=False)



if __name__ == '__main__':
    main()
