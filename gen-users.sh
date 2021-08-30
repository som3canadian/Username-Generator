#!/bin/bash

### by som3canadian
# idea / bugs -> somecanadian0@gmail.com

# This is only a Version 1. Maybe more and less dirty if some stars ?

basicUserslist="userlist.txt"
newUserslist="new-userlist.txt"

# if you know the username pattern, you can change the 2 delimiters to fit your needs
# set delimiters here
delims=('.' '-' '_' '') # 4 delim for 1 name equal approx. 100 possibilities (if no multiple first name or last name)
# multiple first name delim
MNdelims=('' '-')

function checkNewlist() {
  if [[ -f $newUserslist ]]; then
    rm "$newUserslist"
    touch "$newUserslist"
  else
    touch "$newUserslist"
  fi
}

function setVAR() {
  # set first name -> John
  firstName=$(echo "$l" | cut -d "." -f1)
  # set last name -> Doe
  lastName=$(echo "$l" | cut -d "." -f2) # Doe
  ### multiple last name
  if [[ $lastName =~ "-" ]]; then
    # for now, only take the first word of the multiple last name
    lastName1Word=$(echo "$lastName" | cut -d "-" -f1)
    lastName="$lastName1Word"
  fi
  # first name lowercase -> john
  firstNameLower=$(echo "$firstName" | tr '[:upper:]' '[:lower:]')
  # last name lowercase -> doe
  lastNameLower=$(echo "$lastName" | tr '[:upper:]' '[:lower:]')
  # first name 1st character -> J
  firstName1char=${firstName:0:1}
  # first name 1st character lowercase -> j
  firstName1charLower=${firstNameLower:0:1}
  # last name 1st character -> D
  lastName1char=${lastName:0:1}
  # last name 1st character lowercase -> d
  lastName1charLower=${lastNameLower:0:1}
  # first name upper -> JOHN
  firstNameUpper=$(echo "$firstName" | tr '[:lower:]' '[:upper:]')
  # last name upper -> DOE
  lastNameUpper=$(echo "$lastName" | tr '[:lower:]' '[:upper:]')
  ### multiple first name
  if [[ $firstName =~ "-" ]]; then
    multipleFirstNameVAR
  fi
}

function multipleFirstNameVAR() {
  # multiple first name
  # Ex with -> Pierre-Michel Desjardins
  # First word
  # Pierre
  firstName1Word=$(echo "$firstName" | cut -d "-" -f1)
  # pierre
  firstName1WordLower=$(echo "$firstName1Word" | tr '[:upper:]' '[:lower:]')
  # PIERRE
  firstName1WordUpper=$(echo "$firstName1Word" | tr '[:lower:]' '[:upper:]')
  # P
  firstName1Word1char=${firstName1Word:0:1}
  # p
  firstName1Word1charLower=${firstName1WordLower:0:1}
  #
  # Second word
  # Michel
  firstName2Word=$(echo "$firstName" | cut -d "-" -f2)
  # michel
  firstName2WordLower=$(echo "$firstName2Word" | tr '[:upper:]' '[:lower:]')
  # MICHEL
  firstName2WordUpper=$(echo "$firstName2Word" | tr '[:lower:]' '[:upper:]')
  # M
  firstName2Word1char=${firstName2Word:0:1}
  # m
  firstName2Word1charLower=${firstName2WordLower:0:1}
}

function checkVAR() {
  # echo some VAR, for testing and debug
  echo "$l"
  echo "$firstName"
  echo "$lastName"
  #
  echo "$firstNameLower"
  echo "$lastNameLower"
  #
  echo "$firstName1char"
  echo "$firstName1charLower"
  echo "$lastName1char"
  echo "$lastName1charLower"
  #
  echo "$firstNameUpper"
  echo "$lastNameUpper"
}

