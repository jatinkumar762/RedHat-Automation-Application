#!/bin/bash
dialog --title "Hello" --infobox "************************************\n*** Welcome to Redhat Automation ***\n************************************" 30 40
sleep 3
espeak "hello"
espeak "welcome to redhat automation"
dialog --begin 7 25 --backtitle "System Information" \
--title "About" \
--infobox "This is an open source software" 10 30
espeak "This an open source software"
sleep 3
dialog --msgbox "************************************\n********Click OK to Continue********\n************************************ " 20 40
        while [ 1 ]
        do
		dialog --cancel-label "EXIT" --title "login screen" --inputbox "Enter Username :  " 20 40 2> /tmp/user.txt
                        if [ $? -eq 0 ]
                        then
			      dialog --insecure --title "login screen" --passwordbox "Enter Password :  " 20 40 2> /tmp/passw.txt
        	              if [ $? -eq 0 ]
                              then
                                  break
                              fi
                        else
                               clear
                               banner "    Bye    "
                               for (( i=1;i<=4;i++ ))
			       do
   			          echo
			       done
			       banner "Thank You"
                               espeak "Bye"
                               espeak "Thank you"
                              sleep 3
                              exit
                        fi
         done                          
u1=`cat /tmp/user.txt`
	                   
p1=`cat /tmp/passw.txt`

if [ $u1 == "jatinkumar" -a $p1 == "redhat" ]
then
dialog --infobox "login suceesfully" 10 30
espeak "welcome jatin kumar"
sleep 1
##dialog --cancel-label " " --ok-label "  " --pause "Loading.......\nPlease Wait....." 20 40 5
for i in 20 40 60 80 100
do
echo "$i" | dialog --gauge "Loading....\nPlease Wait....." 10 70
sleep 1
done
else
dialog --infobox "Sorry! try again" 10 30
sleep 2
exit
fi

while [ 1 ]
do
dialog --cancel-label "Exit" --ok-label "Enter" --title "Menu " --menu "Enter your choice: " 40 40 9 1. "Basic Commands" 2. "Sever Configuration" 3. "User Management" 4. "File's Management" 5. "Security Implement" 6. "Networking Basics" 7. "Fun with Chat" 8. "Remote Login to your Linux" ' ' "server via web browser" 2>/tmp/result
        if [ $? -eq 1 ]
	then
            clear
            banner "    Bye    "
           for (( i=1;i<=4;i++ ))
           do
            echo
          done
           banner "Thank You"
           espeak "Bye"
           espeak "Thank you"
           sleep 3
	    exit 
	fi
