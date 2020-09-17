# How to deploy PolKA for Tofino in a emulated evironment using Barefoot P4 Studio.

This deployment option is intended mainly for testing and development. To start the environment you have to simply run:

```sh
$ vagrant --number-vms=<number_of_vms> up
```

The reload is issued just to make sure all VMs are correctly setup. This should only be necessary after running `vagrant up` for the first time (VM creation and provisioning).

Download and copy `bf-sde-*.tar` and `bf-tool-*.tar` files to ../build directory (NDA restrictions).

To provise again in order to apply a new modification on the PolKA code, you need to run the following command:

```sh
$ vagrant provision <vm_name>
```

To see the list of VMs and their IP addresses, you can perform the following command:

```sh
root@nerds:~/polka-tofino/pkt# virsh net-dhcp-leases mgmt
 Expiry Time          MAC address        Protocol  IP address                Hostname        Client ID or DUID
-------------------------------------------------------------------------------------------------------------------
 2020-09-17 14:42:13  52:54:00:6d:ae:76  ipv4      192.168.77.70/24          amsterdam       01:52:54:00:6d:ae:76
 2020-09-17 15:00:16  52:54:00:6f:0e:7d  ipv4      192.168.77.81/24          frankfurt       01:52:54:00:6f:0e:7d
 2020-09-17 14:50:33  52:54:00:8e:f7:c4  ipv4      192.168.77.248/24         poznan          01:52:54:00:8e:f7:c4
 2020-09-17 14:42:38  52:54:00:fb:39:a8  ipv4      192.168.77.67/24          budapest        01:52:54:00:fb:39:a8
```

To access each VM, you can use as username and password labnerds/labnerds.

After provisioning the VMs, the Vagrantfile will create the following architecture:

![Topology](../fig/topology.png)

`Paris` and `Slough` are the VMs used to either generate or receive the traffic based on the PolKA source-routing.
