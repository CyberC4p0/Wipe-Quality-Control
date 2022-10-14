#!/bin/bash

# Title
function title()
{
	clear
	echo -ne "\033[1;33m
 __      ___              ___            _ _ _           ___         _           _  
 \ \    / (_)_ __  ___   / _ \ _  _ __ _| (_) |_ _  _   / __|___ _ _| |_ _ _ ___| | 
  \ \/\/ /| | '_ \/ -_) | (_) | || / _' | | |  _| || | | (__/ _ \ ' \  _| '_/ _ \ | 
   \_/\_/ |_| .__/\___|  \__\_|__,_\__,_|_|_|\__|\_, |  \___\___/_||_\__|_| \___/_| 
			|_|									 |__/                                                
	\e[0m"
}

title

# General Variables
computer_serial_number=$(sudo dmidecode -t system | grep Serial | awk '{print $3}')
computer_tracking_number=""
undetected=""
next=:
script_root=$(dirname "${BASH_SOURCE[0]}")
one_gigabyte=1000000000
row=1
increment=0
selection=
flag="do"
available_disks=()

# Include External Scripts
source $script_root/screenshot.sh
source $script_root/wipe.sh
source $script_root/menu.sh

# Statement to obtain available disks & add them to an array
disk=$(lsblk -ndpo NAME,SIZE,TRAN,ROTA,SERIAL | grep 'nvme\|sata' | awk -v row="$row" 'NR >= row && NR <= row')

# While the disk variable is not empty, do...
while [ "$disk" != "" ]
do
	available_disks+=("$disk")
	((++row)) && ((++increment))
	disk=$(lsblk -ndpo NAME,SIZE,TRAN,ROTA,SERIAL | grep 'nvme\|sata' | awk -v row="$row" 'NR >= row && NR <= row')
done

# Color to make prompts prettier
function ColorGreen()
{
	green='\033[1;32m'
	clear='\e[0m'
	echo -ne $green$1$clear
}
function ColorBlue()
{
	blue='\033[1;34m'
	clear='\e[0m'
	echo -ne $blue$1$clear
}

# Computer Tracker Number
echo
read -p "$(ColorBlue "Computer Tracking Number:") " computer_tracking_number

if [ $computer_serial_number == 'NA' ]; then

	echo && echo
	echo Computer Serial Number: $computer_serial_number
	echo An INVALID SN has been detected!
	echo 
	exit

fi

# Launch menu right after obtaining tracker number
menu

# Disk variables
disk_number=1
disk_type=
disk=${available_disks[$selection]}
disk_path=$(echo $disk | awk '{print $1}')
disk_size=$(echo $disk | awk '{print $2}' | sed 's/G//' | awk '{print int($1+0.5)}')
disk_size_bytes=$(echo $((disk_size * one_gigabyte)))
disk_transport_bus=$(echo $disk | awk '{print $3}')
disk_rotational=$(echo $disk | awk '{print $4}')
disk_serial_number=$(echo $disk | awk '{print $5}')

# If the disk transport bus is sata, then...
if [ $disk_transport_bus == "sata" ]
then
	# If the disk rotation indicator is 1, then...
	if [ $disk_rotational == "1" ]
	then
		disk_type="HDD"
	else
		disk_type="SSD"
	fi
else
	disk_type="NVMe"
fi

function disk_info()
{
	echo && echo
	echo Computer Serial Number: $computer_serial_number
	echo Disk Type: $disk_type
	echo Disk Size: $disk_size GB
	echo Disk Transport Bus: $disk_transport_bus
	echo Disk Path: $disk_path
	echo Disk Serial Number: $disk_serial_number
	echo && echo
}

while [ $flag == "do" ]
do
	disk_screenshot
done

# Folder Zip
cd ~/Desktop
zip -q -r $computer_tracking_number.zip $computer_tracking_number
sudo rm -r $computer_tracking_number
echo
echo Folder Created!
echo Folder Zipped!
echo

# Power Off
read -n 1 -p "Would you like to power off the computer? (y/n): "

if [ "$REPLY" == "y" ]; then

	poweroff

else
	exit

fi
