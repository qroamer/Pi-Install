#!/bin/sh
echo "Enabling SSH"
systemctl enable ssh
#Install SED
echo "Updating SED"
apt-get update sed
sudo cp sshd_conf /etc/ssh/sshd_conf
echo "re-starting SSH"
sudo service ssh restart
echo "SSH has been restarted with command 'service ssh restart'"
#Change Keymap to US
sed -i '6s/.*/XKBLAYOUT="us"/' /etc/default/keyboard
#network Configuration
mv /home/pi/Pi-Install/dhcpcd.conf /etc/dhcpcd.conf
#This just changes the eth0 to allow-hotplug
mv /home/pi/Pi-Install/interfaces /etc/network/interfaces
echo "Network configuration Done"
#vino Screen Sharing setup
echo "Installing Vino"
mkdir /home/pi/.config/autostart
apt-get install -y vino dconf-tools
##Don't forget to run dconf-editor afterwards
mv /home/pi/Pi-Install/vino.desktop /home/pi/.config/autostart/vino.desktop
#install htop
apt-get install -y htop
apt-get install ufw
#ufw allow in on eth0 to any port 80 proto tcp
sudo ufw default deny incoming
sudo ufw default deny outgoing
sudo ufw allow in on eth0 to any port 22
sudo ufw allow in on eth0 to any port 5901
sudo ufw allow in on wlan0 to any port 53,80,443,123