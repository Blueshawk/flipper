# flipper
Linux "Tablet Mode" for Acer R3-471t-54t1

This script prepares your linux laptop for "tablet mode".  While its designed specifically for my use on the Acer R3-471t-54t1 it should work with any distro using X.

What this does;
-Checks Keyboard and Touchpad state  

-If enabled, disables both and launches the configured onscreen keyboard (onboard by default)
-If disabled, kills the configured onscreen keyboard and re-enables the touchpad and keyboard
-Provides a configuration option to notify the user via notify-send of state change as well as error notifications
-Provides arguments for verbose output when executed manually via bash [-v] and a dry-run option for state/device information [-n]

Suggested Use;
-Create a shortcut and place on your desktop/launcher etc and click once when you want to switch between modes

This was written tested on Ubuntu 14.10
