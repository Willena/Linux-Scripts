#!/bin/bash
echo "Called  $*" >> /home/rtorrent/file.log
if [ $# -gt 1 ]
then
	echo "One Entry"
	HASH=$(echo "$1" | tr '[:upper:]' '[:lower:]')
	OPT=$2
	echo "Checking torrent existance ..."
#        LINE_COUNT=$(deluge-console info -i "$HASH"| wc -l )
	LINE_COUNT=1
	
	if [ $LINE_COUNT -gt 0 ]
	then
	        echo "Working on torrent with id : $HASH ."

		case $OPT in
			"-p")
			#PAUSE
			echo "Pausing ... "
			deluge-console pause "$HASH"
			;;
			"-r")
			#RESUME
			echo "Resuming ... "
			deluge-console resume "$HASH"
			;;
			"-ck")
			#CHECK
			echo "Checking ..."
			deluge-console recheck "$HASH"
			;;
			"-a")
			#ADD FILE
			echo "Adding torrent"
			deluge-console add $3
			;;
			"-del")
			#REMOVE
			echo "Removing ..."
			deluge-console rm "$HASH"
			;;
			"-evt")
			#EVENT HANDLING
			if [ $# -eq 3 ]
			then
				echo "Running routine for $3"
				case $3 in
					"finished")
					deluge-console pause "$HASH"
					deluge-console recheck "$HASH"
					deluge-console resume "$HASH"
					;;
					*)
					echo "Routine not found"
					exit 1
					;;
				esac
			else
				echo "Event can't be Null"
			fi
			;;
			*)
			#Default Case
			echo "Unreconized ARG"
			exit 1
			;;
		esac
	else
	echo "This torrent is not valid"
	exit 1
	fi
else
echo "You need to pass an action like -p -del -r -ck to allow this script to work !"
fi
