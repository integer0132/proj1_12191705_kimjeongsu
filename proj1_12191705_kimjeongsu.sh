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
		
		if [ -n "$func2_num" ] && [ "$func2_num" -ge 1 ]
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
		read -p "Do you want to get each team's ranking and the highest-scoring player? (y/n) : " func4_yn

		if [ "$func4_yn" = "y" ]
		then
			n4=2

			while [ $n4 -le 21 ]
			do
				echo ""
				team_name=$(cat ./$1 | sort -t, -n -k 6 | awk -F, -v nn4=$n4 'NR==nn4{print $1}')
				cat ./$1 | sort -t, -n -k 6 | awk -F, -v nn44=$n4 'NR==nn44{print $6, $1}'
				cat ./$2 | awk -F, -v tn="$team_name" 'tn==$4{printf("%s,%s\n", $1, $7)}' | sort -t, -r -n -k 2 | awk -F, 'NR==1{print $1, $2}'
				n4=$(( n4+1 ))
			done
		elif [ "$func4_yn" = "n" ]
		then
			continue
		else
			echo "Error: Invalid option..."
			continue
		fi;;
	5)
		read -p "Do you want to modify the format of date? (y/n) : " func5_yn

		if [ "$func5_yn" = "y" ]
		then
		cat ./$3 | sed -Ene 's/\,/ /' -Ene 's/([A-Z][a-z]{2}) ([0-9]{2}) ([0-9]{4}) ([-]) ([0-9][0-9]?[:][0-9]{2}[ap][m]) (.*)/\3\/\1\/\2 \5/' -Ene 's/Aug/08/g' -Ene 's/Sep/09/g' -Ene 's/Oct/10/g' -Ene 's/Nov/11/g' -Ene 's/Dec/12/g' -Ene 's/Jan/01/g' -Ene 's/Feb/02/g' -Ene 's/Mar/03/g' -Ene 's/Apr/04/g' -Ene 's/may/05/g' -Ene 's/Jun/06/g' -Ene 's/Jul/07/g' -Ene '2,11p'
		elif [ "$func5_yn" = "n" ]
		then
			continue
		else
			echo "Error: Invalid option..."
			continue
		fi;;
	6)
		n6=1

		while [ "$n6" -le 10 ]
		do
			cat ./$1 | awk -F, -v temp_n6="$n6" 'NR==temp_n6{printf("%d) %-25s\t", temp_n6, $1)}'
			cat ./$1 | awk -F, -v temp_n6="$n6" 'NR==temp_n6+10{printf("%d) %-25s\n", temp_n6+10, $1)}'
			n6=$(( n6+1 ))
		done

		read -p "Enter your team number : " func6_num
		
		if [ -n "$func6_num" ] && [ "$func6_num" -ge 1 ]
		then
			if [ "$func6_num" -le 20 ]
			then
				team_name6=$(cat ./$1 | awk -F, -v nn6=$((func6_num+1)) 'NR==nn6{print $1}')
				
				max6=0

				for v in $(cat ./$3 | awk -F, -v tn6="$team_name6" '$3==tn6{printf("%d,%d\n", $5, $6)}')
				do
					temp66=$(echo $v | awk -F, '{print ($1-$2)}')
					
					if [ "$max6" -lt "$temp66" ]
					then
						max6=$temp66
					fi
				done

				cat ./$3 | awk -F, -v tn66="$team_name6" -v m6="$max6" '$3==tn66 && $5-$6==m6{printf("\n%s\n%s %d vs %d %s\n", $1, $3, $5, $6, $4)}'
				
			else
				echo "Error: Invalid option..."
				continue
			fi
		else
			echo "Error: Invalid option..."
			continue
		fi;;
	7)
		echo "Bye!"
		echo ""
		exit 0;;
	*)
		echo "Error: Invalid option...";;
	esac

done
