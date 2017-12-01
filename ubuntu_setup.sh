#!/bin/bash

# A shell script to set up a minimalist Ubuntu VM based on 14.04 LTS Trusty Tahr mini.iso

sudo apt-get install git 
# git config
# git config --global user.name ""
# git config --global user.email ""
# ssh-keygen -t rsa -C ""
# ssh-add ~/.ssh/id_rsa

# check Ubuntu and Kernel version
lsb_release -a
lsb_release -r
uname -a
uname -r

## Linux Admin: upgrade, clean up, and monitoring
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get autoremove

# remove old kernels after kernel upgrade
dpkg -l 'linux-*' | sed  '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]*  [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge

sudo apt-get clean
sudo apt-get autoclean # remove all but the latest version
sudo apt-cache ubuntu-desktop
df -h | grep '[0-9\.]\+G' # overall 
du -h | grep '[0-9\.]\+G' # each folder

# persist a disk
sudo fdisk -l # to make sure the disc is attached
sudo fdisk /dev/sdc # press n for new, p for primary, 1 for partition nubmer, enter for start, enter for end, w for write
sudo fdisk -l # to make sure it worked
sudo mkfs.ext4 /dev/sdc1 # format it
sudo blkid /dev/sdc1
sudo nano /etc/fstab # Add following
UUID=waisdf9asd09a89f    /home/user/Data   ext4    defaults,nofail     1        2
mkdir ~/Data
sudo mount -a # mount all disks
sudo chmod 777 ~/Data
