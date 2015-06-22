#!/bin/bash

# A shell script to set up a minimalist Ubuntu VM based on 14.04 LTS Trusty Tahr mini.iso
# for data science using R, python (Annaconda), PostgreSQL.
# I chose LightDM (with GTK+ Greeter), dwm, dmenu as my desktop environment.

*** lightdm with gtk greeter
sudo apt-get install --no-install-recommends xorg lightdm dwm dmenu make gcc
# xorg is needed for guestadditions to work well, xinit was not enough
# sublime text needs gtk2 which gdm or lightdm-gtk-greeter provides.
# gdm is pretty, but slow, clunky, and doesn't work with dwm alone, need jwm or others, and wouldn't take dwm as default
# dwm is compiled from 2000 lines of C code. Any customization requires mod of source code and recompilation.
# dwm is very fast, secure, effecient, and clean keyboard driven window manager
# dmenu is a searchable menu system that works with dwm
sudo apt-get install lightdm-gtk-greeter git curl

# autologin to lightdm
#sudo nano /etc/lightdm/lightdm.conf
  #[SeatDefaults]
  #autologin-user=<YOUR USER>
  #autologin-user-timeout=0
sudo sed -i '$ a\ [SeatDefaults]
  utologin-user=<YOUR USER>
  autologin-user-timeout=0' /etc/lightdm/lightdm.conf

# git config
# git config --global user.name ""
# git config --global user.email ""
# ssh-keygen -t rsa -C ""
# ssh-add ~/.ssh/id_rsa

# vbox guestaddition
sudo apt-get install -y dkms build-essential linus-headers-generic linus-headers-$(uname -r) --no-install-recommends
sudo mkdir /media/cdrom
sudo mount /dev/cdrom /media/cdrom
sudo /media/cdrom/VBoxLinuxAdditions.run
mkdir share
echo 'sudo mount -t vboxsf share ~/share' >> .bashrc

# other stuff
sudo apt-get install python-software-properties software-properties-common
sudo apt-get install libcurl4-gnutls-dev htop gnome-system-monitor
sudo apt-get install libpq-dev bundler firefox libxml2-dev openjdk-7-jdk libgtk-3-dev libgtk2.0-dev
bundle install
bundle update

# check Ubuntu and Kernel version
lsb_release -a
lsb_release -r
uname -a
uname -r

# Get the latest R version
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
sudo add-apt-repository ‘deb http://cran.rstudio.com/bin/linux/ubuntu trusty/’
sudo apt-get update
sudo apt-get install r-base

# Download and install RStudio
wget http://download1.rstudio.org/rstudio-0.99.332-amd64.deb
sudo dpkg -i *.deb
rm *.deb
# R packages are installed in Rstudio
# reconfig java home after installing openjdk to install rjava
sudo R CMD javareconf
# in R run 
# install.packages('rJava')

# update R and mv libraries
mv ~/R/x86_64-pc-linux-gnu-library/3.1/* ~/R/x86_64-pc-linux-gnu-library/3.2
# in R run 
update.packages(checkBuilt=TRUE, ask=FALSE)
# remove.packages("BiocInstaller")
# source("http://bioconductor.org/biocLite.R")
# biocLite()
# then remove old R library folder
rm -rf ~/R/x86_64-pc-linux-gnu-library/3.1

# 
mkdir ~/Applications

# install miniconda for scientific python2.79
wget http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh -O ~/Applications/miniconda.sh
bash ~/Applications/miniconda.sh -b -p $HOME/Applications/miniconda
# put this in ~/.profile
export PATH="$HOME/Applications/miniconda/bin:$PATH"

# wget http://repo.continuum.io/miniconda/Miniconda-3.8.3-Linux-x86_64.sh
# bash Miniconda-3.8.3-Linux-x86_64.sh
conda update conda

conda create -n boa python=2
source activate boa
conda install numpy pandas spyder scikit-learn matplotlib statsmodels ipython-notebook
conda install pip num2words sas7bdat 
pip install rpy2
source deactivate
# Spyder config needed for DWM to display graph:
# Tools:Preferences:IPython Console:Graphics:

# install bluej via deb/dpkg: bluej/bluej
# drjava only need to be unpacked to run: dr
# intellij idea only need to be unpacked to run: bash idea.sh

# Java IDE display issue with dwm
# Use OpenJDK With Vendor Fix[edit]
_JAVA_AWT_WM_NONREPARENTING=1; export _JAVA_AWT_WM_NONREPARENTING
# Impersonate Another Window Manager[edit]
# You may use the wmname utility to make the JVM believe you are running a different window manager. 
# This utility is available in the suckless-tools package in Debian (and Ubuntu)
wmname LG3D
# (You must restart the application in question after issuing the wmname command.)


# install sbt
echo "deb http://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-get update
sudo apt-get install sbt

# spark
# spark with hadoop binary comes with scala and sbt
# only needs extraction to run

# sublime text 3
sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo apt-get update
sudo apt-get install sublime-text-installer

wget http://c758482.r82.cf2.rackcdn.com/sublime_text_3_build_3059_x64.tar.bz2
tar vxjf sublime_text_3_build_3059_x64.tar.bz2
sudo mv sublime_text_3 /opt/
sudo ln -s /opt/sublime_text_3/sublime_text /usr/bin/sublime

# rvm
# \curl -sSL https://get.rvm.io | bash
# rvm install 2.0.0-p195
# rvm --default use 2.0.0-p195
# echo 'source ~/.rvm/scripts/rvm' >> .bashrc

# Clean up and monitoring
sudo apt-get clean
sudo apt-get autoclean # remove all but the latest version
sudo apt-cache ubuntu-desktop
df -h | grep '[0-9\.]\+G' # overall 
du -h | grep '[0-9\.]\+G' # each folder
