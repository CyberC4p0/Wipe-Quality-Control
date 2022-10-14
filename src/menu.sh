function menu()
{
	clear && title

	increment=0
	options=1
	
	echo -ne "
OPTIONS:
exit = exit script
done = ready to zip up
1,2,3, etc. = Disk selection

* Please ignore ROM disks if listed (Example: /dev/sr0)
	"
	
	echo
	echo -ne "$(ColorGreen "DISK SELECTION MENU")"
	echo
	echo

	while [ "${available_disks[$increment]}" != "" ]
	do
		echo "$(ColorGreen "Disk $options:") ${available_disks[$increment]}"
		((++increment)) && ((++options))
	done
	
	echo && read -p "$(ColorBlue "Select:") "

	if [ "$REPLY" == "" ]
	then
		menu
	
	elif [ "$REPLY" == "exit" ]
	then
		sudo rm -r $computer_tracking_number 2>/dev/null
		exit
	
	elif [ "$REPLY" == "done" ]
	then
		flag="done"
		$next

	elif [ "$REPLY" -le "${#available_disks[@]}" ]
	then
		selection=$((REPLY - 1))
	else
		menu
	fi
}