function buildMultipleFirstNames() {
  # Ex with -> Pierre-Michel Desjardins
  #
  for MNdelim in "${MNdelims[@]}"; do
    {
      # PM.Desjardins
      echo "$firstName1Word1char$MNdelim$firstName2Word1char$delim$lastName"
      # Pm.Desjardins
      echo "$firstName1Word1char$MNdelim$firstName2Word1charLower$delim$lastName"
      # pm.Desjardins
      echo "$firstName1Word1charLower$MNdelim$firstName2Word1charLower$delim$lastName"
      # pM.Desjardins
      echo "$firstName1Word1charLower$MNdelim$firstName2Word1char$delim$lastName"
      # PierreM.Desjardins
      echo "$firstName1Word$MNdelim$firstName2Word1char$delim$lastName"
      # PMichel.Desjardins
      echo "$firstName1Word1char$MNdelim$firstName2Word$delim$lastName"
      # PIERREM.Desjardins
      echo "$firstName1WordUpper$MNdelim$firstName2Word1char$delim$lastName"
      # PMICHEL.Desjardins
      echo "$firstName1Word$MNdelim$firstName2WordUpper$delim$lastName"
      # PIERREm.Desjardins
      echo "$firstName1WordUpper$MNdelim$firstName2Word1charLower$delim$lastName"
      # pMICHEL.Desjardins
      echo "$firstName1Word1charLower$MNdelim$firstName2WordUpper$delim$lastName"
      # Pierrem.Desjardins
      echo "$firstName1Word$MNdelim$firstName2Word1charLower$delim$lastName"
      # pMichel.Desjardins
      echo "$firstName1Word1charLower$MNdelim$firstName2Word$delim$lastName"
      # pierrem.Desjardins
      echo "$firstName1WordLower$MNdelim$firstName2Word1charLower$delim$lastName"
      # pierrem
      echo "$firstName1WordLower$MNdelim$firstName2Word1charLower"
      # Pierrem
      echo "$firstName1Word$MNdelim$firstName2Word1charLower"
      # pmichel.Desjardins
      echo "$firstName1Word1charLower$MNdelim$firstName2WordLower$delim$lastName"
      # pmichel
      echo "$firstName1Word1charLower$MNdelim$firstName2WordLower"
      # pierreM.Desjardins
      echo "$firstName1WordLower$MNdelim$firstName2Word1char$delim$lastName"
      # Pmichel.Desjardins
      echo "$firstName1Word1char$MNdelim$firstName2WordLower$delim$lastName"
      # Pierre.Desjardins
      echo "$firstName1Word$delim$lastName"
      # pierre.Desjardins
      echo "$firstName1WordLower$delim$lastName"
      # PIERRE.Desjardins
      echo "$firstName1WordUpper$delim$lastName"
      # Michel.Desjardins
      echo "$firstName2Word$delim$lastName"
      # michel.Desjardins
      echo "$firstName2WordLower$delim$lastName"
      # MICHEL.Desjardins
      echo "$firstName2WordUpper$delim$lastName"
    } >>"$newUserslist"
  done
}

function buildNewList() {
  {
    echo "$l"
    #
    echo "$firstName"
    echo "$firstNameLower"
    echo "$firstNameUpper"
    #
    echo "$firstName$delim$lastNameLower"
    echo "$firstName$delim$lastName1char"
    echo "$firstName$delim$lastName1charLower"
    echo "$firstName$delim$lastNameUpper"
    #
    echo "$firstNameLower$delim$lastName"
    echo "$firstNameLower$delim$lastNameLower"
    echo "$firstNameLower$delim$lastName1char"
    echo "$firstNameLower$delim$lastName1charLower"
    echo "$firstNameLower$delim$lastNameUpper"
    #
    echo "$firstName1char$delim$lastName"
    echo "$firstName1char$delim$lastNameLower"
    echo "$firstName1char$delim$lastName1char"
    echo "$firstName1char$delim$lastName1charLower"
    echo "$firstName1char$delim$lastNameUpper"
    #
    echo "$firstName1charLower$delim$lastName"
    echo "$firstName1charLower$delim$lastNameLower"
    echo "$firstName1charLower$delim$lastName1char"
    echo "$firstName1charLower$delim$lastName1charLower"
    echo "$firstName1charLower$delim$lastNameUpper"
    #
    echo "$firstNameUpper$delim$lastName"
    echo "$firstNameUpper$delim$lastNameLower"
    echo "$firstNameUpper$delim$lastName1char"
    echo "$firstNameUpper$delim$lastName1charLower"
    echo "$firstNameUpper$delim$lastNameUpper"
  } >>"$newUserslist"
  ### noms composés
  if [[ $firstName =~ "-" ]]; then
    buildMultipleFirstNames
  fi
}

function doLoop() {
  while read l; do
    setVAR
    ## checkVAR
    for delim in "${delims[@]}"; do
      buildNewList
    done
  done <"$basicUserslist"
  sort -f -k 1.1,1.1 "$newUserslist" | uniq > newlisttemp.txt
  rm "$newUserslist"
  mv newlisttemp.txt "$newUserslist"
}

function doubleCheckList() {
  # count for testing and debug
  /bin/cat "$newUserslist"
  echo ""
  sort "$newUserslist" | wc -l
  sort "$newUserslist" | uniq | wc -l
}

function doFunctions() {
  checkNewlist
  doLoop
  # doubleCheckList
}
doFunctions
