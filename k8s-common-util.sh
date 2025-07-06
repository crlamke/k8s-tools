#!/bin/bash
#Description: This file contains common functionality for K8s bash scripts
#             and is intended to be included by other scripts, not run directly.

#Variables to support common K8s/OpenShift ops
targetNS="" # Namespace to target
containerList=() # An array of container names to target
srcPath="" # The source path - the source location to find files
destPath="" # The destination path - the destination for files
fileList=() # An array containing the list of files to operate on
userConfirmationMsg="" # Message to display to user asking them to confirm operation
userConfirmed="" # Holds user response to confirmation prompt
assumeK8sConnectionBad=true # Used for script dev/test
assumeK8sConnectionGood=false # Used for script dev/test

actionSeparator="\n------------------------------\n" # Separates each action in script output
sectionSeparator="\n**********\n" # Separates each section in script output

REDTEXT="\033[31;1m"
BLUETEXT="\033[34;1m"
GREENTEXT="\033[32;1m"
YELLOWTEXT="\033[33;1m"
COLOREND="\033[0m"

# Check for an active connection to a K8s or OpenShift deployment.
# Log message and exit if no connection found.
function checkK8sConnection ()
{
  printf "Checking k8s connection\n"
  if [[ "$assumeK8sConnectionBad" = true ]]; then
    printf "\nActive connection to K8s not found.\nExiting...\n"
    exit 0
  else
    printf "\nFound active connection ...\n"
  fi
}

# Trap ctrl + c
trap ctrl_c INT
function ctrl_c()
{
  printf "\n\nctrl-c received. Exiting\n"
  exit
}

# Start with "more" as default pager, but use "less" if available.
pager="more"
if command -v less > /dev/null 2>&1; then
  pager="less"
fi

function getUserConfirmation ()
{
  printf "%s\n" "$1"
  read -p "Continue? Y/N " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    userConfirmed="true"
  else
    userConfirmed="false"
  fi
}

# The getUserConfirmation is meant to be used like this.
# getUserConfirmation
# if userConfirmed == "true" then
#   printf "Confirmed\n"
# else
#   printf "Exiting\n"
#   exit 0
# fi


# Bash check for sudo
# Check $? for the return value of this function
function checkSudo ()
{
  if [ "$EUID" -ne 0 ]
    then echo "Please run as root"
    return 1
  fi
  return 0
}

# Bash check # of arguments
# Check $? for the return value of this function
function checkArgCount ()
{
  if [[ "$#" -ne "$1" ]]; then
    echo "Invalid number of parameters"
    return 1
  fi
  return 0
}

# Check for access to K8s/DPaaS
function isK8sTokenActive()
{
	:
}


# Get current namespace/project
function getCurrentNS()
{
	:
}
