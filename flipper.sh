#!/bin/bash
# script for using acer r3-471t in "tablet mode"
# disables keyboard and touchpad with a reversable mode
# update the config section to match the device names gathered by xinput
# script does not currently support rotation but is planned


##  config   ##
###############
keyboard_name='Virtual core XTEST keyboard'  
touchpad_name='SynPS/2 Synaptics TouchPad'
#touchscreen_name='ELAN Touchscreen'
############### 
##    end    ##


##### function area #####
function disable_keyboard {
	echo "tbd"
}

function get_touchpad_state {
	tpstate=$(xinput list-props "$touchpad_name" | grep Enabled | awk '{print $4}')
	echo "current state: $tpstate"
	if [ $tpstate != 0 ]; then 
		echo "assuming enabled.."
		disable_touchpad
	else
		echo "assuming disabled.."
		enable_touchpad
	fi
}

function disable_touchpad {
# post testing this will go in get_touchpad_state
	xinput disable "$touchpad_name"
	echo "I: Touchpad Disabled"
}

function enable_touchpad {
# post testing this will go in get_touchpad_state
	xinput enable "$touchpad_name"
	echo "I: Touchpad Enabled"
}

function rotate_screen {
	#planned for 90,180,270, and 360 rotation via args
	echo "tbd"
}



#main
get_touchpad_state
