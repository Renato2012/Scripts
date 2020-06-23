#!/bin/bash
#
# Schedule a time and you will be notified when the current time is the scheduled time.
# Program with display dialog boxes to the user.
# [1] https://terminalroot.com.br/2015/08/como-criar-caixas-de-dialogo-interativa.html
#
# Renato Araújo, in June 22 2020. 
#

#HHMM=$(whiptail --title "Notify-me" --inputbox "Type exact hour and minute (hh:mm formart)." 10 60 3>&1 1>&2 2>&3)

function stop () {
    whiptail --title "Notify-me" --msgbox "Bye." 10 60
    exit 0
}

function choiceHour () {
    HH=$(whiptail --title "Notify-me" --menu \
    "Choose the hour, please:" 15 60 4 \
    "01" "1" \
    "02" "2" \
    "03" "3" \
    "04" "4" \
    "05" "5" \
    "06" "6" \
    "07" "7" \
    "08" "8" \
    "09" "9" \
    "10" "10" \
    "11" "11" \
    "12" "12" \
    "13" "1" \
    "14" "2" \
    "15" "3" \
    "16" "4" \
    "17" "5" \
    "18" "6" \
    "19" "7" \
    "20" "8" \
    "21" "9" \
    "22" "10" \
    "23" "11" \
    "00" "12" 3>&1 1>&2 2>&3)

    HHexitstatus=$?
    if [ $HHexitstatus != 0 ]
    then
        echo "Hour: $HH" # to comment.
        stop # call function stop ().
    fi

    MM=$(whiptail --title "Notify-me" --menu \
    "Hour will be $HH. Choose the minute, please:" 15 60 4 \
    "00" "" \
    "01" "" \
    "02" "" \
    "03" "" \
    "04" "" \
    "05" "" \
    "06" "" \
    "07" "" \
    "08" "" \
    "09" "" \
    "10" "" \
    "11" "" \
    "12" "" \
    "13" "" \
    "14" "" \
    "15" "" \
    "16" "" \
    "17" "" \
    "18" "" \
    "19" "" \
    "20" "" \
    "21" "" \
    "22" "" \
    "23" "" \
    "24" "" \
    "25" "" \
    "26" "" \
    "27" "" \
    "28" "" \
    "29" "" \
    "30" "" \
    "31" "" \
    "32" "" \
    "33" "" \
    "34" "" \
    "35" "" \
    "36" "" \
    "37" "" \
    "38" "" \
    "39" "" \
    "40" "" \
    "41" "" \
    "42" "" \
    "43" "" \
    "44" "" \
    "45" "" \
    "46" "" \
    "47" "" \
    "48" "" \
    "49" "" \
    "50" "" \
    "51" "" \
    "52" "" \
    "53" "" \
    "54" "" \
    "55" "" \
    "56" "" \
    "57" "" \
    "58" "" \
    "59" "" 3>&1 1>&2 2>&3)

    MMexitstatus=$?
    if [ $MMexitstatus != 0 ]
    then
        echo "Hour and minute: $HH:$MM" # to comment.
        stop # call function stop ().
    else
        core # call function core ().
    fi
}


function core () {
    if (whiptail --title "Notify-me" --yesno "Your choice was at $HH:$MM. That's right?" 10 60)
    then
        echo "Your choice is Yes. Exit with status $?." # to comment
        # TERM=vt220 is a solution for a bug from infobox.
        TERM=vt220 whiptail --title "Notify-me" --infobox "Time set to $HH:$MM. You will be warned." 10 60       

        STOP=false 
        while :
        do
            if [ `date +%H:%M` = "$HH:$MM" ]
            then
                notify-send "Attention $USER the current time is $HH:$MM!"
                spd-say "Your task is now."
                STOP=true
            elif $STOP
            then
                echo "Breaking"
                break # stopping script.
                stop # call function stop ().
            fi
        sleep 10 # sleep every 10 seconds. Notify-me 6 times (60/10=6).
        done
    else
        echo "Your choice is No. Exit with status $?." # to comment
        if (whiptail --title "Notify-me" --yes-button "Continue" --no-button "Exit" --yesno "Do you want to continue or exit?" 10 60)
        then
            echo "Your choice is Continue. Exit with status $?." # to comment
            choiceHour # call function choiceHour ().
        else
            echo "Your choice is Exit. Exit with status $?." # to comment
            stop # call function stop ().
        fi
    fi
}


# Starting.
option=a
case $option in
a) choiceHour;;
#b) futureRole;;
esac

exit 0

