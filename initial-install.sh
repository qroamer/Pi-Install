#!/bin/sh
echo "Enabling SSH"
systemctl enable ssh
echo "Updating SED"
apt-get update sed

sed -i '28s/.*/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i '32s/.*/PubkeyAuthentication no/' /etc/ssh/sshd_config
sed -i '52s/.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

echo "re-starting SSH"
sudo service ssh restart
echo "SSH has been restarted with command 'service ssh restart'"

#Change Keymap to US
sed -i '6s/.*/XKBLAYOUT="us"/' /etc/default/keyboard

#network Configuration
echo "Network Configuration Settings: "
echo "What do you want the IP to be?[88.88.88.88] "
read mainip
echo "What is the Default Gateway? "
read gateway

netmask='\/24'

echo "Please choose one: "
PS3='Please enter your choice: '
select opt in eth0 wlan0 Both Quit
do
    case $opt in
        eth0)
            echo "...Configuring network on Ethernet Connection 0/..."
			#sed -i '***s/.*/***/' /home/pi/setup/dhcpcd.conf
			sed -i "45s/.*/static ip_address=$mainip$netmask/" /home/pi/setup/dhcpcd.conf
			sed -i "46s/.*/static routers=$gateway/" /home/pi/setup/dhcpcd.conf
			sed -i "47s/.*/static domain_name_servers=8.8.8.8/" /home/pi/setup/dhcpcd.conf
			mv /home/pi/setup/dhcpcd.conf /etc/dhcpcd.conf
			echo "Done"
			break
			;;
        wlan0)
            echo "...Configuring network on Wireless Lan 0"
			sed -i "51s/.*/static ip_address=$mainip$netmask/" /home/pi/setup/dhcpcd.conf
			sed -i "52s/.*/static routers=$gateway/" /home/pi/setup/dhcpcd.conf
			sed -i "53s/.*/static domain_name_servers=8.8.8.8/" /home/pi/setup/dhcpcd.conf
			mv /home/pi/setup/dhcpcd.conf /etc/dhcpcd.conf
			echo "Done"
			break
            ;;
		Both)
			echo "You decided to do Both"
			sed -i "45s/.*/static ip_address=$mainip$netmask/" /home/pi/setup/dhcpcd.conf
			sed -i "46s/.*/static routers=$gateway/" /home/pi/setup/dhcpcd.conf
			sed -i "47s/.*/static domain_name_servers=8.8.8.8/" /home/pi/setup/dhcpcd.conf
			sed -i "51s/.*/static ip_address=$mainip$netmask/" /home/pi/setup/dhcpcd.conf
			sed -i "52s/.*/static routers=$gateway/" /home/pi/setup/dhcpcd.conf
			sed -i "53s/.*/static domain_name_servers=8.8.8.8/" /home/pi/setup/dhcpcd.conf
			mv /home/pi/setup/dhcpcd.conf /etc/dhcpcd.conf
			echo "Done"
			break
			;;
        Quit)
			echo "Exiting"
			break
            ;;
        *) echo invalid option;;
    esac
done
echo "Network configuration Done"

#vino Screen Sharing setup
echo "Installing Vino"
mkdir /home/pi/.config/autostart
apt-get install -y vino dconf-tools
<<<<<<< HEAD
##Don't forget to run dconf-editor afterwards
=======
>>>>>>> e97d2735a0e093830ef3a1f4d1adb972631fd290
mv /home/pi/setup/vino.desktop /home/pi/.config/autostart/vino.desktop

apt-get install -y htop
###########################################################
# This will install the Motion server for webcam services #
# If you do not want it, feel free to comment it out      #
###########################################################
sudo apt-get install -y motion

# Configuring Motion server settings for outside access:
#sed -i '***s/.*/****/' /etc/motion/motion.conf
# This turns on th daemon
sed -i "11s/.*/daemon on/" /etc/motion/motion.conf

# Setting the logfile loction to "/etc/motion/motion.log
sed -i '25s/.*/logfile /tmp/motion.log/' /etc/motion/motion.conf

# Allow Localhost to access the Stream
sed -i '476s/.*/stream_localhost off/' /etc/motion/motion.conf


sed -i '463s/.*/stream_port 8081/' /etc/motion/motion.conf
sed -i '***s/.*/****/' /etc/motion/motion.conf
sed -i '***s/.*/****/' /etc/motion/motion.conf
sed -i '***s/.*/****/' /etc/motion/motion.conf
sed -i '***s/.*/****/' /etc/motion/motion.conf


#apt-get install -y 

#etc.
