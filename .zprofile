# Enabling 256 color in the terminal
if [ "$TERM" = "xterm" ]
then
    export TERM=xterm-256color
fi
export PATH="/opt/chefdk/embedded/bin:$PATH"