res=`cat /tmp/result`
rm -rf /tmp/result	
if [ "$res" == "1." ]
then
dialog --title "Basic Commands" --menu "Enter your choice: " 40 30 7 1. "Date & Time" 2. "Calendar" 3. "Disk State" 4. "System Information" 5. "Current Users" 6. "Create Backup" 7. "Create Bar Code"  2> result
res=`cat result`

	if [ "$res" == "1." ]
	then
	echo "Date is  :`date +%D`" >h
	echo "Time is  :`date +%T`">>h
	dialog --textbox h 10 30 
	elif [ "$res" == "2." ]
	then
	dialog --title "Calendar" --menu "Enter your choice: " 40 30 3 1. "CurrentMonth" 2. "Current year" 3. "Curr,Prev,Next month " 2> result
	res=`cat result`
                if [ "$res" == "1." ]
		then
		cal >/tmp/h
		dialog --title "CurrentMonth Calendar" --textbox h 30 50
		elif [ "$res" == "2." ]
		then
		echo " `cal -y` " >/tmp/h
		dialog --title "Curr. Year Calendar" --textbox /tmp/h 30 50
                rm -r /tmp/h
                elif [ "$res" == "3." ]
                then
                echo "`cal -3`" >/tmp/h
                dialog --title "Calendar" --textbox /tmp/h 12 50
		fi
        elif [ "$res" == "3." ]
        then
        dialog --title "Disk Statistic" --menu "Enter your choice :" 10 30 2 1. "Free Space" 2. "Disk Usage" 2> res
        r=`cat res`
        	if [ "$r" == "1." ]
                then
                	echo "`df -H`" >tmp1
                	dialog --title "Free Space" --textbox tmp1 30 70
                	rm -r tmp1
                elif [ "$r" == "2." ]
                then
                	dialog --title "Disk Usage" --inputbox "Enter the File or Folder name with Path :" 15 40 2>file
                        f=`cat file`
                        echo "Files + Folders" >tmp1
                        echo "Size      File & Dir. Names" >>tmp1
                        echo "`du -ah $f`" >>tmp1
                        dialog --title "Disk Usage" --textbox tmp1 30 70
                        rm -r tmp1
                fi 
        rm -r res 
        elif [ "$res" == "4." ]
        then
        echo "        ***Information is printed in following Order***" >/tmp/inf
        echo >>/tmp/inf
        echo "kernel name, network node hostname, kernel release, kernel version, machine hardware name, processor type, hardware platform, operating system" >>/tmp/inf
        uname -a >>/tmp/inf
        dialog --textbox /tmp/inf 10 70
        rm -rf /tmp/inf 
	elif [ "$res" == "5." ]
        then
        echo "`who -H`" >h
        echo "Toatl Users :" >>h
        echo "`who -q`" >>h
        dialog --title "Users" --textbox h 20 40
        rm -r h
        elif [ "$res" == "6." ]
        then
              dialog --inputbox "Provide path for package where you store package with Package Name:" 10 40 2>/tmp/name
              n2=`cat /tmp/name` 
              dialog --inputbox "Enter the number of files for backup create :" 10 40 2>/tmp/name
              n=`cat /tmp/name`
                for (( i=1;i<=n;i++ ))
                do
                     dialog --inputbox "Enter the file name :" 10 40 2>/tmp/name
                     jj=`cat /tmp/name`
                     if [ i -eq 1 ]
                     then
                     tar -cf $n2 $jj
                     else
                     tar -rf $n2 $jj
                     fi
                done  
        elif [ "$res" == "7." ]
        then
               dialog --inputbox "Enter the text :" 10 30 2>/tmp/name
               nm=`cat /tmp/name`
               dialog --inputbox "Give the Image file name with .png extension" 10 30 2>/tmp/image
               im=`cat /tmp/image`
               dialog --inputbox "Give the size for image :" 10 30 2>/tmp/size
               si=`cat /tmp/size`
               qrencode -o /root/Desktop/$im -s $si "$nm"
               rm -rf /tmp/name /tmp/size /tmp/image
               dialog --infobox "Successfully Created" 10 30
               sleep 4
        fi
elif [ "$res" == "2." ]
then
dialog --title "Sever-Configuration" --menu "Enter your choice: " 40 30 8 1. "TELNET-Server" 2. "SAMBA-Server" 3. "NFS-Server" 4. "SSH-Server" 5. "FTP Server" 6. "NIS Server" 7. "WEB Server" 8. "Autofs Server" 2> result
res=`cat result`
rm -rf result
         if [ "$res" == "1." ]
         then
         dialog --title "TELNET-Server" --menu "Enter your choice: " 40 30 2 1. "Remove Server" 2. "Make Server" 2> result
         res=`cat result`
         		if [ "$res" == "1." ]
                        then
                            rpm -q telnet-server
                            if [ $? -eq 0 ]
                            then
                        		rpm -e telnet-server &>/dev/null
                        		for i in 10 30 50 70 100
                        		do
                        		echo "$i" | dialog --gauge "wait......" 10 70
                        		sleep 2
                        		done
                        		dialog --ascii-lines --infobox "Successfully Uninstall the TELNET-Server" 10 30
                       		        sleep 2
                            else 
                                  dialog --infobox "TELNET Server is already Uninstalled.....\nNothing to do...." 10 30
                                  sleep 5
                            fi                       
                        elif [ "$res" == "2." ]
                        then
                        bash /root/Desktop/Project/server/telnetinstall
                        fi
          elif [ "$res" == "2." ]
          then
          bash /root/Desktop/Project/server/samba-server
          elif [ "$res" == "3." ]
          then
          bash /root/Desktop/Project/server/nfs-server 
          elif [ "$res" == "4." ]
          then
          bash /root/Desktop/Project/server/ssh-server
          elif [ "$res" == "5." ]
          then
          bash /root/Desktop/Project/server/ftp-server
          elif [ "$res" == "6." ]
          then
          bash /root/Desktop/Project/server/nis-server
          elif [ "$res" == "7." ]
          then
          bash /root/Desktop/Project/server/web-server
          elif [ "$res" == "8." ]
          then
          bash /root/Desktop/Project/server/autofs
          fi                        
