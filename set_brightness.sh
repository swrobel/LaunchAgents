# Set secondary display brightness to match primary display (calibrated for iMac 27" 2015 & Dell P2415Q)

DISPLAY_STATE=`ioreg -n IODisplayWrangler | grep -i IOPowerManagement | perl -pe 's/^.*DevicePowerState\"=([0-9]+).*$/$1/'`

# Only if display is awake
if [[ $DISPLAY_STATE = "4" ]]; then
  IMAC_BRIGHTNESS=`/usr/local/bin/brightness -l 2>&1 | sed -nE 's/^display 0: brightness ([0-9.]+)$/\1/p'`
  # iMac ~ 440 cd/m² brightness, Dell 300 cd/m² ~ 1.47/1 ratio
  DELL_BRIGHTNESS=`echo "$IMAC_BRIGHTNESS * 147" | bc`
  date
  /usr/local/bin/ddcctl -d 1 -b $DELL_BRIGHTNESS
fi
