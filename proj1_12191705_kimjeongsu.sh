#! /bin/bash

if [ $# -ne 3 ]
then
	echo "usage: $0 file1 file2 file3"
	echo ""
	exit 1
fi

echo "************OSS1 - Project1************"
echo "*	StudentID : 12191705	      *"
echo "*	Name : Jeongsu Kim	      *"
echo "***************************************"

while :
do
	echo ""
	echo "[MENU]"
	echo "1. Get the data of Heung-Min Son's Current Club, Appearances, Goals, Assists in players.csv"
	echo "2. Get the team data to enter a league position in teams.csv"
	echo "3. Get the Top-3 Attendance matches in mateches.csv"
	echo "4. Get the team's league position and team's top scorer in teams.csv & players.csv"
	echo "5. Get the modified format of date_GMT in matches.csv"
	echo "6. Get the data of the winning team by the largest difference on home stadium in teams.csv & matches.csv"
	echo "7. Exit"
	
	read -p "Enter your CHOICE (1~7) : " menu_num
done