elif [ "$res" == "3." ]
then
dialog --title "User Management" --menu "Enter your choice: " 40 30 6 1. "Add_User" 2. "Delete_User" 3. "ChangePassword" 4. "Add_Group" 5. "Add users in a group" 6. "Delete_Group" 2> result 
res=`cat result`
rm -r result
                case $res in
                "1.")dialog --title "Add_User" --inputbox "Enter Username :  " 20 40 2> /tmp/name.txt
                     dialog --title "Add_User" --passwordbox "Enter Password :  " 20 40 2> /tmp/pass.txt
                     name=`cat /tmp/name.txt`
                     pass=`cat /tmp/pass.txt`
                     useradd $name
                     echo "$pass" | passwd $name --stdin
                     rm -r /tmp/name.txt /tmp/pass.txt
                     ;;
                "2.")dialog --title "Delete_User" --inputbox "Enter Username :  " 20 40 2> /tmp/name.txt
                     name=`cat /tmp/name.txt`
                     userdel -r $name
                     ;;
                "3.")dialog --title "Delete_User" --inputbox "Enter Username :  " 10 40 2> /tmp/name.txt
                     dialog --title "Delete_User" --passwordbox "Enter Password :  " 10 40 2> /tmp/pass.txt
                     name=`cat /tmp/name.txt`
                     pass=`cat /tmp/pass.txt`
                     echo "$pass" | passwd $name --stdin
                     rm -r /tmp/name.txt /tmp/pass.txt
                     ;;
                "4.")dialog --title "Add_Group" --inputbox "Enter group name :" 10 30 2> /tmp/name.txt  
                     name=`cat /tmp/name.txt`
                     groupadd $name
                     rm -r /tmp/name.txt
                     ;;
                "5.")dialog --begin 5 5 --inputbox "Enter number of user :" 10 20 2> /tmp/num.txt 
                     dialog --inputbox "Enter name of group :" 20 30 2> /tmp/gname.txt  
                     num=`cat /tmp/num.txt`
                     gnam=`cat /tmp/gname.txt`
                     for (( i=1;i<=$num;i++ ))
                     do
                     dialog --inputbox "Enter name of user :" 10 20 2> /tmp/name.txt
                     name=`cat /tmp/name.txt`
                     `usermod -G $gnam $name`
                     done
                     rm -r /tmp/num.txt /tmp/gname.txt /tmp/name.txt
                     ;;
                "6.")dialog --title "Delete_Group" --inputbox "Enter name of group :" 20 30 2> /tmp/gname.txt
                     gnam=`cat /tmp/gname.txt`
                     groupdel $gnam
                     ;;
                esac
elif [ "$res" == "4." ]
then
    bash /root/Desktop/Project/other/filemanagement
elif [ "$res" == "5." ]
then
	dialog --title "Security Implement" --menu "Enter Choice :" 15 60 5 1. "ACL (Access Control List)" 2. "Firewall" 3. "SELinux (Security Enhanced Linux)"	4. "TCP Wrapper" 5. "Permissions (Advanced+Normal)" 2>/tmp/choice
        c=`cat /tmp/choice`
        rm -r /tmp/choice
                     if [ "$c" == "1." ]
                     then
                        bash /root/Desktop/Project/security/acl
                     elif [ "$c" == "2." ]
                     then
                        bash /root/Desktop/Project/security/firewall
                     elif [ "$c" == "3." ]
                     then
                         bash /root/Desktop/Project/security/selinux
		     elif [ "$c" == "4." ]
                     then
                       bash /root/Desktop/Project/security/tcp-wrapper
                     elif [ "$c" == "5." ]
                     then
                        bash /root/Desktop/Project/security/permission                        
                     fi
elif [ "$res" == "6." ]
then
    bash /root/Desktop/Project/other/netwbasic
elif [ "$res" == "7." ]
then
   bash /root/Desktop/Project/other/chat
elif [ "$res" == "8." ]
then
   bash /root/Desktop/Project/other/shellbox
fi

done


