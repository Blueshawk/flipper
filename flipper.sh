#!/bin/bash
# script for using acer r3-471t in "tablet mode"
# disables keyboard and touchpad with a reversable mode
# update the config section to match the device names gathered by xinput
# script does not currently support rotation but is planned


##  config   ##
###############
keyboard_name='AT Translated Set 2 keyboard'
touchpad_name='SynPS/2 Synaptics TouchPad'
osd_bin='/usr/bin/onboard'
notify='off'
#touchscreen_name='ELAN Touchscreen'

############### 
##    end    ##


##### function area #####
function disable_keyboard {
	xinput disable "$keyboard_name"
	echo "I: Keyboard Disabled"
}

function enable_keyboard {
	xinput enable "$keyboard_name"
	echo "I: Keyboard Enabled"
}


function set_keyboard_state {
	kbstate=$(xinput list-props "$keyboard_name" | grep Enabled | awk '{print $4}')
	echo "current state: $kbstate"
	if [ $kbstate != 0 ]; then 
		echo "assuming enabled.."
		disable_keyboard
		eval '$osd_bin'
	else
		echo "assuming disabled.."
		enable_keyboard
		eval "/usr/bin/pkill -f $osd_bin"
	fi

}

function set_touchpad_state {
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
	xinput disable "$touchpad_name"
	echo "Touchpad Disabled"
}

function enable_touchpad {
	xinput enable "$touchpad_name"
	echo "Touchpad Enabled"
}

function rotate_screen {
	#planned for 90,180,270, and 360 rotation via args
	echo "tbd"
}

function notify_user {
	if [ $notify = "on" ]; then
		notify-send -i input-tablet "Tablet mode toggled"
	fi
}

##main
set_touchpad_state
set_keyboard_state
notify_user
