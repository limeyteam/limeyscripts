package=$(zenity \
    --list --title="Limey Updater" \
    --text="Which program would you like to install/update?" \
    --print-column="1" \
    --column="Package name" --column="Description" \
    redshiftgui "GUI for the RedShift program" \
    linux-gamers "Test" \
    linux-gamers "Test" \
    linux-gamers "Test" \
    linux-gamers "Test")
YESNO=$?
if [ $YESNO == "0" ]; then
    if [ "$package" == "" ]; then
        zenity --error --text="Select an option"
    else
        zenity --question --text="Would you like to auto download?\nThis will auto download and run the package.\nOtherwise, it will just open the browser."
        wget "https://limeyteam.github.io/scripts/"$package
        bash $package
    fi
fi
echo Cancelled
