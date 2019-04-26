#!/bin/sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done


# Launch bar1 and bar2
DISPLAY1=HDMI1
[[ ! -z "$DISPLAY1" ]] && MONITOR="$DISPLAY1" polybar i3 &

DISPLAY2=VGA1
[[ ! -z $DISPLAY2 ]] && MONITOR=$DISPLAY2 polybar i3-left &

echo "Bars launched..."
