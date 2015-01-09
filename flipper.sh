#!/bin/bash
# script for using acer r3-471t in "tablet mode"
# disables keyboard and touchpad with a reversable mode
# update the config section to match the device names gathered by xinput
# script does not currently support rotation but is planned


##  config   ##
###############
keyboard_name='AT Translated Set 2 keyboard'
touchpad_name='SYN1B7B:01 06CB:2969 UNKNOWN'
osd_bin='/usr/bin/onboard'
notify='on' #set to anything else to disable
debug='off' #set to on for verbose output or run with -v
#touchscreen_name='ELAN Touchscreen'

############### 
##    end    ##


##### function area #####
function disable_keyboard {
	xinput disable "$keyboard_name"
	if [ $debug = "on" ]; then
		echo "I: Keyboard Disabled"
	fi
}

function enable_keyboard {
	xinput enable "$keyboard_name"
	if [ $debug = "on" ]; then
		echo "I: Keyboard Enabled"
	fi
}

function get_keyboard_state {
	kbstate=$(xinput list-props "$keyboard_name" | grep Enabled | awk '{print $4}')

}

function print_keyboard_state {
if [ $debug = "on" ]; then
	echo "I: Keyboard: '$keyboard_name' Current State: $kbstate"
	if [ $kbstate != 0 ]; then
		echo "I: assuming keyboard enabled.."
	else	
		echo "I: assuming keyboard disabled.."
	fi
fi
}

function set_keyboard_state {
	print_keyboard_state
	if [ $kbstate != 0 ]; then 
		disable_keyboard
		eval '$osd_bin'
	else
		enable_keyboard
		eval "/usr/bin/pkill -f $osd_bin"
	fi

}

function get_touchpad_state {
	tpstate=$(xinput list-props "$touchpad_name" | grep Enabled | awk '{print $4}')
}

function print_touchpad_state {
if [ $debug = "on" ]; then
	echo "I: Touchpad: '$touchpad_name' Current State: $tpstate"
	if [ $tpstate != 0 ]; then
		echo "I: assuming touchpad enabled.."
	else	
		echo "I: assuming touchpad disabled.."
	fi
fi
}

function set_touchpad_state {
	print_touchpad_state
	if [ $tpstate != 0 ]; then 
		disable_touchpad
	else
		enable_touchpad
	fi
}

function disable_touchpad {
	xinput disable "$touchpad_name"
	if [ $debug = "on" ]; then
		echo "I: Touchpad Disabled"
	fi
}

function enable_touchpad {
	xinput enable "$touchpad_name"
	if [ $debug = "on" ]; then
		echo "I: Touchpad Enabled"
	fi
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

function error_detection {
	if [ $kbstate != $tpstate ]; then
		echo "E: Incostitent States detected"
		echo "E: Touchpad: '$touchpad_name' Current State = $tpstate"
		echo "E: Keyboard: '$keyboard_name' Current State = $kbstate"
		echo "E: Manually correct states in order for flipper to work"
			if [ $notify = "on" ]; then
				notify-send -i dialog-error "Not enabling tablet mode due to state errors, use -n to view"
			fi
		exit
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

function flipper_go {
	get_input_states
	error_detection
	notify_user
	toggle_tablet_mode

}

function flipper_go_dry {
	get_input_states
	print_touchpad_state
	print_keyboard_state

}
#########################
##         end         ## 


##### argument area #####
while getopts "vn" opt; do
	case $opt in
	v)
		echo "I: verbose debugging enabled"
		debug="on"
		flipper_go
		exit
		;;
	n)
		echo "I: Dry-run, reporting state information only!"
		debug="on"
		flipper_go_dry 
		echo "I: TURN THIS THING OFF IM DRYYYYYYY"
		exit
		;;
	\?) 
		echo "Invalid argument, quitting"
		exit
		;;
	esac
done 
#########################
##         end         ## 

# exec w/o args
flipper_go
