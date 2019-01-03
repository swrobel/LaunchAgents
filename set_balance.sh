#!/usr/bin/env osascript

tell application "System Events"
  set activeApp to name of first application process whose frontmost is true
  if not ("System Preferences" is in activeApp) then
    tell application "System Preferences"
      reveal anchor "output" of pane id "com.apple.preference.sound"
    end tell

    tell application "System Events"
      tell application process "System Preferences"
        repeat until exists tab group 1 of window "Sound"
        end repeat
        tell slider 1 of group 1 of tab group 1 of window 1
          set value to 0.5
        end tell
      end tell
    end tell

    tell application "System Preferences"
      quit
    end tell
  end if
end tell
