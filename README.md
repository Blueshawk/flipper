# flipper
Linux "Tablet Mode" for Acer Aspire R14 R3-471t-54t1

This script prepares your linux laptop for flipping into "tablet mode".  While its designed specifically for my use on the Acer R3-471t-54t1 it should work with any distro using X.

**What this does;**  
* Checks Keyboard and Touchpad state  
* If enabled, disables both and launches the configured onscreen keyboard (onboard by default)
* If disabled, kills the configured onscreen keyboard and re-enables the touchpad and keyboard  
* Provides a configuration option to notify the user via notify-send of state change as well as error notifications  
* Provides arguments for verbose output when executed manually via bash [-v] and a dry-run option for state/device information [-n]  

**Suggested Use;**  
Create a shortcut and place on your desktop/launcher etc and click once when you want to switch between modes  


**Configuration;**  
The first section of the script is all you have to concern yourself with, contained with the config and end markers.  

***Getting Device Names***  
just execute 'xinput --list' and grab the human readable name from the output, thats it!  These will vary by device and currently is not automatically detmerined.  

*keyboard_name*  
set this to the name reported for your keyboard, contained in single quotes  

*touchpad_name*  
set this to the name reported for your touchpad, contained in single quotes  

*osd_bin*  
This is the absolute path to the on screen keyboard you wish to be started when tablet mode is enabled, onboard and florence are popular ones.  The default is /usr/bin/onboard.  

*notify*  
Turned on by default.  Sends messages via notify-send when switching modes or if an error condition is found preventing tablet mode from enabling.  

*debug*  
Allows flipper to output on normal execution verbose information.  Off by default and in most cases using -v makes more sense than changing the default behavior of the script unless extending the script.  

*touchscreen_name*  
Not implemented yet.  This feature will offer a default orientation on start as well as an argument to change the argument so you can setup a keyboard-shortcut to rotate the orientation while in tablet mode.   

This was written tested on Ubuntu 14.10
