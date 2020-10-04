# ProxyCommand demo


## Getting Started
Prerequisites

Install [_Vagrant_](https://www.vagrantup.com/downloads) for your OS.
Install [_Virtualbox_](https://www.virtualbox.org/wiki/Downloads) for your OS.
Install [_Oracle VM VirtualBox Extension Pack_](https://download.virtualbox.org/virtualbox/6.1.14/Oracle_VM_VirtualBox_Extension_Pack-6.1.14.vbox-extpack)

## About

  This implementation uses (and tested on) the [_minimal/trusty64_](https://app.vagrantup.com/minimal/boxes/trusty64) Ubuntu(14.04.3) LTS base-box.

  Please note that security was not a main concern as this is meant to be a lab environment.

## Usage

 `vagrant up`  To bring up the vagrant vm-s in order to act as a lab environment (servers and bastions), then proceeds to provision them. After it will set up a controller machine and run ansible in local mode to demonstrate the ssh jumps using the bastions.

 `vagrant destroy --force` To stop running vm-s, and decommission the environment.

## Note

  To force delete Any leftover VM-s, use [`stop-vagrant.sh`](scripts/stop-vagrant.sh)
