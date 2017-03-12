#!/bin/bash
#
# Authenticate user login for Discord

parse_response() {
  local json=$1

  local key
  local value
  
  key=$(echo "${json}" | sed 's/{//;s/}//;s/"//g;s/ //' | awk -F: '{print $1}')
  value=$(echo "${json}" | sed 's/{//;s/}//;s/"//g;s/\[//;s/\]//;s/ //' | awk -F: '{print $2}')

  if [[ $key == "token" ]]; then
    echo "${value}"
  else
    echo "ERROR: ${value}" 1>&2
    exit 1
  fi
}

login() {
  echo -n "Please enter your email: "
  read email
  echo -n "Please enter your password: "
  read password

  local response
  response=$(curl -H 'Content-Type: application/json' \
    -X POST -d '{"email": "'$email'","password": "'$password'"}' \
    https://discordapp.com/api/auth/login)

  parse_response "${response}"
}

login
