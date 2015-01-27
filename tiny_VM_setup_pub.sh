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
sudo apt-get install lightdm-gtk-greeter git curl 

sudo mkdir /media/cdrom
sudo mount /dev/cdrom /media/cdrom
sudo /media/cdrom/VBoxLinuxAdditions.run
mkdir share
#nano .bashrc
echo 'sudo mount -t vboxsf share ~/share' >> .bashrc

sudo apt-get install python-software-properties software-properties-common
sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo apt-get update
sudo apt-get install sublime-text-installer

# Get the latest R version
sudo apt-key adv –keyserver keyserver.ubuntu.com –recv-keys E084DAB9
sudo add-apt-repository ‘deb http://star-www.st-andrews.ac.uk/cran/bin/linux/ubuntu trusty/’
sudo apt-get update
sudo apt-get install r-base

# Download and install RStudio
wget http://download1.rstudio.org/rstudio-0.98.1091-amd64.deb
sudo dpkg -i *.deb
rm *.deb

git config --global user.name ""
git config --global user.email ""
ssh-keygen -t rsa -C ""
ssh-add ~/.ssh/id_rsa

sudo apt-get install libpq-dev bundler firefox libxml2-dev openjdk-7-jdk
bundle install
bundle update

#autologin
#sudo nano /etc/lightdm/lightdm.conf
  #[SeatDefaults]
  #autologin-user=<YOUR USER>
  #autologin-user-timeout=0
sudo sed -i '$ a\ [SeatDefaults] 
  utologin-user=<YOUR USER> 
  autologin-user-timeout=0' /etc/lightdm/lightdm.conf

