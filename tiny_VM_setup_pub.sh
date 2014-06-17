#!/bin/bash

# A shell script to set up a minimalist Ubuntu VM based on 14.04 LTS Trusty Tahr for Rails development 
# using LightDM (with GTK+ Greeter), DWM, Sublime Text 3, Firefox, RVM

sudo apt-get install --no-install-recommends xorg lightdm dwm dmenu make gcc 
# xorg is needed for guestadditions to work well, xinit was not enough
# sublime text needs gtk2 which gdm or lightdm-gtk-greeter provides. 
# gdm is pretty, but slow, clunky, and doesn't work with dwm alone, need jwm or others, and wouldn't take dwm as default
# dwm is compiled from 2000 lines of C code. Any customization requires mod of source code and recompilation. 
# dwm is very fast, secure, effecient, and clean keyboard driven window manager
# dmenu is a searchable menu system that works with dwm
# make and gcc is needed for vbox guest additions
sudo apt-get install lightdm-gtk-greeter git curl nodejs 

sudo mkdir /media/cdrom
sudo mount /dev/cdrom /media/cdrom
sudo /media/cdrom/VBoxLinuxAdditions.run
mkdir share
#nano .bashrc
  #source ~/.rvm/scripts/rvm
  #sudo mount -t vboxsf share ~/share

\curl -sSL https://get.rvm.io | bash
rvm install 2.0.0-p195
rvm install 2.1.1
rvm --default use 2.0.0-p195

sudo apt-get install python-software-properties software-properties-common
sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo apt-get update
sudo apt-get install sublime-text-installer

git config --global user.name ""
git config --global user.email ""
ssh-keygen -t rsa -C ""
ssh-add ~/.ssh/id_rsa

sudo apt-get install libpq-dev bundler firefox 
bundle install
bundle update

#autologin
#sudo nano /etc/lightdm/lightdm.conf
  #[SeatDefaults]
  #autologin-user=<YOUR USER>
  #autologin-user-timeout=0
