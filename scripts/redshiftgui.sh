title="RedshiftGUI v1.0"
function jumpto() {
    label=$1
    cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')
    eval "$cmd"
    exit
}
ZEN=/usr/bin/zenity
if test -f "$ZEN"; then
    RED=/usr/bin/redshift
    if test -f "$RED"; then
        zenity --question --title="$title" --ellipsize --text="RedshiftGUI contains flashing.\nIf you are prone to epilepsy or seizures, you may want to leave this app."
        pick: || true
        YESNO=$?
        echo "$YESNO"
        if [ $YESNO == 1 ]; then
            exit
        else
            option=$(zenity \
                --list --title="$title" \
                --text="Select a mode" \
                --print-column="1" \
                --column="pick" \
                --hide-header \
                "Simple Mode" \
                "Advanced Mode")
            if [ "$YESNO" = "1" ]; then
                zenity --question --ellipsize --title="$title" --text="Are you sure you want to exit?"
                if [ "$YESNO" = "1" ]; then
                    jumpto pick || true
                fi
            fi
            if [ "$option" == "Simple Mode" ]; then
                VALUE=$(zenity --scale --text="Select a color. (Lower = warmer)" --value=2 --max-value=5 --min-value=1 --title="$title")'000K'
                if [ "$YESNO" == "1" ]
                then
                killall redshift
                redshift -x -P
                redshift -O $VALUE
                fi
            elif [ "$option" == "Advanced Mode" ]; then
                advanced:
                VALUE=$(zenity --forms --title="$title" --add-entry="Value (ex. 4400)" --text="Enter a color")
                    if [ "$VALUE" == "" ]; then
                        zenity --error --ellipsize --title="$title" --text="Please input a value"
                        jumpto advanced
                    else
                        killall redshift
                        redshift -x -P
                        redshift -O $VALUE
                    fi
            fi

        fi

    else
        zenity --error --ellipsize --title=$title --text="You don't have Redshift installed! Would you like to install it? (y/n)"
        exit
    fi
else
    echo "Zenity is not installed! Would you like to install it? (y/n)"
    exit
fi
