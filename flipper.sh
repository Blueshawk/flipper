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

function get_keyboard_state {
	kbstate=$(xinput list-props "$keyboard_name" | grep Enabled | awk '{print $4}')

}

function set_keyboard_state {
	echo "I: keyboard current state: $kbstate"
	if [ $kbstate != 0 ]; then 
		echo "I: assuming keyboard enabled.."
		disable_keyboard
		eval '$osd_bin'
	else
		echo "I: assuming keyboard disabled.."
		enable_keyboard
		eval "/usr/bin/pkill -f $osd_bin"
	fi

}

function get_touchpad_state {
	tpstate=$(xinput list-props "$touchpad_name" | grep Enabled | awk '{print $4}')
}

function set_touchpad_state {
	echo "I: touchpad current state: $tpstate"
	if [ $tpstate != 0 ]; then 
		echo "I: assuming touchpad enabled.."
		disable_touchpad
	else
		echo "I: assuming touchpad disabled.."
		enable_touchpad
	fi
}

function disable_touchpad {
	xinput disable "$touchpad_name"
	echo "I: Touchpad Disabled"
}

function enable_touchpad {
	xinput enable "$touchpad_name"
	echo "I: Touchpad Enabled"
}

function rotate_screen {
	#planned for 90,180,270, and 360 rotation via args
	echo "I: tbd"
}

function notify_user {
# This will only work if notify=on and libnotify and notify-send are installed
# Logic currently permits this from prompting on start and only prompts on end
# Currently reporting is incorrect, unclear or proper order yet

	if [ $notify = "on" ]; then
		if ([ $tpstate = 0 ] && [ $kbstate = 0 ]); then
			notify-send -i computer "Disabling Tablet mode"
		else
			notify-send -i input-tablet "Enabling Tablet mode"
		fi
	fi
}

function get_input_states {
	get_touchpad_state
	get_keyboard_state

}

function toggle_tablet_mode {
	set_touchpad_state
	set_keyboard_state
}

##main
#set_touchpad_state
#set_keyboard_state
get_input_states
notify_user
toggle_tablet_mode
