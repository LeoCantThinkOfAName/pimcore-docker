#!/bin/bash
RED='\033[0;31m]'
GREEN='\033[0;32m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
RESET='\033[0m'
LOGO="\n\n${CYAN}                       ::::::::: :::::::::::   :::   :::    ::::::::   ::::::::  :::::::::  ::::::::::
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
         ########  ########## ###    #### ########## ###    ### ###     ### ###     ########  ###    ###${RESET}\n\n\n"

printLogo() {
  # this function will print the annoy logo and keep the terminal clean (with the freakin logo of course)
  clear
  printf "${LOGO}"
}

replaceStringFromFile() {
  # this function will replace the mountpoint placeholder to user's input
  local search=$1
  local replace=$2
  local file=$3

  sed -i "s/${search}/${replace}/g" $file
}

printLogo
# prompt user for project name
read -p $'\e[32mYour Project Name: \e[0m' PROJECT

# check if folder exist
while [ -d "pimcore-$PROJECT" ]; do
    printLogo
    printf "${RED}Project already exist! Please pick another name...\n"
    read -p $'\e[32mYour Project Name: \e[0m' PROJECT
done

printLogo
read -p $'\e[32mYour Docker Mount point: \e[0m' MOUNTPOINT

printLogo
# create project folder and checkout all files from docker branch
printf "${GREEN}
########################################################################################################################
# PREPARE YOUR PROJECT DIRECTORY...                                                                                    #
########################################################################################################################
${RESET}\n"
mkdir pimcore-$PROJECT

git checkout docker -- pimcore-generator-docker/

# copy all files from branch folder to project folder, and delete it
cp -R pimcore-generator-docker/* pimcore-$PROJECT/
rm -rf pimcore-generator-docker
# clear out git commit from docker branch
git reset HEAD pimcore-generator-docker

printLogo
# download docker image from dockerhub
echo "${GREEN}
########################################################################################################################
# PREPARE DOCKER IMAGE...                                                                                              #
########################################################################################################################
${RESET}\n"

docker pull leocantthinkofaname/lemon-pimcore:latest
docker pull mysql:5.7

# cd into project folder for the rest commands
cd pimcore-$PROJECT

# replace all {PROJECT} inside docker-compose file
replaceStringFromFile "{PROJECT}" "$PROJECT" docker-compose.yml

# replace mountpoint inside docker-compose file
# but docker toolbox is just too stupid, giveup...
replaceStringFromFile "{MOUNTPOINT}" "{!!!!!!CHANGE ME!!!!!!}" docker-compose.yml


options[0]="Vim (Inside container)"
options[1]="Bash (Inside container)"
options[2]="php My Admin (Extra container for phpmyadmin)"

#Actions to take based on selection
function ACTIONS {
    if [[ ${choices[0]} ]]; then
        # uncommant vim to install
        replaceStringFromFile "# {VIM}" "" dockerfiles/web/Dockerfile
    fi
    if [[ ${choices[1]} ]]; then
        # uncommant bash to install
        replaceStringFromFile "# {BASH}" "" dockerfiles/web/Dockerfile
    fi
    if [[ ${choices[2]} ]]; then
        # uncommant phpmyadmin to pull image
        replaceStringFromFile "#" "" docker-compose.yml
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

printLogo

printf "
${GREEN}#########################################################################################################################
## Finalize install                                                                                                     #
#########################################################################################################################${RESET}\n\n"
printf "${GREEN}Your Project is ready!${RESET}\n"
printf "${GREEN}User${RESET}: admin\n"
printf "${GREEN}Password${RESET}: Aa_123456789\n"
