function disk_shred
{
	current_location_GB=$((current_location / one_gigabyte))
	increment_GB=$((increment / one_gigabyte))
	
	while [ "$REPLY" == "s" ]
	do
		clear
		echo && echo
		echo Shredding a total of $increment_GB GB at location $current_location_GB GB.
		sleep 3
		sudo dd if=/dev/zero of=$disk_path status=progress bs=1G seek=$current_location_GB count=$increment_GB
		clear
		disk_info
		sudo xxd -s $current_location -l 640 $disk_path
		echo && read -p "$(ColorBlue "(ENTER | S = Full Shred | s = Sector Shred):") "
	done

	while [ "$REPLY" == "S" ]
	do
		clear
		echo && echo
		echo Shredding a total of $disk_size GB at location 0 GB.
		sleep 3
		sudo dd if=/dev/zero of=$disk_path status=progress bs=1G seek=0 count=$disk_size
		clear
		disk_info
		sudo xxd -l 640 $disk_path
		echo && read -p "$(ColorBlue "(ENTER | S = Full Shred | s = Sector Shred):") "
	done
}
