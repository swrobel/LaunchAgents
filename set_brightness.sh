#!/usr/bin/env osascript

set display_state to (do shell script "ioreg -n IODisplayWrangler | grep -i IOPowerManagement | perl -pe 's/^.*DevicePowerState\"=([0-9]+).*$/$1/'")

tell application "System Events"
  set activeApp to name of first application process whose frontmost is true
  if not ("System Preferences" is in activeApp) then
    if (display_state = "4") then
      tell application "System Preferences"
        set current pane to pane "com.apple.preference.displays"
      end tell

      tell application "System Events"
        tell application process "System Preferences"
          repeat until exists tab group 1 of window "Built-in Retina Display"
          end repeat
          set brightness to (get value of slider 1 of group 1 of tab group 1 of window "Built-in Retina Display") * 100 + 40
        end tell
      end tell

      tell application "System Preferences"
        quit
      end tell

      return do shell script "date && /usr/local/bin/ddcctl -d 1 -b " & brightness
    end if
  end if
end tell
