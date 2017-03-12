#!/bin/bash
#
# Authenticate user login for Discord

login() {
  echo -n "Please enter your email: "
  read email
  echo -n "Please enter your password: "
  read password

  response=$(curl -H 'Content-Type: application/json' \
    -X POST -d '{"email": "'$email'","password": "'$password'"}' \
    https://discordapp.com/api/auth/login)

  echo "${response}"
}

login
