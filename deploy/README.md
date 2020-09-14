# How to deploy a linear topology PolKA for Tofino using P4 Studio environment

This deployment option is intended mainly for testing and development. To start the environment you have to simply run:

    vagrant --number-vms=<number_of_vms> up && vagrant reload

The reload is issued just to make sure all VMs are correctly setup. This should only be necessary after running `vagrant up` for the first time (VM creation).

Download and copy bf-sde-*.tar and bf-tool-*.tar files to ../build directory (Copyright restrictions).

After any PolKA script modification, run the following command:

    vagrant provision
