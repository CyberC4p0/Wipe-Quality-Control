#!/bin/bash

function disk_screenshot 
{
	mkdir -p ~/Desktop/$computer_tracking_number/disk_$disk_number

	increment=$((disk_size_bytes / 7))
	current_location="0"

	clear

	# 14 PERCENT
	disk_info
	sudo xxd -l 640 $disk_path
	echo && read -p "$(ColorBlue "(ENTER | S = Full Shred | s = Sector Shred):") "
	disk_shred
	xfce4-screenshooter -w --no-border -s ~/Desktop/$computer_tracking_number/disk_$disk_number/disk_$disk_number-wipeqc_1.jpg
	current_location=$((current_location + increment))
	clear

	# 28 PERCENT
	disk_info
	sudo xxd -s $current_location -l 640 $disk_path
	echo && read -p "$(ColorBlue "(ENTER | S = Full Shred | s = Sector Shred):") "
	disk_shred
	xfce4-screenshooter -w --no-border -s ~/Desktop/$computer_tracking_number/disk_$disk_number/disk_$disk_number-wipeqc_2.jpg
	current_location=$((current_location + increment))
	clear

	# 42 PERCENT
	disk_info
	sudo xxd -s $current_location -l 640 $disk_path
	echo && read -p "$(ColorBlue "(ENTER | S = Full Shred | s = Sector Shred):") "
	disk_shred
	xfce4-screenshooter -w --no-border -s ~/Desktop/$computer_tracking_number/disk_$disk_number/disk_$disk_number-wipeqc_3.jpg
	current_location=$((current_location + increment))
	clear

	# 56 PERCENT
	disk_info
	sudo xxd -s $current_location -l 640 $disk_path
	echo && read -p "$(ColorBlue "(ENTER | S = Full Shred | s = Sector Shred):") "
	disk_shred
	xfce4-screenshooter -w --no-border -s ~/Desktop/$computer_tracking_number/disk_$disk_number/disk_$disk_number-wipeqc_4.jpg
	current_location=$((current_location + increment))
	clear

	# 70 PERCENT
	disk_info
	sudo xxd -s $current_location -l 640 $disk_path
	echo && read -p "$(ColorBlue "(ENTER | S = Full Shred | s = Sector Shred):") "
	disk_shred
	xfce4-screenshooter -w --no-border -s ~/Desktop/$computer_tracking_number/disk_$disk_number/disk_$disk_number-wipeqc_5.jpg
	current_location=$((current_location + increment))
	clear	
	
	# 84 PERCENT
	disk_info
	sudo xxd -s $current_location -l 640 $disk_path
	echo && read -p "$(ColorBlue "(ENTER | S = Full Shred | s = Sector Shred):") "
	disk_shred
	xfce4-screenshooter -w --no-border -s ~/Desktop/$computer_tracking_number/disk_$disk_number/disk_$disk_number-wipeqc_6.jpg
	current_location=$((current_location + increment))
	clear

	# 100 PERCENT
	disk_info
	sudo xxd -s -0x280 $disk_path
	echo && read -p "$(ColorBlue "(ENTER | S = Full Shred | s = Sector Shred):") "
	disk_shred
	xfce4-screenshooter -w --no-border -s ~/Desktop/$computer_tracking_number/disk_$disk_number/disk_$disk_number-wipeqc_7.jpg	
	clear

	((++disk_number))
	menu
}
