zenity --question --title="RedshiftGUI" --text="RedshiftGUI is still buggy and uses while loops. Do you want to continue?"
YESNO=$?
if [ $YESNO == 1 ]
then
exit
else
PRIVATE=`zenity --scale --text="Select a nightlight color." --value=5 --max-value=25 --min-value=1 --title="RedshiftGUI"`'000K'
redshift -x -P
while :
do
  redshift -O $PRIVATE
done
fi
