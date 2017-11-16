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
echo "...Configuring network on Eth0/..."
#sed -i '***s/.*/***/' /home/pi/Pi-Install/dhcpcd.conf
sed -i "45s/.*/static ip_address=10.100.3.12/" /home/pi/Pi-Install/dhcpcd.conf
sed -i "46s/.*/#static routers=/" /home/pi/Pi-Install/dhcpcd.conf
sed -i "47s/.*/static domain_name_servers=8.8.8.8/" /home/pi/Pi-Install/dhcpcd.conf
mv /home/pi/Pi-Install/dhcpcd.conf /etc/dhcpcd.conf
echo "Network configuration Done"
#vino Screen Sharing setup
echo "Installing Vino"
mkdir /home/pi/.config/autostart
apt-get install -y vino dconf-tools
##Don't forget to run dconf-editor afterwards
mv /home/pi/Pi-Install/vino.desktop /home/pi/.config/autostart/vino.desktop
#install htop
apt-get install -y htop
###########################################################
# This will install the Motion server for webcam services #
# If you do not want it, feel free to comment it out      #
###########################################################
sudo apt-get install -y motion
# Configuring Motion server settings for outside access:
#sed -i '***s/.*/****/' /etc/motion/motion.conf
# This turns on the daemon
sed -i "11s/.*/daemon on/" /etc/motion/motion.conf
# Setting the logfile loction to "/etc/motion/motion.log
sed -i '25s/.*/logfile /tmp/motion.log/' /etc/motion/motion.conf
# Allow Localhost to access the Stream
sed -i '476s/.*/stream_localhost off/' /etc/motion/motion.conf
sed -i '463s/.*/stream_port 8081/' /etc/motion/motion.conf
# sed -i '***s/.*/****/' /etc/motion/motion.conf
# sed -i '***s/.*/****/' /etc/motion/motion.conf
# sed -i '***s/.*/****/' /etc/motion/motion.conf
# sed -i '***s/.*/****/' /etc/motion/motion.conf
#apt-get install -y
#etc.
