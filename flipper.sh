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
notify='on' #set to anything else to disable
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
# This will only work if notify=on and libnotify and notify-send are installed
# Logic currently permits this from prompting on start and only prompts on end
# Currently reporting is incorrect, unclear or proper order yet

	if [ $notify = "on" ]; then
		if [ [ $tpstate = 0 ] && [ $kbstate = 0 ] ]; then
			notify-send -i computer "Disabled Tablet mode"
		else
			notify-send -i input-tablet "Enabled Tablet mode"
		fi
	fi
}

function toggle_tablet_mode {
	set_touchpad_state
	set_keyboard_state
}

##main
#set_touchpad_state
#set_keyboard_state
toggle_tablet_mode
notify_user
