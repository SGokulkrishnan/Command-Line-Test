<<doc
Name         :Gokulkrishnan
Date         :04-01-2023
Description  :Project - Command Line Test
doc

###################################### PROGRAM ##################################

#!/bin/bash

echo -e "\n                          \e[1;33mWelcome to Emertxe_Test\e[0m\n\n Please select options below:\n                              1)Sign up\n                              2)Sign in\n                              3)Exit" #Greeting for user and asking them to choose option
while [ 1 ]	#while loop to stay until basic requriments are properly given
do
	read option 
	case $option in #reading input from user and preformiong program according to user input by using case
		1) 
			while [ 1 ]
			do
				read -p "Pease enter your username: " username
				flag=0
				array=(`cat user.csv`) 		#storing user data into array
				if [ ${#array[@]} -ne 0 ]	#If file is not empty check the given name is already taken or not
				then
					for i in ${array[@]}	
					do
						if [ $i = $username ]	#If the user name is already taken then print the error and ask user to provider another name
						then
							echo -e "\e[1;31m\nUser name is already taken, please enter a different username\e[0m\n"
							flag=1	#setting flag value as 1 to dont enter for passowrd part and come bask to user name part
						fi
					done
					if [ $flag -eq 0 ]	#if flag is 0 means user name is fine and proceed for passowrd part
					then
						while [ 1 ] 	#While loop to stay in passord part until passowrd has set  sucussfully
						do
							read -sp "Enter the password   : " pass
							echo 
							read -sp "Confirmation the password: " c_pass
							echo
							if [ $pass = $c_pass ]	#if the password is same then store in excel
							then
								echo $username >> user.csv
								echo $pass >> pass.csv
								break
							fi
							echo -e "\n\e[1;31mPassword and confirmation password is not matched. Please re-enter the password.\e[0m\n"
						done
						break
					fi
				elif [ ${#array[@]} -eq 0 ] #If excel is empty then create user account
				then
					while [ 1 ]
					do
						read -sp "Enter the password   : " pass
						echo
						read -sp "Confirmation the password: " c_pass
						echo
						if [ $pass = $c_pass ]
						then
							echo $username >> user.csv
							echo $pass >> pass.csv
							break
						fi
						echo -e "\n\e[1;31mPassword and confirmation password is not matched. Please re-enter the password.\e[0m\n"
					done
					break
				fi
			done;;
		2) 
			flag=0
			while [ 1 ]
			do
				echo
				if [ $flag -eq 0 ]	#if flag 0 means user trying 1st time so its ask to enter name else it asking user to re-enter user name
				then
					read -p "Enter the username: " username
				else
					read -p "Re-enter the username: " username
				fi
				flag=0
				array_u=(`cat user.csv`)			#saving user name in array
				for i in `seq 0 $((${#array_u[@]}-1))`		#checking given user name is already there in excel or not(user already created or not)
				do
					if [ $username = ${array_u[$i]} ]
					then
						flag1=0
						while [ 1 ]
						do
							if [ $flag1 -eq 0 ]	#flag 0 means user entering pass 1st time else he is trying 2nd or nth time
							then
								read -sp "Enter the passowrd: " pass
							else
								read -sp "Re-enter the passowrd: " pass
							fi
							array_p=(`cat pass.csv`)	#storing password in array
							if [ ${array_p[$i]} = $pass ]	#check the given passowrd is stored  in $i th position
							then
								echo -e "\n\e[1;32mlogin sucess fully :)\e[0m\n" #informing user for succesfull login
								echo -e  "\n\e[1;33m                    Hi $username, Welome to Emertxe test\n                            All the best!!! \e[0m\n"
								flag=1
								break
							else
								echo -e "\n\e[1;31mUser name or password is in correct please enter the correct one\e[0m"
								flag1=1
							fi
						done
					fi
				done
				if [ $flag -eq 0 ] #if flag value is 0 means asking user to re0enter the detils
				then
					echo -e "\e[1;31m\nUser name or password is in correct please enter the correct one\e[0m"
					flag=1
				else
					break #all the information are corrent then break the loop
				fi
			done
			;;
		3) echo -e "\e[1;33mSince you visited, we have felt excellently happy and excited to meet you again!\e[0m\n" #exiting case
			exit;;
	esac

	echo -e "Choose below options:\n                              1)Take a test\n                              2)Exit" 
	read option1	#ger the input from user
	case $option1 in #case statement to run user input
		1)
			q_no=0
			total=0
			correct_ans=(`cat correctans.txt`)		#stroing coreect ans inarray to verify
			echo "choose the correct answer"
			file_len=`cat questionbank.txt | wc -l`		#find question basnk length
			for i in `seq 5 5 $file_len`		
			do
				echo
				head -$i questionbank.txt | tail -5	#print 5 line from qustionbank(file) to print question
				echo
				for j in `seq 10 -1 0`			#timer for 10sec
				do
					echo -ne "\rEnter the option($j)"
					read -t 1 answer[$q_no]  	#read the anser
					if [ -n "${answer[$q_no]}" ]	
					then
						break
					else
						answer[$q_no]="e"	#if time out store 'e' as default answer
					fi
				done
				if [ ${answer[$q_no]} = ${correct_ans[$q_no]} ]	#to check the given asnwer is correct or not
				then
					echo -e "\n\e[1;32mCorrect answer\e[0m"	#print as correct answer with green color
					total=$(($total+1))
				elif [ ${answer[$q_no]} = "e" ]
				then
					echo -e "\n\e[1;34mTime out\e[0m"	#print as time out
				else
					echo -e "\n\e[1;31mWrong answer\e[0m\nYour answer: ${answer[$q_no]}\nCorrect answer: ${correct_ans[$q_no]}"									#print it is wrong answer and print correct anwer also
				fi
				q_no=$(($q_no+1))				    #count the correct answers only	
			done
			echo -e "Total correct answer is: \e[1;33m$total/10\e[0m"	#print total corect answer
			break
			;;
		2)
			echo -e "\n\e[1;33mSince you visited, we have felt excellently happy and excited to meet you again\e[0m\n"
			exit;;								#exit infomarion & exit case
	esac
done
echo -e "\n         \e[1;33m-----Result------\e[0m"		
q_no=0
file_len=`cat questionbank.txt | wc -l`
for i in `seq 5 5 $file_len`
do
	echo
	head -$i questionbank.txt | tail -5		#print question 5 lines in one time
	if [ ${answer[$q_no]} = ${correct_ans[$q_no]} ]	#check user answer 
	then
		echo -e "\n\e[1;32mCorrect answer\e[0m" #is it is corret it will exicute
	elif [ ${answer[$q_no]} = "e" ]			#it will print if te question is not atended by user
	then
		echo -e "\n\e[1;34mTime out\e[0m"	
	else
		echo -e "\n\e[1;31mWrong answer\e[0m\nYour answer: ${answer[$q_no]}\nCorrect answer: ${correct_ans[$q_no]}" #f the anser is wrong infor user which is correct answer.
	fi
	q_no=$(($q_no+1))				#count corect answer
done
echo -e "\nTotal correct anser is: \e[1;33m$total/10\e[0m\n\n"	#print total correct answer
if [ $total -le 5 ]			#to motivate user as per user total marks
then
	echo "Allow yourself to be a beginner. No one starts off being excellent."
elif [ $total -le 8 -a $total -gt 5 ]
then
	echo "If you can believe it, your mind can achieve it."
elif [ $total -ge 9 ]
then
	echo "Keep going.."
fi
echo -e "               \e[1;33mThank you \e[0m\n"
