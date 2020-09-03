#!/bin/bash
RED='\033[0;31m]'
GREEN='\033[0;32m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
RESET='\033[0m'
LOGO="${CYAN}                       ::::::::: :::::::::::   :::   :::    ::::::::   ::::::::  :::::::::  ::::::::::
                      :+:    :+:    :+:      :+:+: :+:+:  :+:    :+: :+:    :+: :+:    :+: :+:
                     +:+    +:+    +:+     +:+ +:+:+ +:+ +:+        +:+    +:+ +:+    +:+ +:+
                    +#++:++#+     +#+     +#+  +:+  +#+ +#+        +#+    +:+ +#++:++#:  +#++:++#
                   +#+           +#+     +#+       +#+ +#+        +#+    +#+ +#+    +#+ +#+
                  #+#           #+#     #+#       #+# #+#    #+# #+#    #+# #+#    #+# #+#
                 ###       ########### ###       ###  ########   ########  ###    ### ##########
               ::::::::  :::::::::: ::::    ::: :::::::::: :::::::::      ::: ::::::::::: ::::::::  :::::::::
             :+:    :+: :+:        :+:+:   :+: :+:        :+:    :+:   :+: :+:   :+:    :+:    :+: :+:    :+:
            +:+        +:+        :+:+:+  +:+ +:+        +:+    +:+  +:+   +:+  +:+    +:+    +:+ +:+    +:+
           :#:        +#++:++#   +#+ +:+ +#+ +#++:++#   +#++:++#:  +#++:++#++: +#+    +#+    +:+ +#++:++#:
          +#+   +#+# +#+        +#+  +#+#+# +#+        +#+    +#+ +#+     +#+ +#+    +#+    +#+ +#+    +#+
         #+#    #+# #+#        #+#   #+#+# #+#        #+#    #+# #+#     #+# #+#    #+#    #+# #+#    #+#
         ########  ########## ###    #### ########## ###    ### ###     ### ###     ########  ###    ###${RESET}\n
                                        Your Path to be a sad F2E developer\n"

printLogo() {
  # this function will print the annoy logo and keep the terminal clean (with the freakin logo of course)
  clear
  printf "${LOGO}"
}

replaceMountpoint () {
  # this function will replace the mountpoint placeholder to user's input
  local search='$MOUNTPOINT;'
  local replace=$MOUNTPOINT

  sed -i "s/${search}/${replace}/g" test.txt
}

printLogo
# prompt user for project name
read -p $'\e[32mYour Project Name: \e[0m' PROJECT
printLogo
read -p $'\e[32mYour Docker Mount point: \e[0m' MOUNTPOINT

replaceMountpoint

# create project folder by fetching docker-compse file from github
# echo "${GREEN}
# ########################################################################################################################
# # PREPARE YOUR PROJECT DIRECTORY...                                                                                    #
# ########################################################################################################################
# ${RESET}"
# git clone https://github.com/LeoCantThinkOfAName/batch.git ./pimcore-$PROJECT

# # download docker image from dockerhub
# echo "${GREEN}
# ########################################################################################################################
# # PREPARE DOCKER IMAGE...                                                                                              #
# ########################################################################################################################
# ${RESET}"

# install composer
# install php7.0-gd
# install php7.0-pdo_mysql

options[0]="Vim (Inside container)"
options[1]="Bash (Inside container)"
options[2]="php My Admin (Extra container for phpmyadmin)"

#Actions to take based on selection
function ACTIONS {
    if [[ ${choices[0]} ]]; then
        # run apk add vim in container
        echo "Option 1 selected"
    fi
    if [[ ${choices[1]} ]]; then
        # run apk add bash in container
        echo "Option 2 selected"
    fi
    if [[ !${choices[2]} ]]; then
        # if pypmyadmin is not selected, remove php my admin from docker-compose.yml
        echo "Option 3 selected"
    fi
}

#Variables
ERROR=" "

#Clear screen for menu
printLogo

#Menu function
function MENU {
    printf "
${GREEN}#########################################################################################################################
## Install Extra Tools                                                                                                  #
#########################################################################################################################${RESET}\n\n"

    for NUM in ${!options[@]}; do
        echo "[""${choices[NUM]:- }""]" $(( NUM+1 ))" - ${options[NUM]}"
    done
    echo "$ERROR"
}

#Menu loop
while MENU && read -e -p $'\e[32mUse number key to select:\e[0m' -n1 SELECTION && [[ -n "$SELECTION" ]]; do
    printLogo
    if [[ "$SELECTION" == *[[:digit:]]* && $SELECTION -ge 1 && $SELECTION -le ${#options[@]} ]]; then
        (( SELECTION-- ))
        if [[ "${choices[SELECTION]}" == $'\033[1;31m*\033[0m' ]]; then
            choices[SELECTION]=""
        else
            choices[SELECTION]=$'\033[1;31m*\033[0m'
        fi
            ERROR=" "
    else
        ERROR="Invalid option: $SELECTION"
    fi
done

ACTIONS
