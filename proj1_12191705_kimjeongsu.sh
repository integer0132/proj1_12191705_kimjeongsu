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

	case "$menu_num" in
	1)
		read -p "Do you want to get the Heung-Min Son's data? (y/n) :" func1_yn

		if [ "$func1_yn" = "y" ]
		then
			cat ./$2 | awk -F, '$1=="Heung-Min Son"{printf("Team:%s, Apperance:%d, Goal:%d, Assist:%d\n",$4, $6, $7, $8)}'
		elif [ "$func1_yn" = "n" ]
		then
			continue
		else
			echo "Error: Invalid option..."
			continue
		fi;;
	2)
		read -p "What do you want to get the team data of league_position[1~20] : " func2_num
		
		if [ "$func2_num" -ge 1 ]
		then
			if [ "$func2_num" -le 20 ]
			then
				cat ./$1 | awk -F, -v f2=$func2_num '$6==f2{print f2, $1, $2/($2+$3+$4)}'
			else
				echo "Error: Invalid option..."
				continue
			fi
		else
			echo "Error: Invalid option..."
			continue
		fi;;
	3)
		read -p "Do you want to know Top-3 attendance data and average attendance? (y/n) : " func3_yn

		if [ "$func3_yn" = "y" ]
		then
			echo "***Top-3 Attendance Match***"
			
			n=1

			while [ $n -le 3 ]
			do
				echo ""
				cat ./$3 | sort -t, -r -n -k 2 | awk -F, -v nn=$n 'NR==nn{printf("%s vs %s (%s)\n%d %s\n",$3, $4, $1, $2, $7)}'
				n=$(( n+1 ))
			done

		elif [ "$func3_yn" = "n" ]
		then
			continue
		else
			echo "Error: Invalid option..."
			continue
		fi;;
	4)
		;;
	5)
		;;
	6)
		;;
	7)
		echo "Bye!"
		echo ""
		exit 0;;
	*)
		echo "Error: Invalid option...";;
	esac

done
